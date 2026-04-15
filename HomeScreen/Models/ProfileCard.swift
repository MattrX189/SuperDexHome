//
//  ProfileCard.swift
//  HomeScreen
//

import Foundation

struct ProfileCard: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let jobRole: String
    let bio: String
    let phone: String
    let email: String
    let instagram: String
    let linkedin: String
    let x: String
    let github: String
    let theme: CardTheme
}

let sampleProfiles: [ProfileCard] = [
    ProfileCard(name: "Ben", jobRole: "iOS Developer", bio: "Building delightful apps one pixel at a time.", phone: "+1 (555) 100-2001", email: "ben@example.com", instagram: "@ben.dev", linkedin: "linkedin.com/in/ben", x: "@ben_dev", github: "github.com/ben", theme: CardTheme.themes[0]),
    ProfileCard(name: "Sara", jobRole: "UX Designer", bio: "Designing experiences that feel like magic.", phone: "+1 (555) 200-3002", email: "sara@example.com", instagram: "@sara.ux", linkedin: "linkedin.com/in/sara", x: "@sara_ux", github: "github.com/sara", theme: CardTheme.themes[1]),
    ProfileCard(name: "Alex", jobRole: "Backend Engineer", bio: "Scaling systems and solving hard problems.", phone: "+1 (555) 300-4003", email: "alex@example.com", instagram: "@alex.code", linkedin: "linkedin.com/in/alex", x: "@alex_code", github: "github.com/alex", theme: CardTheme.themes[2]),
    ProfileCard(name: "Maya", jobRole: "Product Manager", bio: "Turning ideas into products people love.", phone: "+1 (555) 400-5004", email: "maya@example.com", instagram: "@maya.pm", linkedin: "linkedin.com/in/maya", x: "@maya_pm", github: "github.com/maya", theme: CardTheme.themes[3]),
    ProfileCard(name: "Jake", jobRole: "DevOps Engineer", bio: "Automating everything, breaking nothing.", phone: "+1 (555) 500-6005", email: "jake@example.com", instagram: "@jake.ops", linkedin: "linkedin.com/in/jake", x: "@jake_ops", github: "github.com/jake", theme: CardTheme.themes[4]),
    ProfileCard(name: "Lily", jobRole: "Data Scientist", bio: "Finding stories hidden in the numbers.", phone: "+1 (555) 600-7006", email: "lily@example.com", instagram: "@lily.data", linkedin: "linkedin.com/in/lily", x: "@lily_data", github: "github.com/lily", theme: CardTheme.themes[5]),
]
