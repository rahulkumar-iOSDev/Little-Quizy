//
//  SubjectCard.swift
//  Little Quizzy
//
//  Created by Rahul Kumar on 29/09/26.
//

import SwiftUI

struct SubjectCard: View {
    let subject: Subject
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = max(0, width - 20)
            VStack(spacing: 16) {
                Text(subject.emoji)
                    .font(.system(size: 48))
                Text(subject.name)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(.primary)
            }
            .frame(width: width, height: height)
            .background(subject.color)
            .clipShape(RoundedRectangle(cornerRadius: 32))
            .position(x: width / 2, y: height / 2)
        }
        .aspectRatio(1, contentMode: .fit)
    }
}
#Preview {
    SubjectCard(subject: .mockSubject[0])
}
