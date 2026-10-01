//
//  ProfileView.swift
//  Little Quizzy
//
//  Created by Rahul Kumar on 29/09/26.
//

import SwiftUI

struct ProfileView: View {
    
    @AppStorage("userName")
    private var userName = ""
    
    private let subjectScores: [SubjectScore] = [
        SubjectScore(name: "Maths", emoji: "🧮", score: 80),
        SubjectScore(name: "English", emoji: "📖", score: 70),
        SubjectScore(name: "Science", emoji: "🧪", score: 60),
        SubjectScore(name: "Social", emoji: "🌎", score: 50),
        SubjectScore(name: "Hindi", emoji: "अ", score: 40),
        SubjectScore(name: "GK", emoji: "💡", score: 20)
    ]
    
    private var totalScore: Int {
        subjectScores.reduce(0) { $0 + $1.score }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            // MARK: - Header
            
            Text("\(userName) ABC")
                .font(.system(size: 30, weight: .bold))
                .foregroundStyle(.appText)
                .padding(.top, 20)
            
            // MARK: - Total Score
            
            totalScoreCard
                .padding(.top, 32)
            
            // MARK: - Subject Scores
            
            Text("Subject-wise Scores")
                .font(.system(size: 24, weight: .bold))
                .foregroundStyle(.appText)
                .padding(.top, 30)
            
            VStack(spacing: 24) {
                ForEach(subjectScores) { subject in
                    SubjectScoreRow(subject: subject)
                }
            }
            .padding(.top, 26)
            
            Spacer()
        }
        .appScreenStyle()
    }
    
    // MARK: - Total Score Card
    
    private var totalScoreCard: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack(spacing: 12) {
                Text("🏆")
                    .font(.system(size: 30))
                
                Text("Total Score")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundStyle(.gray)
                    
            }
            .padding(.horizontal, 20)
            Text("\(totalScore)")
                .font(.system(size: 58, weight: .bold))
                .padding(.horizontal, 20)
                .foregroundStyle(.appPrimaryBlue)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 20)
        .background(.white)
        .clipShape(
            RoundedRectangle(cornerRadius: 24)
        )
    }
}

// MARK: - Subject Score Model

struct SubjectScore: Identifiable {
    let id = UUID()
    let name: String
    let emoji: String
    let score: Int
}

// MARK: - Subject Score Row

struct SubjectScoreRow: View {
    
    let subject: SubjectScore
    
    var body: some View {
        HStack(spacing: 0) {
            HStack(spacing: 4) {
                Text(subject.emoji)
                    .font(.system(size: 20))
                    .frame(width: 28)
                
                Text(subject.name)
                    .padding(.trailing, 10)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundStyle(.appText)
                    
            }
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(.appPrimaryBlue.opacity(0.15))
                    
                    Capsule()
                        .fill(.appPrimaryBlue)
                        .frame(
                            width: geometry.size.width *
                            CGFloat(subject.score) / 100
                        )
                }
            }
            .frame(height: 10)
            
            Text("\(subject.score)/100")
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(.appText)
                .frame(width: 75, alignment: .trailing)
        }
        .frame(height: 22)
    }
}
#Preview {
    ProfileView()
}
