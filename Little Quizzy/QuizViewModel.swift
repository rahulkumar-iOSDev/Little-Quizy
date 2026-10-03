//
//  QuizViewModel.swift
//  Little Quizzy
//
//  Created by Rahul Kumar on 29/09/26.
//

import Foundation
import Observation

// MARK: - Models



// MARK: - ViewModel

@Observable
final class QuizViewModel {

    // Current quiz
    private(set) var questions: [Question] = []
    private(set) var currentIndex = 0
    private(set) var score = 0
    private(set) var isFinished = false
    private(set) var quizMode: QuizMode = .random

    // Full question pool loaded from JSON
    private let allQuestions: [Question]

    init(fileName: String = "little_quizzy_questions", bundle: Bundle = .main, quizMode: QuizMode) {
        self.quizMode = quizMode
        allQuestions = Self.loadQuestions(fileName: fileName, bundle: bundle)
    }

    // MARK: Start quiz

    /// Random questions from all subjects.
    func startRandomQuiz(numberOfQuestions: Int = 5) {
        begin(from: allQuestions, count: numberOfQuestions)
    }

    /// Random questions from a single subject.
    func startSubjectQuiz(subject: Subject, numberOfQuestions: Int = 5) {
        let pool = allQuestions.filter { $0.subject == subject }
        begin(from: pool, count: numberOfQuestions)
    }
    
    // Inside QuizViewModel
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
        score = 0
        isFinished = false
    }

    // MARK: Quiz state

    var currentQuestion: Question? {
        questions.indices.contains(currentIndex) ? questions[currentIndex] : nil
    }

    var totalQuestions: Int { questions.count }

    /// 1-based number for display ("1/5").
    var currentNumber: Int { min(currentIndex + 1, totalQuestions) }

    var isLastQuestion: Bool { currentIndex >= totalQuestions - 1 }

    /// True once the user has picked an option for the current question.
    var isLocked: Bool {
        currentQuestion?.options.contains { $0.isAnswered } ?? false
    }

    // MARK: Actions

    func select(_ option: Option) {
        guard !isLocked,
              questions.indices.contains(currentIndex),
              let index = questions[currentIndex].options.firstIndex(where: { $0.id == option.id })
        else { return }

        questions[currentIndex].options[index].isAnswered = true
        if option.isAnswer { score += 1 }
    }

    func goToNext() {
        if isLastQuestion {
            isFinished = true
        } else {
            currentIndex += 1
        }
    }

    // MARK: Loading

    private static func loadQuestions(fileName: String, bundle: Bundle) -> [Question] {
        guard let url = bundle.url(forResource: fileName, withExtension: "json") else {
            assertionFailure("\(fileName).json not found in bundle")
            return []
        }
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(QuestionBank.self, from: data).questions
        } catch {
            assertionFailure("Failed to decode questions: \(error)")
            return []
        }
    }
}
