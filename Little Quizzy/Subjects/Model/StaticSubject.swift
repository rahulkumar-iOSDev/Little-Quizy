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
    let name: Subject
    let emoji: String
    let color: Color
}

extension StaticSubject {
    static let mockSubject: [StaticSubject] = [
        StaticSubject(
            name: .maths,
            emoji: "🧮",
            color: Color.blue.opacity(0.15)
        ),
        StaticSubject(
            name: .english,
            emoji: "📖",
            color: Color.pink.opacity(0.15)
        ),
        StaticSubject(
            name: .science,
            emoji: "🧪",
            color: Color.green.opacity(0.15)
        ),
        StaticSubject(
            name: .socialStudies,
            emoji: "🌎",
            color: Color.yellow.opacity(0.25)
        ),
        StaticSubject(
            name: .hindi,
            emoji: "अ",
            color: Color.purple.opacity(0.15)
        ),
        StaticSubject(
            name: .gk,
            emoji: "💡",
            color: Color.cyan.opacity(0.15)
        )
    ]
}



