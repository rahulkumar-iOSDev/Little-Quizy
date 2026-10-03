//
//  QuizView.swift
//  Little Quizzy
//
//  Created by Rahul Kumar on 29/09/26.
//

import SwiftUI

struct QuizView: View {
    
    @Environment(Router.self) private var router
    @State private var viewModel: QuizViewModel
    private var navTitle: String
    
    init(navTitle: String, mode: QuizMode, numberOfQuestions: Int = 5) {
        self.navTitle = navTitle
        _viewModel = State(initialValue: QuizViewModel(quizMode: mode))
    }
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 16) {
                QuizProgressView(
                    currentQuestion: viewModel.currentNumber,
                    totalQuestions: max(viewModel.totalQuestions, 1)
                )
                .frame(height: 6)
                
                if let question = viewModel.currentQuestion {
                    Text(question.question)
                        .fontWeight(.bold)
                        .fixedSize(horizontal: false, vertical: true)
                        .font(.title)
                        .padding(.vertical)
                    
                    
                    ForEach(Array(question.options.enumerated()), id: \.element.id) { index, option in
                        OptionCell(
                            label: String(UnicodeScalar(UInt8(65 + index))),   // A, B, C, D
                            option: option,
                            isLocked: viewModel.isLocked
                        ) {
                            viewModel.select(option)
                        }
                    }
                }
                
                Spacer()
                
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
            ToolbarItem(placement: .topBarTrailing) {
                Text("\(viewModel.currentNumber)/\(viewModel.totalQuestions)")
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

#Preview {
    NavigationStack {
        QuizView(navTitle: "Quiz", mode: .random)
    }
}

private struct QuizProgressView: View {
    let currentQuestion: Int
    let totalQuestions: Int
    private var progress: CGFloat {
        CGFloat(currentQuestion) / CGFloat(totalQuestions)
    }
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(.appPrimaryBlue.opacity(0.2))
                
                Capsule()
                    .fill(.appPrimaryBlue)
                    .frame(
                        width: geometry.size.width * progress
                    )
            }
        }
    }
}

struct OptionCell: View {
    let label: String
    let option: Option
    let isLocked: Bool
    let onTap: () -> Void
    
    private enum State { case idle, correct, wrong }
    
    private var state: State {
        guard isLocked else { return .idle }
        if option.isAnswer { return .correct }              // always reveal correct one
        if option.isAnswered { return .wrong }              // the wrong one the user tapped
        return .idle
    }
    
    private var borderColor: Color {
        switch state {
        case .idle:    return Color(.systemGray5)
        case .correct: return Color.appSuccessGreen.opacity(0.8)
        case .wrong:   return Color.appErrorRed.opacity(0.8)
        }
    }
    
    private var backgroundColor: Color {
        switch state {
        case .idle:    return .white
        case .correct: return Color.appSuccessGreen.opacity(0.08)
        case .wrong:   return Color.appErrorRed.opacity(0.08)
        }
    }
    
    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 8) {
                Text("\(label). \(option.text)")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(Color(red: 0.12, green: 0.14, blue: 0.2))
                
                switch state {
                case .correct:
                    Image(systemName: "checkmark")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.appSuccessGreen)
                case .wrong:
                    Image(systemName: "xmark")
                        .font(.system(size: 18, weight: .heavy))
                        .foregroundColor(.appErrorRed)
                case .idle:
                    EmptyView()
                }
                
                Spacer()
            }
            .padding(.horizontal, 20)
            .frame(height: 60)
            .background(backgroundColor)
            .overlay(
                RoundedRectangle(cornerRadius: 18)
                    .stroke(borderColor, lineWidth: 2.5)
            )
            .clipShape(RoundedRectangle(cornerRadius: 18))
        }
        .buttonStyle(.plain)
        .disabled(isLocked)
        .animation(.easeInOut(duration: 0.2), value: isLocked)
    }
}
