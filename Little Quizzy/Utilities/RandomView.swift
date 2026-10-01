//
//  RandomView.swift
//  Little Quizzy
//
//  Created by Rahul Kumar on 29/09/26.
//

import SwiftUI

struct RandomView: View {
    var body: some View {
        VStack {
            Text("🎲")
                .padding(.vertical, 10)
                .font(.system(size: 128))
                .padding(.top, 70)
            VStack {
                Text("Random Quiz")
                    .font(.system(size: 26))
                    .fontWeight(.semibold)
                    .foregroundStyle(.appText)
                
                Text("A mix of questions from all topics!")
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.gray)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(.vertical, 10)
            HStack {
                Text("⭐️")
                Text("🎯")
                Text("⭐️")
            }
            .font(.system(size: 52))
            Button {
                
            } label: {
                 Text("Start Random Quiz →")
            }
            .buttonStyle(PrimaryButtonStyle())
            .padding(.vertical, 10)
            Spacer()
        }
        .appScreenStyle()

    }
}

#Preview {
    RandomView()
}
