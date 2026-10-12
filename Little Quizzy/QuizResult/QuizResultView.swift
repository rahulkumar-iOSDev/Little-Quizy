//
//  QuizResultView.swift
//  Little Quizzy
//
//  Created by Rahul Kumar on 07/10/26.
//

import SwiftUI

struct QuizResultView: View {
    @Environment(AppRouter.self) private var router
    @State private var viewModel: QuizResultViewModel
    @State private var showHeader = false
    @State private var animateScore = false
    @State private var showAnswerCount = false
    @State private var showButton = false

    init(correctAnswers: Int, totalQuestions: Int, quizMode: QuizMode) {
        _viewModel = State(initialValue: QuizResultViewModel(correctAnswers: correctAnswers, totalQuestions: totalQuestions, quizMode: quizMode))
    }

    var body: some View {
        VStack(spacing: 28) {
            Spacer()
            VStack(spacing: 8) {
                Text("Quiz Complete!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(viewModel.resultColor)
                Text(viewModel.resultTitle)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(viewModel.resultColor)
            }
            .opacity(showHeader ? 1 : 0)
            .offset(y: showHeader ? 0 : 18)
            scoreCircle
                .scaleEffect(animateScore ? 1 : 0.85)
                .opacity(animateScore ? 1 : 0)
            VStack(spacing: 6) {
                Text("\(viewModel.displayedCorrectAnswers) / \(viewModel.totalQuestions)")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(viewModel.resultColor)
                    .contentTransition(.numericText())
                Text("Correct Answers")
                    .foregroundStyle(.secondary)
            }
            .opacity(showAnswerCount ? 1 : 0)
            .offset(y: showAnswerCount ? 0 : 12)
            Spacer()
            Button {
                goToProfileTab()
            } label: {
                Text("Done")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(ResultButtonStyle(color: viewModel.resultColor))
            .padding(.horizontal)
            .opacity(showButton ? 1 : 0)
            .offset(y: showButton ? 0 : 15)
            Spacer()
        }
        .padding()
        .appScreenStyle()
        .navigationBarBackButtonHidden()
        .toolbar(.hidden, for: .tabBar)
        .onAppear {
            startAnimation()
        }
    }

    private var scoreCircle: some View {
        ZStack {
            Circle()
                .stroke(viewModel.resultColor.opacity(0.15), lineWidth: 18)
            Circle()
                .trim(
                    from: 0,
                    to: animateScore
                        ? CGFloat(viewModel.percentage) / 100
                        : 0
                )
                .stroke(
                    viewModel.resultColor,
                    style: StrokeStyle(lineWidth: 18, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
            VStack(spacing: 4) {
                Text("\(viewModel.percentage)%")
                    .font(.system(size: 42, weight: .bold))
                    .foregroundStyle(viewModel.resultColor)
                Text("Score")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
        .frame(width: 190, height: 190)
    }

    private func startAnimation() {
        withAnimation(.easeOut(duration: 0.55)) {
            showHeader = true
        }
        withAnimation(.spring(response: 0.8, dampingFraction: 0.75).delay(0.2)) {
            animateScore = true
        }
        withAnimation(.easeOut(duration: 0.45).delay(0.55)) {
            showAnswerCount = true
        }
        animateCorrectAnswers()
        withAnimation(.easeOut(duration: 0.45).delay(0.9)) {
            showButton = true
        }
    }

    private func animateCorrectAnswers() {
        let finalCorrectAnswers = viewModel.correctAnswers
        guard finalCorrectAnswers > 0 else {
            return
        }
        let duration = 0.8
        let stepDuration = duration / Double(finalCorrectAnswers)
        for step in 1...finalCorrectAnswers {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.55 + stepDuration * Double(step)) {
                withAnimation(.easeOut(duration: 0.15)) {
                    viewModel.displayedCorrectAnswers = step
                }
            }
        }
    }

    private func goToProfileTab() {
        switch viewModel.quizMode {
        case .random:
            router.random.removeAll()
        case .subject:
            router.subject.removeAll()
        }
        router.selectedTab = .profile
    }
}

#Preview {
    @Previewable @State var appRouter = AppRouter()
    QuizResultView(correctAnswers: 3, totalQuestions: 5, quizMode: .random)
        .environment(appRouter)
}
