//
//  CardTheme.swift
//  HomeScreen
//

import SwiftUI

struct CardTheme: Hashable {
    let gradientColors: [Color]
    let accentColor: Color

    static let themes: [CardTheme] = [
        CardTheme(gradientColors: [Color(.systemIndigo), .blue, .purple], accentColor: .white),
        CardTheme(gradientColors: [.cyan, .blue, Color(.systemIndigo)], accentColor: .cyan),
        CardTheme(gradientColors: [.orange, .pink, .purple], accentColor: .orange),
        CardTheme(gradientColors: [.mint, .green, Color(red: 0.1, green: 0.3, blue: 0.2)], accentColor: .mint),
        CardTheme(gradientColors: [.purple, .indigo, Color(red: 0.15, green: 0.05, blue: 0.3)], accentColor: .purple),
        CardTheme(gradientColors: [.red, Color(red: 0.6, green: 0, blue: 0.1), .black], accentColor: .red),
    ]
}
