//
//  ContentView.swift
//  Little Quizzy
//
//  Created by Rahul Kumar on 11/09/26.
//

import SwiftUI

struct ContentView: View {
    @State private var isActive: Bool = false
    var body: some View {
        VStack {
            if isActive {
                LetsLearnView()
            } else {
                SplashView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            isActive = true
                        }
                    }
            }
        }
    }
}

#Preview {
    LetsLearnView()
}


struct SplashView: View {
    var body: some View {
        VStack {
            Image(.splash)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        }
        
    }
}

struct LetsLearnView: View {
    var body: some View {
        VStack(spacing: 0) {
            VStack {
                Text("Little")
                    .font(.system(size: 60))
                    .fontWeight(.bold)
                    .foregroundStyle(.purple)
                Text("Quizzy")
                    .font(.system(size: 60))
                    .fontWeight(.bold)
                    .foregroundStyle(.accentYellow)
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
                    
                } label: {
                    Text("Let's Learn →")
                }
                .buttonStyle(PrimaryButtonStyle())
                .padding(.top, -20)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(maxHeight: .infinity)
        .background(.whiteBackground)
        .ignoresSafeArea()
    }
}
