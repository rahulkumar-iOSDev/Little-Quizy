//
//  AppNavigationRoutes.swift
//  Little Quizzy
//
//  Created by Rahul Kumar on 18/09/26.
//

import Foundation
import SwiftUI

// MARK: - Onboarding Route
enum OnboardingRoute: Hashable {
    case startQuiz
}

struct OnboardingRouteView: View {
    let route: OnboardingRoute
    var body: some View {
        switch route {
        case .startQuiz: StartQuizView()
        }
    }
}

// MARK: - Subject Tab Route
enum SubjectRoute: Hashable {
    case subjectQuizView(Subject, String)
    case quizResultView(Int, Int, QuizMode)
}

struct SubjectRouteView: View {
    let route: SubjectRoute
    var body: some View {
        switch route {
        case .subjectQuizView(let subject, let navTitle):
            QuizView(navTitle: navTitle, mode: .subject(subject))
        case .quizResultView(let answer, let question, let quizMode):
            QuizResultView(correctAnswers: answer, totalQuestions: question, quizMode: quizMode)
        }
    }
}

// MARK: - Random Tab Route
enum RandomRoute: Hashable {
    case randomQuiz(String)
    case quizResultView(Int, Int, QuizMode)
}

struct RandomRouteView: View {
    let route: RandomRoute
    var body: some View {
        switch route {
        case .randomQuiz(let navTitle):
            QuizView(navTitle: navTitle, mode: .random)
        case .quizResultView(let answer, let question, let quizMode):
            QuizResultView(correctAnswers: answer, totalQuestions: question, quizMode: quizMode)
        }
    }
}

// MARK: - Profile Tab Route
enum ProfileRoute: Hashable {
    case emptyView
}

struct ProfileRouteView: View {
    let route: ProfileRoute
    var body: some View {
        switch route {
        case .emptyView:
            EmptyView()
        }
    }
}



