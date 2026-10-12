//
//  SubjectScore.swift
//  Little Quizzy
//
//  Created by Rahul Kumar on 07/10/26.
//

import Foundation

struct SubjectScore: Identifiable {
    let id = UUID()
    let subject: Subject
    let score: Int
}
