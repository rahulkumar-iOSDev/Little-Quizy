//
//  ScreenUtility.swift
//  Little Quizzy
//
//  Created by Rahul Kumar on 01/10/26.
//

import UIKit

enum ScreenUtility {

    static var size: CGSize {
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }?
            .bounds
            .size ?? .zero
    }

    static var width: CGFloat {
        size.width
    }

    static var height: CGFloat {
        size.height
    }
}
