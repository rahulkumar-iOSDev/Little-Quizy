//
//  ProfileView.swift
//  Little Quizzy
//
//  Created by Rahul Kumar on 29/09/26.
//

import SwiftUI
import SwiftData

struct ProfileView: View {
    @Environment(AppRouter.self) private var router
    @Environment(\.modelContext) private var modelContext
    @AppStorage(AppStorageKey.userName) private var userName = ""
    @AppStorage(AppStorageKey.selectedClass) private var savedClass = 1
    @State private var viewModel = ProfileViewModel()
    @Query private var quizAttempts: [QuizAttempt]
    @Query(sort: \QuestionAttempt.answeredAt, order: .reverse) private var questionAttempts: [QuestionAttempt]
    @Environment(ThemeManager.self) private var themeManager

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                profileHeader
                if quizAttempts.isEmpty {
                    emptyProfileView
                } else {
                    scoreProfileView
                }
            }
            .padding()
        }
        .navigationTitle("Profile")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                HStack {
                    Button {
                        themeManager.toggle()
                    } label: {
                        Image(systemName: themeManager.theme.toggleIcon)
                            .imageScale(.large)
                            .symbolRenderingMode(.hierarchical)
                            .foregroundStyle(.appText)
                    }
                    .accessibilityLabel("Switch to \(themeManager.theme.toggled.title) theme")
                    
                    settingsMenu
                }
            }
        }
        .onAppear {
            viewModel.updatedName = userName
            viewModel.selectedClass = savedClass
            viewModel.updateScores(from: questionAttempts)
        }
        .onChange(of: questionAttempts.count) {
            viewModel.updateScores(from: questionAttempts)
        }
        .sheet(isPresented: $viewModel.showUpdateName) {
            updateNameSheet
        }
        .sheet(isPresented: $viewModel.showUpdateClass) {
            updateClassSheet
        }
        .confirmationDialog("Delete Score Results?", isPresented: $viewModel.showDeleteConfirmation, titleVisibility: .visible) {
            Button("Delete All Results", role: .destructive) {
                viewModel.deleteScoreResults(modelContext: modelContext)
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("This will permanently delete your saved quiz results.")
        }
        .alert("Unable to Complete Action", isPresented: Binding(get: { viewModel.errorMessage != nil }, set: { if !$0 { viewModel.errorMessage = nil } })) {
            Button("OK", role: .cancel) {
                viewModel.errorMessage = nil
            }
        } message: {
            Text(viewModel.errorMessage ?? "")
        }
    }

    private var settingsMenu: some View {
        Menu {
            Button {
                viewModel.updatedName = userName
                viewModel.showUpdateName = true
            } label: {
                Label("Update Name", systemImage: "person")
            }
            Button {
                viewModel.selectedClass = savedClass
                viewModel.showUpdateClass = true
            } label: {
                Label("Update Class", systemImage: "graduationcap")
            }
            if !quizAttempts.isEmpty {
                Divider()
                Button(role: .destructive) {
                    viewModel.showDeleteConfirmation = true
                } label: {
                    Label("Delete Score Results", systemImage: "trash")
                }
            }
        } label: {
            Image(systemName: "gearshape.fill")
                .font(.title3)
                .foregroundStyle(.appText)
                .frame(width: 44, height: 44)
                .contentShape(Rectangle())
        }
        .accessibilityLabel("Profile Settings")
    }
    
    private var profileHeader: some View {
        VStack(spacing: 14) {
            VStack(spacing: 6) {
                Text(userName.isEmpty ? "Welcome!" : "Hello, \(userName)!")
                    .font(.system(.largeTitle, design: .rounded, weight: .bold))
                    .foregroundStyle(Color.appText)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .minimumScaleFactor(0.8)
                Text("Ready to learn something new today?")
                    .font(.subheadline)
                    .foregroundStyle(Color.appText.opacity(0.75))
                    .multilineTextAlignment(.center)
            }
            HStack(spacing: 8) {
                Image(systemName: "graduationcap.fill")
                    .foregroundStyle(Color.appWhiteBg)
                Text("Class \(savedClass)")
                    .font(.subheadline.weight(.bold))
                    .foregroundStyle(Color.appWhiteBg)
            }
            .padding(.horizontal, 18)
            .padding(.vertical, 10)
            .background(Color.appPrimaryBlue, in: Capsule())
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 24)
        .padding(.horizontal, 16)
        .background {
            RoundedRectangle(cornerRadius: 24)
                .fill(Color.appPurple.opacity(0.12))
                .overlay {
                    RoundedRectangle(cornerRadius: 24)
                        .stroke(Color.appPurple.opacity(0.25), lineWidth: 1)
                }
        }
    }


    private var emptyProfileView: some View {
        VStack(spacing: 12) {
            Button {
                router.selectedTab = .subjects
            } label: {
                Label("Subject-wise Quiz", systemImage: "book.fill")
                    .font(.headline)
                    .foregroundStyle(Color.appWhiteBg)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 15)
                    .background(Color.appPrimaryBlue, in: RoundedRectangle(cornerRadius: 16))
            }
            .buttonStyle(.plain)
            Button {
                router.selectedTab = .random
            } label: {
                Label("Random Quick Test", systemImage: "dice.fill")
                    .font(.headline)
                    .foregroundStyle(Color.appText)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 15)
                    .background(Color.appOrange.opacity(0.18), in: RoundedRectangle(cornerRadius: 16))
                    .overlay {
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.appOrange, lineWidth: 1)
                    }
            }
            .buttonStyle(.plain)
        }
    }

    private var scoreProfileView: some View {
        VStack(spacing: 20) {
            totalScoreCard
            VStack(alignment: .leading, spacing: 16) {
                Text("Subject Progress")
                    .font(.title3.bold())
                ForEach(viewModel.subjects) { subjectScore in
                    SubjectScoreRow(subject: subjectScore)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(20)
            .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 24))
        }
    }
    
    private var totalScoreCard: some View {
        VStack(spacing: 12) {
            Image(systemName: "trophy.fill")
                .font(.system(size: 30))
                .foregroundStyle(Color.appYellow)
            Text("Overall Score")
                .font(.headline)
                .foregroundStyle(Color.appText.opacity(0.8))
            Text("\(viewModel.totalScore) / \(viewModel.totalQuestions)")
                .font(.system(.largeTitle, design: .rounded, weight: .bold))
                .foregroundStyle(Color.appPrimaryBlue)
            Text("Correct answers across your saved quizzes")
                .font(.footnote)
                .foregroundStyle(Color.appText.opacity(0.7))
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(24)
        .background {
            RoundedRectangle(cornerRadius: 24)
                .fill(Color.appPrimaryBlue.opacity(0.08))
                .overlay {
                    RoundedRectangle(cornerRadius: 24)
                        .stroke(Color.appPrimaryBlue.opacity(0.2), lineWidth: 1)
                }
        }
    }

    private var updateNameSheet: some View {
        NavigationStack {
            Form {
                Section("Your Name") {
                    TextField("Enter your name", text: $viewModel.updatedName)
                        .textContentType(.name)
                        .autocorrectionDisabled()
                }
                Section {
                    Text("Your name will appear at the top of your profile.")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle("Update Name")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        viewModel.showUpdateName = false
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        viewModel.saveName()
                        if viewModel.errorMessage == nil {
                            userName = viewModel.updatedName
                        }
                    }
                    .disabled(viewModel.updatedName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
        .presentationDetents([.medium])
    }

    private var updateClassSheet: some View {
        NavigationStack {
            Form {
                Section("Select Your Class") {
                    Picker("Class", selection: $viewModel.selectedClass) {
                        ForEach(1...8, id: \.self) { grade in
                            Text("Class \(grade)").tag(grade)
                        }
                    }
                    .pickerStyle(.wheel)
                }
            }
            .navigationTitle("Update Class")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        viewModel.showUpdateClass = false
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        viewModel.saveClass()
                        savedClass = viewModel.selectedClass
                    }
                }
            }
        }
        .presentationDetents([.medium])
    }
}

#Preview {
    ProfileView()
        .environment(ThemeManager())
        .environment(AppRouter())
        .modelContainer(for: [QuizAttempt.self, QuestionAttempt.self])
}


