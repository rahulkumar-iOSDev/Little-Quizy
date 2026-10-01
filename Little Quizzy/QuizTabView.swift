//
//  QuizTabView.swift
//  Little Quizzy
//
//  Created by Rahul Kumar on 29/09/26.
//

import SwiftUI

struct QuizTabView: View {
    var body: some View {
        TabView {
            SubjectsView()
                .tabItem {
                    Label("Subjects", systemImage: "book.fill")
                }
            RandomView()
                .tabItem {
                    Label("Random", systemImage: "dice.fill")
                }
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle")
                }
        }
    }
}

#Preview {
    QuizTabView()
}
