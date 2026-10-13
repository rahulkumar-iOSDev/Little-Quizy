//
//  ThemeManager.swift
//  Little Quizzy
//
//  Created by Rahul Kumar on 13/10/26.
//

import SwiftUI
import Observation

// MARK: - Theme enum (light / dark only)

enum AppTheme: String, CaseIterable, Identifiable {
    case light
    case dark

    var id: String { rawValue }

    /// Value passed to `.preferredColorScheme(_:)`
    var colorScheme: ColorScheme {
        switch self {
        case .light: return .light
        case .dark:  return .dark
        }
    }

    /// SF Symbol shown on the toggle button (shows the theme you will switch TO)
    var toggleIcon: String {
        switch self {
        case .light: return "moon.fill"
        case .dark:  return "sun.max.fill"
        }
    }

    var title: String {
        switch self {
        case .light: return "Light"
        case .dark:  return "Dark"
        }
    }

    var toggled: AppTheme {
        self == .light ? .dark : .light
    }

    /// nil = primary icon ("AppIcon"); otherwise the alternate icon set name
    var alternateIconName: String? {
        switch self {
        case .light: return nil
        case .dark:  return "AppIconDark"
        }
    }
}

// MARK: - Theme manager

@Observable
final class ThemeManager {
    private let storageKey = AppStorageKey.colorScheme

    var theme: AppTheme {
        didSet {
            UserDefaults.standard.set(theme.rawValue, forKey: storageKey)
        }
    }

    init() {
        let saved = UserDefaults.standard.string(forKey: AppStorageKey.colorScheme)
        // Old value "system" (or nothing saved) safely falls back to .light
        self.theme = AppTheme(rawValue: saved ?? "") ?? .light
    }

    func toggle() {
        theme = theme.toggled
        syncAppIcon()
    }

    /// Switches the home-screen icon to match the in-app theme.
    /// Call once at launch as well, so the icon matches the saved theme.
    @MainActor
    func syncAppIcon() {
        let app = UIApplication.shared
        guard app.supportsAlternateIcons,
              app.alternateIconName != theme.alternateIconName else { return }

        app.setAlternateIconName(theme.alternateIconName) { error in
            if let error { print("App icon change failed: \(error.localizedDescription)") }
        }
    }
}
