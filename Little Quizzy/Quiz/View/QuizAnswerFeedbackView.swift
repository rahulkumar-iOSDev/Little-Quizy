//
//  QuizAnswerFeedbackView.swift
//  Little Quizzy
//
//  Created by Rahul Kumar on 07/10/26.
//

import SwiftUI

struct QuizAnswerFeedbackView: View {
    var isCorrect: Bool
    var body: some View {
        HStack {
            Spacer()
            Text(isCorrect ? "⭐️" : "❌")
            Text(
                isCorrect
                ? "Correct! Well Done!"
                : "Incorrect! Try Again."
            )

            Spacer()
        }
        .font(.title2)
        .fontWeight(.semibold)
        .foregroundStyle(
            isCorrect
            ? Color.appSuccessGreen
            : Color.appErrorRed
        )
    }
}
#Preview {
    QuizAnswerFeedbackView(isCorrect: true)
}
