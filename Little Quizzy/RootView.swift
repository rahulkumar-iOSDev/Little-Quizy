//
//  RootView.swift
//  Little Quizzy
//
//  Created by Rahul Kumar on 29/09/26.
//

import SwiftUI
import SwiftData

struct RootView: View {
    @AppStorage(AppStorageKey.hasCompletedOnboarding)
    private var hasCompletedOnboarding = false

    @State private var router = AppRouter()
    

    var body: some View {

        Group {
            if hasCompletedOnboarding {
                QuizTabView()
            } else {
                LetsLearnView()
            }
        }
        .environment(router)
        .modelContainer(for: [QuizAttempt.self, QuestionAttempt.self])
    }
}
