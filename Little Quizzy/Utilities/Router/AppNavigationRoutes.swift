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
}

struct SubjectRouteView: View {
    let route: SubjectRoute
    var body: some View {
        switch route {
        case .subjectQuizView(let subject, let navTitle):
            QuizView(navTitle: navTitle, mode: .subject(subject))
        }
    }
}

// MARK: - Subject Tab Route
enum RandomRoute: Hashable {
    case randomQuiz(String)
}

struct RandomRouteView: View {
    let route: RandomRoute
    var body: some View {
        switch route {
        case .randomQuiz(let navTitle):
            QuizView(navTitle: navTitle, mode: .random)
        }
    }
}

// MARK: - Subject Tab Route
enum ProfileRoute: Hashable {
    case editProfile
}

struct ProfileRouteView: View {
    let route: ProfileRoute
    var body: some View {
        switch route {
        case .editProfile:
            EditProfileView()
        }
    }
}



