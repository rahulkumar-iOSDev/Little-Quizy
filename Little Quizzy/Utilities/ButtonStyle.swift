//
//  ButtonStyle.swift
//  Little Quizzy
//
//  Created by Rahul Kumar on 12/09/26.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.title2)
            .fontWeight(.medium)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(.appPrimaryBlue)
            .clipShape(
                RoundedRectangle(cornerRadius: 14)
            )
            .opacity(configuration.isPressed ? 0.8 : 1.0)
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .padding(.horizontal, 20)
            
    }
}

#Preview {
    Button {
        
    } label: {
        Text("Example Button")
    }
    .buttonStyle(PrimaryButtonStyle())
}

