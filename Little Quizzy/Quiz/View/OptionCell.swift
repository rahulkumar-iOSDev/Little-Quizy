//
//  OptionCell.swift
//  Little Quizzy
//
//  Created by Rahul Kumar on 07/10/26.
//

import SwiftUI

struct OptionCell: View {
    let label: String
    let question: Question
    let optionIndex: Int
    let isLocked: Bool
    let selectedOptionID: String?
    let action: () -> Void

    private var option: Option {
        question.options[optionIndex]
    }

    private enum State {
        case idle
        case correct
        case wrong
    }

    private var state: State {
        guard question.isAnswered else {
            return .idle
        }

        // Correct answer is always revealed after answering.
        if option.isAnswer {
            return .correct
        }

        // Only the option the user selected can be wrong.
        if option.id == selectedOptionID {
            return .wrong
        }

        return .idle
    }

    var body: some View {
        Button {
            action()
        } label: {
            HStack(spacing: 12) {
                Text(label)
                    .font(.title2)
                    .fontWeight(.bold)

                Text(option.text)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)

                Spacer()

                switch state {
                case .idle:
                    EmptyView()

                case .correct:
                    Image(systemName: "checkmark")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(
                            Color.appSuccessGreen
                        )

                case .wrong:
                    Image(systemName: "xmark")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(
                            Color.appErrorRed
                        )
                }
            }
            .padding(.horizontal, 24)
            .frame(maxWidth: .infinity, minHeight: 60)
            .background(backgroundColor)
            .overlay {
                RoundedRectangle(cornerRadius: 18)
                    .stroke(borderColor, lineWidth: 4)
            }
            .clipShape(
                RoundedRectangle(cornerRadius: 18)
            )
            .contentShape(RoundedRectangle(cornerRadius: 18))
        }
        .buttonStyle(.plain)
        .disabled(isLocked)
    }

    private var backgroundColor: Color {
        switch state {
        case .idle:
            return Color.clear

        case .correct:
            return Color.appSuccessGreen.opacity(0.08)

        case .wrong:
            return Color.appErrorRed.opacity(0.08)
        }
    }

    private var borderColor: Color {
        switch state {
        case .idle:
            return Color.gray.opacity(0.15)

        case .correct:
            return Color.appSuccessGreen

        case .wrong:
            return Color.appErrorRed
        }
    }
}

#Preview("Idle") {
    OptionCell(
        label: "A",
        question: PreviewData.question,
        optionIndex: 0,
        isLocked: false,
        selectedOptionID: nil,
        action: {}
    )
    .padding()
}

#Preview("Correct") {
    OptionCell(
        label: "B",
        question: PreviewData.answeredQuestion,
        optionIndex: 1,
        isLocked: true,
        selectedOptionID: "2",
        action: {}
    )
    .padding()
}

#Preview("Wrong") {
    OptionCell(
        label: "A",
        question: PreviewData.answeredQuestion,
        optionIndex: 0,
        isLocked: true,
        selectedOptionID: "1",
        action: {}
    )
    .padding()
}

private enum PreviewData {

    static let question = Question(
        id: "preview-question-1",
        subject: .maths,
        difficulty: .easy,
        classLevel: 5,
        question: "What is 7 + 5?",
        options: [
            Option(
                id: "1",
                text: "10",
                isAnswer: false
            ),
            Option(
                id: "2",
                text: "12",
                isAnswer: true
            ),
            Option(
                id: "3",
                text: "13",
                isAnswer: false
            ),
            Option(
                id: "4",
                text: "14",
                isAnswer: false
            )
        ]
    )

    static var answeredQuestion: Question {
        var question = question
        question.isAnswered = true
        return question
    }
}
