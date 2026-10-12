//
//  WhatsNameView.swift
//  Little Quizzy
//
//  Created by Rahul Kumar on 12/09/26.
//

import SwiftUI

struct StartQuizView: View {
    @State private var name: String = ""
    @State private var selectedClass = 6
    @Environment(AppRouter.self) private var router
    
    @AppStorage(AppStorageKey.hasCompletedOnboarding) private var hasCompletedOnboarding = false
    @AppStorage(AppStorageKey.userName) private var AppStorageUserName = ""
    @AppStorage(AppStorageKey.selectedClass) private(set) var savedClass: Int = 1
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                
                Spacer(minLength: 64)
                
                Text("What's Your Name?")
                    .font(.system(size: 28))
                    .fontWeight(.semibold)
                    .foregroundStyle(.appText)
                
                Text("We'll remember your name for your\nquizzes.")
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .fontWeight(.semibold)
                    .foregroundStyle(.gray)
                    .fixedSize(horizontal: false, vertical: true)
                
                Text("🧑‍🎓")
                    .font(.system(size: 100))
                    .fontWeight(.semibold)
                    .foregroundStyle(.appText)
                    .padding(.top, 10)
                
                NameTextField(name: $name)
                    .padding(.top, -20)
                
                Text("Choose Class")
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .fontWeight(.bold)
                    .foregroundStyle(.appText)
                    .padding()
                
                ClassSelectionView(selectedClass: $selectedClass)
                
                Button {
                    saveUser()
                } label: {
                    Text("Start Quiz →")
                }
                .buttonStyle(PrimaryButtonStyle())
                .padding(.top, 40)
                
                Spacer()
            }
        }
        .appScreenStyle()
    }
    
    
    private func saveUser() {
        let name = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !name.isEmpty else {
            return
        }
        savedClass = selectedClass
        router.onboarding.removeAll()
        AppStorageUserName = name
        hasCompletedOnboarding = true
    }
}

#Preview {
    StartQuizView()
}

struct NameTextField: View {
    @Binding var name: String
    
    var body: some View {
        HStack(spacing: 18) {
            Spacer()
            Image(systemName: "person.fill")
                .font(.system(size: 24))
                .foregroundStyle(Color(red: 0.48, green: 0.57, blue: 0.70))
            
            TextField("Enter your name", text: $name)
                .font(.system(size: 20, weight: .medium))
                .foregroundStyle(.primary)
                .frame(width: 200)
                .tint(.appPrimaryBlue)
        }
        .padding(.horizontal, 30)
        .frame(height: 50)
        .background(Color.white)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(
                    Color(red: 0.70, green: 0.82, blue: 1.0),
                    lineWidth: 4
                )
        )
        .clipShape(
            RoundedRectangle(cornerRadius: 16)
        )
        .padding(.horizontal, 30)
    }
}

struct ClassSelectionView: View {
    @Binding var selectedClass: Int
    let classes = Array(1...8)
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 10) {
                ForEach(classes, id: \.self) { classNumber in
                    Button {
                        selectedClass = classNumber
                    } label: {
                        Text("\(classNumber)")
                            .font(.system(size: 22, weight: .medium))
                            .foregroundStyle(
                                selectedClass == classNumber
                                ? .white
                                : .primary
                            )
                            .frame(width: 40, height: 44)
                            .background(
                                selectedClass == classNumber
                                ? .appPrimaryBlue
                                : Color(red: 0.86, green: 0.91, blue: 0.98)
                            )
                            .clipShape(
                                RoundedRectangle(cornerRadius: 10)
                            )
                    }
                }
            }
        }
        .scrollIndicators(.hidden)
        .padding(.horizontal, 30)
    }
}
