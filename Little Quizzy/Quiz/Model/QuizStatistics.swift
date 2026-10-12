//
//  QuizStatistics.swift
//  Little Quizzy
//
//  Created by Rahul Kumar on 07/10/26.
//

import Foundation
import SwiftData

@Model
final class QuizAttempt {
    @Attribute(.unique) var id: UUID
    var quizMode: String
    var startedAt: Date
    var completedAt: Date?
    @Relationship(deleteRule: .cascade, inverse: \QuestionAttempt.quizAttempt) var questionAttempts: [QuestionAttempt]

    init(quizMode: QuizMode) {
        self.id = UUID()
        switch quizMode {
        case .random:
            self.quizMode = "random"
        case .subject(let subject):
            self.quizMode = "subject:\(subject.rawValue)"
        }
        self.startedAt = Date()
        self.completedAt = nil
        self.questionAttempts = []
    }

    var totalQuestions: Int {
        questionAttempts.count
    }

    var correctAnswers: Int {
        questionAttempts.filter(\.isCorrect).count
    }

    var incorrectAnswers: Int {
        totalQuestions - correctAnswers
    }

    var score: Int {
        correctAnswers
    }

    var percentage: Double {
        guard totalQuestions > 0 else { return 0 }
        return Double(correctAnswers) / Double(totalQuestions) * 100
    }

    func addQuestionAttempt(questionID: String, subject: Subject, isCorrect: Bool, selectedOptionID: String?) {
        let questionAttempt = QuestionAttempt(questionID: questionID, subject: subject, isCorrect: isCorrect, selectedOptionID: selectedOptionID, quizAttempt: self)
        questionAttempts.append(questionAttempt)
    }

    func complete() {
        completedAt = Date()
    }
}

@Model
final class QuestionAttempt {
    @Attribute(.unique) var id: UUID
    var questionID: String
    var subjectRawValue: String
    var isCorrect: Bool
    var selectedOptionID: String?
    var answeredAt: Date
    var quizAttempt: QuizAttempt?

    init(questionID: String, subject: Subject, isCorrect: Bool, selectedOptionID: String?, quizAttempt: QuizAttempt? = nil) {
        self.id = UUID()
        self.questionID = questionID
        self.subjectRawValue = subject.rawValue
        self.isCorrect = isCorrect
        self.selectedOptionID = selectedOptionID
        self.answeredAt = Date()
        self.quizAttempt = quizAttempt
    }

    var subject: Subject? {
        Subject(rawValue: subjectRawValue)
    }

    var score: Int {
        isCorrect ? 1 : 0
    }
}
