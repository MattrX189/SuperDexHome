//
//  UserProfileData.swift
//  HomeScreen
//

import Foundation

struct UserProfileData: Codable, Equatable {
    var name: String = ""
    var jobRole: String = ""
    var bio: String = ""
    var phone: String = ""
    var email: String = ""
    var instagram: String = ""
    var linkedin: String = ""
    var x: String = ""
    var github: String = ""
    var themeIndex: Int = 0

    var theme: CardTheme {
        CardTheme.themes[themeIndex % CardTheme.themes.count]
    }

    static func load() -> UserProfileData {
        guard let data = UserDefaults.standard.data(forKey: "userProfile"),
              let profile = try? JSONDecoder().decode(UserProfileData.self, from: data) else {
            return UserProfileData()
        }
        return profile
    }

    func save() {
        if let data = try? JSONEncoder().encode(self) {
            UserDefaults.standard.set(data, forKey: "userProfile")
        }
    }
}
