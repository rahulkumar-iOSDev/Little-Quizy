//
//  ProfileViewModel.swift
//  Little Quizzy
//
//  Created by Rahul Kumar on 07/10/26.
//

import Foundation
import Observation
import SwiftData

@MainActor
@Observable
final class ProfileViewModel {
    var totalScore = 0
    var totalQuestions = 0
    var subjects: [SubjectScore] = []
    var updatedName = UserDefaults.standard.string(forKey: AppStorageKey.userName) ?? ""
    var selectedClass = UserDefaults.standard.object(forKey: AppStorageKey.selectedClass) as? Int ?? 1
    var showUpdateName = false
    var showUpdateClass = false
    var showDeleteConfirmation = false
    var showSettings = false
    var errorMessage: String?

    func updateScores(from attempts: [QuestionAttempt]) {
        totalScore = attempts.filter(\.isCorrect).count
        totalQuestions = attempts.count
        subjects = Subject.allCases.map { subject in
            let subjectAttempts = attempts.filter { $0.subject == subject }
            let correctAnswers = subjectAttempts.filter(\.isCorrect).count
            let percentage = subjectAttempts.isEmpty ? 0 : Int((Double(correctAnswers) / Double(subjectAttempts.count) * 100).rounded())
            return SubjectScore(subject: subject, score: percentage)
        }
    }

    
    func saveName() {
        let name = updatedName.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !name.isEmpty else {
            errorMessage = "Name cannot be empty."
            return
        }
        errorMessage = nil
        UserDefaults.standard.set(name, forKey: AppStorageKey.userName)
        updatedName = name
        showUpdateName = false
    }

    func saveClass() {
        UserDefaults.standard.set(selectedClass, forKey: AppStorageKey.selectedClass)
        showUpdateClass = false
    }

    func deleteScoreResults(modelContext: ModelContext) {
        do {
            let questionAttempts = try modelContext.fetch(FetchDescriptor<QuestionAttempt>())
            let quizAttempts = try modelContext.fetch(FetchDescriptor<QuizAttempt>())
            for attempt in questionAttempts {
                modelContext.delete(attempt)
            }
            for attempt in quizAttempts {
                modelContext.delete(attempt)
            }
            try modelContext.save()
            totalScore = 0
            totalQuestions = 0
            subjects = []
            showDeleteConfirmation = false
        } catch {
            errorMessage = "Unable to delete score results. Please try again."
        }
    }
}
