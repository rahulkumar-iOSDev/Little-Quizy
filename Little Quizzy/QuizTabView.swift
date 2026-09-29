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

struct RandomView: View {
    var body: some View {
        VStack {
            Text("Random Tab")
                .font(.largeTitle)
            Text("🎲")
                .font(.system(size: 80))
        }
    }
}

struct ProfileView: View {
    var body: some View {
        VStack {
            Text("Profile Tab")
                .font(.largeTitle)
            Text("🧑‍🎓")
                .font(.system(size: 80))
        }
    }
}

#Preview {
    QuizTabView()
}
