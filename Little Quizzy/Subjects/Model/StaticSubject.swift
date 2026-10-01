//
//  Subject.swift
//  Little Quizzy
//
//  Created by Rahul Kumar on 29/09/26.
//

import Foundation
import SwiftUI

struct StaticSubject: Identifiable {
    let id = UUID()
    let name: String
    let emoji: String
    let color: Color
}

extension StaticSubject {
    static let mockSubject: [StaticSubject] = [
        StaticSubject(
            name: "Maths",
            emoji: "🧮",
            color: Color.blue.opacity(0.15)
        ),
        StaticSubject(
            name: "English",
            emoji: "📖",
            color: Color.pink.opacity(0.15)
        ),
        StaticSubject(
            name: "Science",
            emoji: "🧪",
            color: Color.green.opacity(0.15)
        ),
        StaticSubject(
            name: "Social Studies",
            emoji: "🌎",
            color: Color.yellow.opacity(0.25)
        ),
        StaticSubject(
            name: "Hindi",
            emoji: "अ",
            color: Color.purple.opacity(0.15)
        ),
        StaticSubject(
            name: "GK",
            emoji: "💡",
            color: Color.cyan.opacity(0.15)
        )
    ]
}



