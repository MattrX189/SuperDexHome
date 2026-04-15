//
//  ProfileCards.swift
//  HomeScreen
//
//  Created by Gaurang Pant on 15/04/26.
//

import SwiftUI

struct CardTheme: Hashable {
    let gradientColors: [Color]
    let accentColor: Color

    static let themes: [CardTheme] = [
        // Dark noir
        CardTheme(gradientColors: [Color(.systemIndigo),.blue ,.purple], accentColor: .white),
        // Deep ocean
        CardTheme(gradientColors: [.cyan, .blue, Color(.systemIndigo)], accentColor: .cyan),
        // Sunset
        CardTheme(gradientColors: [.orange, .pink, .purple], accentColor: .orange),
        // Forest
        CardTheme(gradientColors: [.mint, .green, Color(red: 0.1, green: 0.3, blue: 0.2)], accentColor: .mint),
        // Royal purple
        CardTheme(gradientColors: [.purple, .indigo, Color(red: 0.15, green: 0.05, blue: 0.3)], accentColor: .purple),
        // Crimson
        CardTheme(gradientColors: [.red, Color(red: 0.6, green: 0, blue: 0.1), .black], accentColor: .red),
    ]
}

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

private let sampleProfiles: [ProfileCard] = [
    ProfileCard(name: "Ben", jobRole: "iOS Developer", bio: "Building delightful apps one pixel at a time.", phone: "+1 (555) 100-2001", email: "ben@example.com", instagram: "@ben.dev", linkedin: "linkedin.com/in/ben", x: "@ben_dev", github: "github.com/ben", theme: CardTheme.themes[0]),
    ProfileCard(name: "Sara", jobRole: "UX Designer", bio: "Designing experiences that feel like magic.", phone: "+1 (555) 200-3002", email: "sara@example.com", instagram: "@sara.ux", linkedin: "linkedin.com/in/sara", x: "@sara_ux", github: "github.com/sara", theme: CardTheme.themes[1]),
    ProfileCard(name: "Alex", jobRole: "Backend Engineer", bio: "Scaling systems and solving hard problems.", phone: "+1 (555) 300-4003", email: "alex@example.com", instagram: "@alex.code", linkedin: "linkedin.com/in/alex", x: "@alex_code", github: "github.com/alex", theme: CardTheme.themes[2]),
    ProfileCard(name: "Maya", jobRole: "Product Manager", bio: "Turning ideas into products people love.", phone: "+1 (555) 400-5004", email: "maya@example.com", instagram: "@maya.pm", linkedin: "linkedin.com/in/maya", x: "@maya_pm", github: "github.com/maya", theme: CardTheme.themes[3]),
    ProfileCard(name: "Jake", jobRole: "DevOps Engineer", bio: "Automating everything, breaking nothing.", phone: "+1 (555) 500-6005", email: "jake@example.com", instagram: "@jake.ops", linkedin: "linkedin.com/in/jake", x: "@jake_ops", github: "github.com/jake", theme: CardTheme.themes[4]),
    ProfileCard(name: "Lily", jobRole: "Data Scientist", bio: "Finding stories hidden in the numbers.", phone: "+1 (555) 600-7006", email: "lily@example.com", instagram: "@lily.data", linkedin: "linkedin.com/in/lily", x: "@lily_data", github: "github.com/lily", theme: CardTheme.themes[5]),
]

struct ProfileCardView: View {
    let profile: ProfileCard

