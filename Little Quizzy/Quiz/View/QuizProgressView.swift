//
//  QuizProgressView.swift
//  Little Quizzy
//
//  Created by Rahul Kumar on 07/10/26.
//

import SwiftUI

struct QuizProgressView: View {
    let currentQuestion: Int
    let totalQuestions: Int

    private var progress: CGFloat {
        CGFloat(currentQuestion) / CGFloat(totalQuestions)
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Capsule()
                    .fill( .appPrimaryBlue.opacity(0.2) )

                Capsule()
                    .fill(.appPrimaryBlue)
                    .frame( width: geometry.size.width * progress )
            }
        }
    }
}
#Preview {
    QuizProgressView(currentQuestion: 2, totalQuestions: 5)
}
