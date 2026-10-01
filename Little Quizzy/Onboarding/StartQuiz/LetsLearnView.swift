//
//  LetsLearnView.swift
//  Little Quizzy
//
//  Created by Rahul Kumar on 11/09/26.
//

import SwiftUI

struct LetsLearnView: View {
    @EnvironmentObject private var router: NavigationRouter
    var body: some View {
        NavigationStack(path: $router.onboardingRoute) {
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
                        router.push(to: .startQuiz)
                    } label: {
                        Text("Let's Learn →")
                    }
                    .buttonStyle(PrimaryButtonStyle())
                    .padding(.top, -20)
                }
            }
            .appScreenStyle()
            .navigationDestination(for: OnboardingRoute.self, destination: { $0 })
        }
        
    }
}

#Preview {
    @Previewable @StateObject var navigationRouter = NavigationRouter()
    LetsLearnView()
        .environmentObject(navigationRouter)
}