    var body: some View {
        ZStack {
            // Gradient background
            RoundedRectangle(cornerRadius: 24)
                .fill(
                    LinearGradient(
                        colors: profile.theme.gradientColors,
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )

            // Decorative glowing circles
            Circle()
                .fill(profile.theme.accentColor.opacity(0.15))
                .frame(width: 180, height: 180)
                .blur(radius: 40)
                .offset(x: -90, y: -110)

            Circle()
                .fill(.white.opacity(0.08))
                .frame(width: 140, height: 140)
                .blur(radius: 30)
                .offset(x: 100, y: 100)

            // Border
            RoundedRectangle(cornerRadius: 24)
                .strokeBorder(.white.opacity(0.1), lineWidth: 1)

            // Content
            VStack(spacing: 0) {
                Spacer()

                // Avatar
                Image(systemName: "person.circle.fill")
                    .font(.system(size: 52))
                    .foregroundStyle(.white.opacity(0.85))

                Spacer().frame(height: 16)

                // Name
                Text(profile.name)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)

                Spacer().frame(height: 8)

                // Job role pill
                Text(profile.jobRole)
                    .font(.footnote)
                    .fontWeight(.medium)
                    .foregroundStyle(.white.opacity(0.85))
                    .padding(.horizontal, 14)
                    .padding(.vertical, 6)
                    .background(.white.opacity(0.15))
                    .clipShape(Capsule())

                Spacer().frame(height: 12)

                // Bio
                Text(profile.bio)
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.55))
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .padding(.horizontal, 20)

                Spacer()

                // Social buttons — 44pt tap targets per Apple HIG
                VStack(spacing: 10) {
                    // Row 1: Phone & Email
                    HStack(spacing: 10) {
                        SocialButton(icon: .system("phone.fill"), label: "Phone", urlString: "tel:\(profile.phone.replacingOccurrences(of: " ", with: ""))")
                        SocialButton(icon: .system("envelope.fill"), label: "Email", urlString: "mailto:\(profile.email)")
                    }

                    // Row 2: Instagram, LinkedIn, X, GitHub (icon only)
                    HStack(spacing: 10) {
                        SocialIconButton(icon: .brand("instagram"), urlString: "https://instagram.com/\(profile.instagram.replacingOccurrences(of: "@", with: ""))")
                        SocialIconButton(icon: .brand("linkedin"), urlString: "https://\(profile.linkedin)")
                        SocialIconButton(icon: .brand("x"), urlString: "https://x.com/\(profile.x.replacingOccurrences(of: "@", with: ""))")
                        SocialIconButton(icon: .brand("github"), urlString: "https://\(profile.github)")
                    }
                }
            }
            .padding(20)
        }
        .frame(width: 280, height: 400)
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .shadow(color: profile.theme.gradientColors.first?.opacity(0.35) ?? .black.opacity(0.3), radius: 14, y: 8)
    }
}

enum SocialIconType {
    case system(String)
    case brand(String)
}

struct SocialButton: View {
    @Environment(\.openURL) private var openURL
    let icon: SocialIconType
    let label: String
    var urlString: String = ""

    var body: some View {
        Button {
            if let url = URL(string: urlString) {
                openURL(url)
            }
        } label: {
            HStack(spacing: 6) {
                Group {
                    switch icon {
                    case .system(let name):
                        Image(systemName: name)
                            .font(.system(size: 14, weight: .medium))
                    case .brand(let name):
                        BrandIcon(name: name)
                    }
                }
                .frame(width: 18, height: 18)

                Text(label)
                    .font(.system(size: 11, weight: .medium))
            }
            .foregroundStyle(.white.opacity(0.75))
            .frame(maxWidth: .infinity)
            .frame(height: 44)
            .background(.white.opacity(0.12))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .buttonStyle(.plain)
    }
}

struct SocialIconButton: View {
    @Environment(\.openURL) private var openURL
    let icon: SocialIconType
    var urlString: String = ""

    var body: some View {
        Button {
            if let url = URL(string: urlString) {
                openURL(url)
            }
        } label: {
            Group {
                switch icon {
                case .system(let name):
                    Image(systemName: name)
                        .font(.system(size: 16, weight: .medium))
                case .brand(let name):
                    BrandIcon(name: name)
                }
            }
            .foregroundStyle(.white.opacity(0.75))
            .frame(width: 44, height: 44)
            .background(.white.opacity(0.12))
            .clipShape(Circle())
            .contentShape(Circle())
        }
        .buttonStyle(.plain)
    }
}

// Brand icons drawn with SwiftUI shapes
struct BrandIcon: View {
    let name: String

