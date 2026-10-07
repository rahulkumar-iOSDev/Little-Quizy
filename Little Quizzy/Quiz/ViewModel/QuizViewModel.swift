//
//  QuizViewModel.swift
//  Little Quizzy
//
//  Created by Rahul Kumar on 29/09/26.
//

import Foundation
import Observation

@Observable
final class QuizViewModel {
    private(set) var questions: [Question] = []
    private(set) var currentIndex = 0
    private(set) var score = 0
    private(set) var isFinished = false
    private(set) var quizMode: QuizMode = .random

    private let allQuestions: [Question]
    private(set) var selectedOptionID: String?

    var isItCorrectAnswer = false

    init(fileName: String = "little_quizzy_questions", bundle: Bundle = .main, quizMode: QuizMode) {
        self.quizMode = quizMode
        allQuestions = Self.loadQuestions(fileName: fileName, bundle: bundle)
    }

    func startRandomQuiz(numberOfQuestions: Int = 5) {
        begin(from: allQuestions, count: numberOfQuestions)
    }

    func startSubjectQuiz(subject: Subject, numberOfQuestions: Int = 5) {
        let pool = allQuestions.filter {
            $0.subject == subject
        }

        begin(from: pool, count: numberOfQuestions)
    }

    func getQuizQuestions(numberOfQuestions: Int = 5) {
        switch quizMode {
        case .random:
            startRandomQuiz( numberOfQuestions: numberOfQuestions )

        case .subject(let subject):
            startSubjectQuiz( subject: subject, numberOfQuestions: numberOfQuestions )
        }
    }

    private func begin(from pool: [Question], count: Int) {
        questions = Array(
            pool.shuffled().prefix(max(count, 0))
        )
        currentIndex = 0
        score = 0
        isFinished = false
        isItCorrectAnswer = false
        selectedOptionID = nil
    }

    var currentQuestion: Question? {
        questions.indices.contains(currentIndex)
        ? questions[currentIndex]
        : nil
    }

    var totalQuestions: Int {
        questions.count
    }

    var currentNumber: Int {
        min(currentIndex + 1, totalQuestions)
    }

    var isLastQuestion: Bool {
        currentIndex >= totalQuestions - 1
    }

    var isLocked: Bool {
        currentQuestion?.isAnswered ?? false
    }

    func select(_ option: Option)  {
        guard
            !isLocked,
            questions.indices.contains(currentIndex),
            questions[currentIndex].options.contains(where: {
                $0.id == option.id
            })
        else {
            return
        }
        selectedOptionID = option.id
        questions[currentIndex].isAnswered = true
        let isCorrect = option.isAnswer

        if isCorrect {
            score += 10
        }
        isItCorrectAnswer = isCorrect
    }

    func goToNext() {
        selectedOptionID = nil
        isItCorrectAnswer = false
        if isLastQuestion {
            isFinished = true
        } else {
            currentIndex += 1
        }
    }

    private static func loadQuestions( fileName: String, bundle: Bundle ) -> [Question] {
        guard let url = bundle.url( forResource: fileName, withExtension: "json" ) else {
            assertionFailure( "\(fileName).json not found in bundle" )
            return []
        }

        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder()
                .decode( QuestionBank.self, from: data )
                .questions
        } catch {
            assertionFailure( "Failed to decode questions: \(error)" )
            return []
        }
    }
}
