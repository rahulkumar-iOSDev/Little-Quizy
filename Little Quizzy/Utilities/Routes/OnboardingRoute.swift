//
//  OnboardingRoute.swift
//  Little Quizzy
//
//  Created by Rahul Kumar on 18/09/26.
//

import Foundation
import SwiftUI

enum OnboardingRoute {
    case startQuiz
    case randomQuizView
}

extension OnboardingRoute: Hashable {

}

extension OnboardingRoute: View {
    var body: some View {
        switch self {
        case .startQuiz:
            StartQuizView()
        case .randomQuizView:
            QuizView(mode: .random)
        }
    }
}
