//
//  QuizResponse.swift
//  Little Quizzy
//
//  Created by Rahul Kumar on 29/09/26.
//

import Foundation

enum QuizMode {
    case random
    case subject(Subject)
}

enum Subject: String, Codable, CaseIterable, Identifiable {
    case maths = "Maths"
    case science = "Science"
    case english = "English"
    case socialStudies = "Social Studies"
    case hindi = "Hindi"
    case gk = "GK"

    var id: String { rawValue }
    var title: String { rawValue.capitalized }
}

enum Difficulty: String, Codable {
    case easy, medium, hard
}

struct Option: Codable, Identifiable, Hashable {
    let id: String
    let text: String
    let isAnswer: Bool
    var isAnswered: Bool = false          // runtime state, not in JSON

    private enum CodingKeys: String, CodingKey {
        case id, text, isAnswer
    }
}

struct Question: Codable, Identifiable, Hashable {
    let id: String
    let subject: Subject
    let difficulty: Difficulty
    let classLevel: Int
    let question: String
    var options: [Option]

    private enum CodingKeys: String, CodingKey {
        case id, subject, difficulty, question, options
        case classLevel = "class"         // "class" is a Swift keyword
    }
}

struct QuestionBank: Codable {
    let questions: [Question]
}
