//
//  NavigationRouter.swift
//  Little Quizzy
//
//  Created by Rahul Kumar on 18/09/26.
//

import Foundation
import SwiftUI
import Combine

final class NavigationRouter: ObservableObject {
    @Published var onboardingRoute: [OnboardingRoute] = []
    
    func push(to view: OnboardingRoute) {
        DispatchQueue.main.async { [weak self] in
            self?.onboardingRoute.append(view)
        }
    }
    
    func popView() {
        DispatchQueue.main.async { [weak self] in
            self?.onboardingRoute.removeLast()
        }
    }
    
    func pop(to view: OnboardingRoute) {
        if var viewIndex = onboardingRoute.firstIndex(of: view) {
            DispatchQueue.main.async { [weak self] in
                viewIndex += 1
                self?.onboardingRoute.removeSubrange(viewIndex...)
            }
        }
    }
    
    func resetOnbaordingRoute() {
        DispatchQueue.main.async { [weak self] in
            self?.onboardingRoute = []
        }
    }
}
