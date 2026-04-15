//
//  CardGroup.swift
//  HomeScreen
//

import SwiftUI

struct CardGroup: Identifiable, Codable {
    let id: UUID
    var name: String
    var colorName: String
    var icon: String

    private static let colorMap: [String: Color] = [
        "blue": .blue, "purple": .purple, "orange": .orange,
        "pink": .pink, "teal": .teal, "indigo": .indigo
    ]
    private static let colorNames: [String] = Array(colorMap.keys)
    private static let icons: [String] = [
        "folder.fill", "star.fill", "heart.fill", "flag.fill",
        "bookmark.fill", "tag.fill", "mappin.circle.fill",
        "airplane", "camera.fill", "gift.fill"
    ]

    var color: Color {
        Self.colorMap[colorName] ?? .blue
    }

    init(name: String) {
        self.id = UUID()
        self.name = name
        self.colorName = Self.colorNames.randomElement()!
        self.icon = Self.icons.randomElement()!
    }

    static func loadAll() -> [CardGroup] {
        guard let data = UserDefaults.standard.data(forKey: "savedGroups"),
              let groups = try? JSONDecoder().decode([CardGroup].self, from: data) else {
            return []
        }
        return groups
    }

    static func saveAll(_ groups: [CardGroup]) {
        if let data = try? JSONEncoder().encode(groups) {
            UserDefaults.standard.set(data, forKey: "savedGroups")
        }
    }
}