    var body: some View {
        switch name {
        case "instagram":
            InstagramIcon()
        case "linkedin":
            LinkedInIcon()
        case "x":
            XIcon()
        case "github":
            GitHubIcon()
        default:
            EmptyView()
        }
    }
}

struct InstagramIcon: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 4)
                .stroke(Color.white.opacity(0.75), lineWidth: 1.4)
                .frame(width: 14, height: 14)
            Circle()
                .stroke(Color.white.opacity(0.75), lineWidth: 1.4)
                .frame(width: 6, height: 6)
            Circle()
                .fill(Color.white.opacity(0.75))
                .frame(width: 2, height: 2)
                .offset(x: 3.5, y: -3.5)
        }
    }
}

struct LinkedInIcon: View {
    var body: some View {
        Text("in")
            .font(.system(size: 12, weight: .bold, design: .serif))
            .foregroundStyle(.white.opacity(0.75))
    }
}

struct XIcon: View {
    var body: some View {
        Text("𝕏")
            .font(.system(size: 14, weight: .bold))
            .foregroundStyle(.white.opacity(0.75))
    }
}

struct GitHubIcon: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.white.opacity(0.75))
                .frame(width: 14, height: 14)
            Circle()
                .fill(Color.black.opacity(0.9))
                .frame(width: 12, height: 12)
            // Cat ear shapes
            Circle()
                .fill(Color.white.opacity(0.75))
                .frame(width: 5, height: 5)
                .offset(x: -3.5, y: -5)
            Circle()
                .fill(Color.white.opacity(0.75))
                .frame(width: 5, height: 5)
                .offset(x: 3.5, y: -5)
            // Face
            Circle()
                .fill(Color.white.opacity(0.75))
                .frame(width: 12, height: 12)
            Circle()
                .fill(Color.black.opacity(0.9))
                .frame(width: 10, height: 10)
            // Eyes
            Circle()
                .fill(Color.white.opacity(0.75))
                .frame(width: 2.5, height: 2.5)
                .offset(x: -2, y: -0.5)
            Circle()
                .fill(Color.white.opacity(0.75))
                .frame(width: 2.5, height: 2.5)
                .offset(x: 2, y: -0.5)
        }
    }
}

struct ProfileCardsView: View {
    @State private var profiles: [ProfileCard] = sampleProfiles
    @State private var dragOffset: CGSize = .zero
    @Binding var selectedProfile: ProfileCard?

    init(selectedProfile: Binding<ProfileCard?> = .constant(nil)) {
        _selectedProfile = selectedProfile
    }

    var body: some View {
        ZStack {
            ForEach(Array(profiles.enumerated().prefix(4).reversed()), id: \.element.id) { index, profile in
                let isTop = index == 0

                ProfileCardView(profile: profile)
                    .scaleEffect(1 - CGFloat(index) * 0.05)
                    .offset(y: CGFloat(index) * 12)
                    .offset(x: isTop ? dragOffset.width : 0)
                    .rotationEffect(isTop ? .degrees(Double(dragOffset.width) / 20) : .zero)
                    .animation(.spring(response: 0.4, dampingFraction: 0.75), value: dragOffset)
                    .onTapGesture {
                        if isTop {
                            selectedProfile = profile
                        }
                    }
                    .gesture(
                        isTop ? DragGesture()
                            .onChanged { value in
                                dragOffset = value.translation
                            }
                            .onEnded { value in
                                if abs(value.translation.width) > 120 {
                                    let direction: CGFloat = value.translation.width > 0 ? 1 : -1
                                    withAnimation(.easeIn(duration: 0.25)) {
                                        dragOffset = CGSize(width: direction * 500, height: 0)
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                                        let removed = profiles.removeFirst()
                                        profiles.append(removed)
                                        dragOffset = .zero
                                    }
                                } else {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                        dragOffset = .zero
                                    }
                                }
                            }
                        : nil
                    )
                    .zIndex(Double(profiles.count - index))
            }
        }
    }
}

#Preview {
    ProfileCardsView()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGroupedBackground))
}
