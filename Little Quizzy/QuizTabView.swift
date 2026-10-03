//
//  QuizTabView.swift
//  Little Quizzy
//
//  Created by Rahul Kumar on 29/09/26.
//

import SwiftUI

struct QuizTabView: View {
    @Environment(Router.self) private var router

    var body: some View {
        @Bindable var router = router
        TabView {
            NavigationStack(path: $router.subject.routes) {
                SubjectsView()
                    .navigationDestination(for: SubjectRoute.self) { route in
                        SubjectRouteView(route: route)
                    }
            }
            .tabItem {
                Label("Subjects",systemImage: "book.fill")
            }
            
            NavigationStack(path: $router.random.routes) {
                RandomView()
                    .navigationDestination(for: RandomRoute.self) { route in
                        RandomRouteView(route: route)
                    }
            }
            .tabItem {
                Label("Random", systemImage: "dice.fill")
            }

            NavigationStack(path: $router.profile.routes) {
                ProfileView()
                    .navigationDestination(for: ProfileRoute.self) { route in
                        ProfileRouteView(route: route)
                    }
            }
            .tabItem {
                Label("Profile", systemImage: "person.crop.circle")
            }
        }
    }
}
#Preview {
    QuizTabView()
}
