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
}

extension OnboardingRoute: Hashable {
//    
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(self.hashValue)
//    }
//    
//    static func == (lhs: OnboardingRoute, rhs: OnboardingRoute) -> Bool {
//        switch (lhs, rhs) {
//        case
//            (.startQuiz, .startQuiz):
//            return true
//        default:
//            return false
//        }
//    }
}

extension OnboardingRoute: View {
    var body: some View {
        switch self {
        case .startQuiz:
            StartQuizView()
        }
    }
}
