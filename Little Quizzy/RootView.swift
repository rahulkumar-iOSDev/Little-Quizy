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
    @State private var themeManager = ThemeManager()
    
    var body: some View {

        Group {
            if hasCompletedOnboarding {
                QuizTabView()
            } else {
                LetsLearnView()
            }
        }
        .environment(router)
        .environment(themeManager)
        .preferredColorScheme(themeManager.theme.colorScheme)
        .modelContainer(for: [QuizAttempt.self, QuestionAttempt.self])
    }
}
