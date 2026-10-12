//
//  QuizViewModel.swift
//  Little Quizzy
//
//  Created by Rahul Kumar on 29/09/26.
//

import Foundation
import Observation
import SwiftData

@Observable
final class QuizViewModel {
    private(set) var questions: [Question] = []
    private(set) var currentIndex = 0
    private(set) var correctedAnswer = 0
    private(set) var isFinished = false
    private(set) var quizMode: QuizMode = .random
    private let allQuestions: [Question]
    private(set) var selectedOptionID: String?
    var selectedClass: Int
    var isItCorrectAnswer = false
    private let modelContext: ModelContext
    private var quizAttempt: QuizAttempt?

    init(quizMode: QuizMode, selectedClass: Int, modelContext: ModelContext) {
        self.modelContext = modelContext
        self.quizMode = quizMode
        self.selectedClass = selectedClass
        allQuestions = Self.loadQuestions(selectedClass: selectedClass)
    }

    func startRandomQuiz(numberOfQuestions: Int = 5) {
        begin(from: allQuestions, count: numberOfQuestions)
    }

    func startSubjectQuiz(subject: Subject, numberOfQuestions: Int = 5) {
        let pool = allQuestions.filter { $0.subject == subject }
        begin(from: pool, count: numberOfQuestions)
    }

    func getQuizQuestions(numberOfQuestions: Int = 5) {
        switch quizMode {
        case .random:
            startRandomQuiz(numberOfQuestions: numberOfQuestions)
        case .subject(let subject):
            startSubjectQuiz(subject: subject, numberOfQuestions: numberOfQuestions)
        }
    }

    private func begin(from pool: [Question], count: Int) {
        questions = Array(pool.shuffled().prefix(max(count, 0)))
        currentIndex = 0
        correctedAnswer = 0
        isFinished = false
        isItCorrectAnswer = false
        selectedOptionID = nil
        let attempt = QuizAttempt(quizMode: quizMode)
        modelContext.insert(attempt)
        quizAttempt = attempt
        saveChanges()
    }

    var currentQuestion: Question? {
        questions.indices.contains(currentIndex) ? questions[currentIndex] : nil
    }

    var totalQuestions: Int {
        questions.count
    }

    var currentNumber: Int {
        min(currentIndex + 1, totalQuestions)
    }

    var isLastQuestion: Bool {
        totalQuestions > 0 && currentIndex >= totalQuestions - 1
    }

    var isLocked: Bool {
        currentQuestion?.isAnswered ?? false
    }

    func select(_ option: Option) {
        guard !isLocked, questions.indices.contains(currentIndex), questions[currentIndex].options.contains(where: { $0.id == option.id }), let quizAttempt else { return }
        selectedOptionID = option.id
        questions[currentIndex].isAnswered = true
        let isCorrect = option.isAnswer
        if isCorrect {
            correctedAnswer += 1
        }
        isItCorrectAnswer = isCorrect
        quizAttempt.addQuestionAttempt(questionID: questions[currentIndex].id, subject: questions[currentIndex].subject, isCorrect: isCorrect, selectedOptionID: option.id)
        saveChanges()
    }

    func goToNext() {
        selectedOptionID = nil
        isItCorrectAnswer = false
        if isLastQuestion {
            quizAttempt?.complete()
            saveChanges()
            isFinished = true
        } else {
            currentIndex += 1
        }
    }

    private func saveChanges() {
        do {
            try modelContext.save()
        } catch {
            print("Failed to save quiz data: \(error.localizedDescription)")
        }
    }

    private static func loadQuestions(selectedClass: Int) -> [Question] {
        let fileName = "class_\(selectedClass)_questions"
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            assertionFailure("\(fileName).json not found in bundle")
            return []
        }
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(QuestionBank.self, from: data).questions
        } catch {
            assertionFailure("Failed to decode \(fileName).json: \(error)")
            return []
        }
    }
}
