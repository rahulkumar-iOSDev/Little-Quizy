//
//  Router.swift
//  Little Quizzy
//
//  Created by Rahul Kumar on 03/10/26.
//

import Foundation
import Observation

@MainActor
@Observable
final class Router {
    var onboarding = RouteStack<OnboardingRoute>()
    var subject = RouteStack<SubjectRoute>()
    var random = RouteStack<RandomRoute>()
    var profile = RouteStack<ProfileRoute>()
}
