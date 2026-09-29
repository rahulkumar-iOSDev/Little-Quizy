//
//  Subject.swift
//  Little Quizzy
//
//  Created by Rahul Kumar on 29/09/26.
//

import Foundation
import SwiftUI

struct Subject: Identifiable {
    let id = UUID()
    let name: String
    let emoji: String
    let color: Color
}

extension Subject {
    static let mockSubject: [Subject] = [
        Subject(
            name: "Maths",
            emoji: "🧮",
            color: Color.blue.opacity(0.15)
        ),
        Subject(
            name: "English",
            emoji: "📖",
            color: Color.pink.opacity(0.15)
        ),
        Subject(
            name: "Science",
            emoji: "🧪",
            color: Color.green.opacity(0.15)
        ),
        Subject(
            name: "Social Studies",
            emoji: "🌎",
            color: Color.yellow.opacity(0.25)
        ),
        Subject(
            name: "Hindi",
            emoji: "अ",
            color: Color.purple.opacity(0.15)
        ),
        Subject(
            name: "GK",
            emoji: "💡",
            color: Color.cyan.opacity(0.15)
        )
    ]
}



