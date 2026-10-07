//
//  QuizView.swift
//  Little Quizzy
//
//  Created by Rahul Kumar on 29/09/26.
//

import SwiftUI

struct QuizView: View {
    @Environment(AppRouter.self) private var router
    @State private var viewModel: QuizViewModel
    private var navTitle: String

    init( navTitle: String, mode: QuizMode, numberOfQuestions: Int = 5 ) {
        self.navTitle = navTitle
        _viewModel = State( initialValue: QuizViewModel( quizMode: mode ) )
    }

    var body: some View {
        ScrollView(.vertical) {
            VStack( alignment: .leading, spacing: 16 ) {
                QuizProgressView( currentQuestion: viewModel.currentNumber, totalQuestions: max( viewModel.totalQuestions, 1 ) )
                .frame(height: 6)

                if let question = viewModel.currentQuestion {
                    Text(question.question)
                        .fontWeight(.bold)
                        .fixedSize( horizontal: false, vertical: true )
                        .font(.title)
                        .padding(.vertical)

                    ForEach(Array(question.options.enumerated()),id: \.element.id) { index, _ in
                        OptionCell(label: String(UnicodeScalar(UInt8(65 + index))),
                                   question: question,
                                   optionIndex: index,
                                   isLocked: viewModel.isLocked,
                                   selectedOptionID: viewModel.selectedOptionID ) {
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
                popView()
            }
        }
        .scrollBounceBehavior(.basedOnSize)
        .onAppear {
            if viewModel.questions.isEmpty {
                viewModel.getQuizQuestions()
            }
        }
        .toolbar {
            ToolbarItem( placement: .topBarTrailing ) {
                Text( "\(viewModel.currentNumber)/\(viewModel.totalQuestions)" )
            }
        }
        .appScreenStyle()
        .navigationTitle(navTitle)
        .navigationBarTitleDisplayMode(.inline)
    }

    private func popView() {
        switch viewModel.quizMode {
        case .random:
            router.random.pop()

        case .subject(_):
            router.subject.pop()
        }
    }
}

#Preview() {
    @Previewable @State var appRouter = AppRouter()
    NavigationStack {
        QuizView(navTitle: "Quiz", mode: .random)
            .environment(appRouter)
    }
}
