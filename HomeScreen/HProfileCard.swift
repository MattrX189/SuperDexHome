//
//  HProfileCard.swift
//  HomeScreen
//
//  Created by Gaurang Pant on 15/04/26.
//

import SwiftUI

struct HProfileCardView: View {
    let profile: ProfileCard

    var body: some View {
        ZStack {
            // Gradient background
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(
                        colors: profile.theme.gradientColors,
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )

            // Decorative glowing circles
            Circle()
                .fill(profile.theme.accentColor.opacity(0.15))
                .frame(width: 140, height: 140)
                .blur(radius: 35)
                .offset(x: -140, y: -40)

            Circle()
                .fill(.white.opacity(0.08))
                .frame(width: 120, height: 120)
                .blur(radius: 30)
                .offset(x: 140, y: 40)

            // Border
            RoundedRectangle(cornerRadius: 20)
                .strokeBorder(.white.opacity(0.1), lineWidth: 1)

            // Content — horizontal layout
            HStack(spacing: 16) {
                // Left: Avatar + Name + Role
                VStack(spacing: 8) {
                    Image(systemName: "person.circle.fill")
                        .font(.system(size: 44))
                        .foregroundStyle(.white.opacity(0.85))

                    Text(profile.name)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)

                    Text(profile.jobRole)
                        .font(.caption2)
                        .fontWeight(.medium)
                        .foregroundStyle(.white.opacity(0.85))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(.white.opacity(0.15))
                        .clipShape(Capsule())
                }
                .frame(width: 110)

                // Divider
                Rectangle()
                    .fill(.white.opacity(0.15))
                    .frame(width: 1)
                    .padding(.vertical, 16)

                // Right: Bio + Social buttons
                VStack(spacing: 12) {
                    Text(profile.bio)
                        .font(.caption)
                        .foregroundStyle(.white.opacity(0.55))
                        .lineLimit(2)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    // Contact row
                    HStack(spacing: 8) {
                        SocialButton(icon: .system("phone.fill"), label: "Phone", urlString: "tel:\(profile.phone.replacingOccurrences(of: " ", with: ""))")
                        SocialButton(icon: .system("envelope.fill"), label: "Email", urlString: "mailto:\(profile.email)")
                    }

                    // Social icons row
                    HStack(spacing: 8) {
                        SocialIconButton(icon: .brand("instagram"), urlString: "https://instagram.com/\(profile.instagram.replacingOccurrences(of: "@", with: ""))")
                        SocialIconButton(icon: .brand("linkedin"), urlString: "https://\(profile.linkedin)")
                        SocialIconButton(icon: .brand("x"), urlString: "https://x.com/\(profile.x.replacingOccurrences(of: "@", with: ""))")
                        SocialIconButton(icon: .brand("github"), urlString: "https://\(profile.github)")
                    }
                }
            }
            .padding(16)
        }
        .frame(height: 180)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: profile.theme.gradientColors.first?.opacity(0.35) ?? .black.opacity(0.3), radius: 14, y: 8)
    }
}

struct HProfileCardsView: View {
    @State private var profiles: [ProfileCard] = sampleProfiles
    @Binding var selectedProfile: ProfileCard?

    init(selectedProfile: Binding<ProfileCard?> = .constant(nil)) {
        _selectedProfile = selectedProfile
    }

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 16) {
                ForEach(profiles) { profile in
                    HProfileCardView(profile: profile)
                        .onTapGesture {
                            selectedProfile = profile
                        }
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
        }
    }
}

#Preview {
    NavigationStack {
        HProfileCardsView()
            .navigationDestination(item: .constant(nil as ProfileCard?)) { profile in
                ProfileDetailView(profile: profile)
            }
            .background(Color(.systemGroupedBackground))
    }
}
