//
//  LetsLearnView.swift
//  Little Quizzy
//
//  Created by Rahul Kumar on 11/09/26.
//

import SwiftUI

struct LetsLearnView: View {
    @Environment(AppRouter.self) private var router
    
    var body: some View {
        @Bindable var router = router
        NavigationStack(path: $router.onboarding.routes) {
            VStack(spacing: 0) {
                VStack {
                    Text("Little")
                        .font(.system(size: 60))
                        .fontWeight(.bold)
                        .foregroundStyle(.purple)
                    Text("Quizzy")
                        .font(.system(size: 60))
                        .fontWeight(.bold)
                        .foregroundStyle(.appYellow)
                        .padding(.top, -50)
                        .padding(.bottom, 10)
                    Text("LEARN . THINK . GROW")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .foregroundStyle(.gray)
                        .padding(.bottom, -16)
                    HStack {
                        Text("🧒")
                            .font(.system(size: 120))
                        Text("📚")
                            .font(.system(size: 120))
                    }
                    Button {
                        router.onboarding.push(.startQuiz)
                    } label: {
                        Text("Let's Learn →")
                    }
                    .buttonStyle(PrimaryButtonStyle())
                    .padding(.top, -20)
                }
            }
            .appScreenStyle()
            .navigationDestination(for: OnboardingRoute.self) { route in
                OnboardingRouteView(route: route)
            }
        }
    }
}

#Preview {
    @Previewable @State var router = AppRouter()
    LetsLearnView()
        .environment(router)
}


struct EditProfileView: View {
    var body: some View {
        Text("Edit Profile")
    }
}

struct ScoreView: View {
    var body: some View {
        Text("Score View")
    }
}
