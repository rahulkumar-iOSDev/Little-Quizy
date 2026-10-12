//
//  QuizView.swift
//  Little Quizzy
//
//  Created by Rahul Kumar on 29/09/26.
//

import SwiftUI
import SwiftData

struct QuizView: View {
    @Environment(AppRouter.self) private var router
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel: QuizViewModel?
    private let navTitle: String
    private let mode: QuizMode
    private let numberOfQuestions: Int
    private let selectedClass: Int

    init(navTitle: String, mode: QuizMode, numberOfQuestions: Int = 5) {
        self.navTitle = navTitle
        self.mode = mode
        self.numberOfQuestions = numberOfQuestions
        self.selectedClass = UserDefaults.standard.object(forKey: AppStorageKey.selectedClass) as? Int ?? 1
    }

    var body: some View {
        Group {
            if let viewModel {
                quizContent(viewModel)
            } else {
                ProgressView()
            }
        }
        .task {
            guard viewModel == nil else { return }
            let newViewModel = QuizViewModel(quizMode: mode, selectedClass: selectedClass, modelContext: modelContext)
            newViewModel.getQuizQuestions(numberOfQuestions: numberOfQuestions)
            viewModel = newViewModel
        }
    }

    private func quizContent(_ viewModel: QuizViewModel) -> some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 16) {
                QuizProgressView(currentQuestion: viewModel.currentNumber, totalQuestions: max(viewModel.totalQuestions, 1))
                    .frame(height: 6)
                if let question = viewModel.currentQuestion {
                    Text(question.question)
                        .fontWeight(.bold)
                        .fixedSize(horizontal: false, vertical: true)
                        .font(.title)
                        .padding(.vertical)
                    ForEach(Array(question.options.enumerated()), id: \.element.id) { index, _ in
                        OptionCell(label: String(UnicodeScalar(UInt8(65 + index))), question: question, optionIndex: index, isLocked: viewModel.isLocked, selectedOptionID: viewModel.selectedOptionID) {
                            viewModel.select(question.options[index])
                        }
                    }
                }
                Spacer()
                if viewModel.currentQuestion?.isAnswered == true {
                    QuizAnswerFeedbackView(isCorrect: viewModel.isItCorrectAnswer)
                }
                if viewModel.isLocked {
                    Button {
                        viewModel.goToNext()
                    } label: {
                        Text(viewModel.isLastQuestion ? "Finish" : "Next")
                    }
                    .buttonStyle(PrimaryButtonStyle())
                }
            }
        }
        .onChange(of: viewModel.isFinished) { _, finished in
            if finished {
                goToQuizResultView(viewModel)
            }
        }
        .scrollBounceBehavior(.basedOnSize)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Text("\(viewModel.currentNumber)/\(viewModel.totalQuestions)")
            }
        }
        .appScreenStyle()
        .navigationTitle(navTitle)
        .navigationBarTitleDisplayMode(.inline)
    }

    private func goToQuizResultView(_ viewModel: QuizViewModel) {
        switch viewModel.quizMode {
        case .random:
            router.random.push(.quizResultView(viewModel.correctedAnswer, viewModel.totalQuestions, viewModel.quizMode))
        case .subject:
            router.subject.push(.quizResultView(viewModel.correctedAnswer, viewModel.totalQuestions, viewModel.quizMode))
        }
    }
}

#Preview {
    @Previewable @State var appRouter = AppRouter()
    NavigationStack {
        QuizView(navTitle: "Quiz", mode: .random)
            .environment(appRouter)
    }
    .modelContainer(for: [QuizAttempt.self, QuestionAttempt.self])
}
