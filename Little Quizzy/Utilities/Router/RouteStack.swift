//
//  RouteStack.swift
//  Little Quizzy
//
//  Created by Rahul Kumar on 18/09/26.
//

import Foundation
import SwiftUI

@MainActor
@Observable
final class RouteStack<Route: Hashable> {
    var routes: [Route] = []
    
    func push(_ route: Route) {
        routes.append(route)
    }
    
    @discardableResult
    func pop() -> Route? {
        guard !routes.isEmpty else { return nil }
        return routes.removeLast()
    }
    
    func pop(to route: Route) {
        guard let index = routes.lastIndex(of: route) else {
            return
        }
        guard index < routes.count - 1 else {
            return
        }
        routes.removeSubrange((index + 1)..<routes.count)
    }
    
    func popToRoot() {
        routes.removeAll()
    }
    
    func removeAll() {
        routes.removeAll()
    }
}
