//
//  QuizResultViewModel.swift
//  Little Quizzy
//
//  Created by Rahul Kumar on 07/10/26.
//

import Foundation
import Observation
import SwiftUI

@Observable
final class QuizResultViewModel {
    let correctAnswers: Int
    let totalQuestions: Int
    let quizMode: QuizMode
    var displayedCorrectAnswers = 0

    init(correctAnswers: Int, totalQuestions: Int, quizMode: QuizMode) {
        let safeTotalQuestions = max(totalQuestions, 0)
        self.totalQuestions = safeTotalQuestions
        self.correctAnswers = min(max(correctAnswers, 0), safeTotalQuestions)
        self.quizMode = quizMode
    }

    var percentage: Int {
        guard totalQuestions > 0 else {
            return 0
        }
        let calculatedPercentage = (Double(correctAnswers) / Double(totalQuestions)) * 100
        return min(max(Int(calculatedPercentage), 0), 100)
    }

    var incorrectAnswers: Int {
        totalQuestions - correctAnswers
    }

    var resultTitle: String {
        switch percentage {
        case 80...100:
            return "Excellent! 🎉"
        case 60..<80:
            return "Great Job! 👏"
        case 40..<60:
            return "Good Try! 💪"
        default:
            return "Keep Practicing! 🌱"
        }
    }

    var resultColor: Color {
        switch percentage {
        case 80...100:
            return .appSuccessGreen
        case 60..<80:
            return .appPrimaryBlue
        case 40..<60:
            return .appYellow
        default:
            return .appErrorRed
        }
    }
}
