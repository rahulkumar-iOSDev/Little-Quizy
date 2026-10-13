//
//  SubjectScoreRow.swift
//  Little Quizzy
//
//  Created by Rahul Kumar on 13/10/26.
//

import SwiftUI

struct SubjectScoreRow: View {
    let subject: SubjectScore

    var body: some View {
        HStack(spacing: 8) {
            HStack(spacing: 4) {
                Text(subject.subject.emoji)
                    .font(.system(size: 20))
                    .frame(width: 28)
                Text(subject.subject.title)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundStyle(.appText)
                    .fixedSize(horizontal: true, vertical: false)
                    .padding(.trailing, 6)
            }
            .layoutPriority(1)
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(.appPrimaryBlue.opacity(0.15))
                    Capsule()
                        .fill(.appPrimaryBlue)
                        .frame(width: geometry.size.width * CGFloat(subject.score) / 100)
                }
            }
            .frame(minWidth: 0)
            .frame(height: 10)
            Text("\(subject.score)/100")
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(.appText)
                .fixedSize(horizontal: true, vertical: false)
                .frame(width: 75, alignment: .trailing)
                .layoutPriority(1)
        }
        .frame(height: 22)
    }
}

#Preview {
    SubjectScoreRow(subject: .init(subject: .maths, score: 40))
}
