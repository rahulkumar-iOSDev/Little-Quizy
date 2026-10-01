//
//  ViewModifiers.swift
//  Little Quizzy
//
//  Created by Rahul Kumar on 01/10/26.
//

import SwiftUI

struct AppScreenStyle: ViewModifier {

    func body(content: Content) -> some View {
        content
            .frame(maxWidth: ScreenUtility.width, maxHeight: ScreenUtility.height)
            .padding()
            .background(.appWhiteBg)
    }
}

extension View {

    func appScreenStyle() -> some View {
        modifier(AppScreenStyle())
    }
}


