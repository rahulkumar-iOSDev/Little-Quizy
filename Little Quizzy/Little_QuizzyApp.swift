//
//  Little_QuizzyApp.swift
//  Little Quizzy
//
//  Created by Rahul Kumar on 11/09/26.
//

import SwiftUI

@main
struct Little_QuizzyApp: App {
    @StateObject private var navigationRouter = NavigationRouter()
    var body: some Scene {
        WindowGroup {
            LetsLearnView()
                .environmentObject(navigationRouter)
        }
    }
}
