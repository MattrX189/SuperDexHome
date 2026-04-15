//
//  ProfileCardView.swift
//  HomeScreen
//

import SwiftUI

struct ProfileCardView: View {
    let profile: ProfileCard

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 24)
                .fill(
                    LinearGradient(
                        colors: profile.theme.gradientColors,
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )

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

            RoundedRectangle(cornerRadius: 24)
                .strokeBorder(.white.opacity(0.1), lineWidth: 1)

            VStack(spacing: 0) {
                Spacer()

                Image(systemName: "person.circle.fill")
                    .font(.system(size: 52))
                    .foregroundStyle(.white.opacity(0.85))

                Spacer().frame(height: 16)

                Text(profile.name)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)

                Spacer().frame(height: 8)

                Text(profile.jobRole)
                    .font(.footnote)
                    .fontWeight(.medium)
                    .foregroundStyle(.white.opacity(0.85))
                    .padding(.horizontal, 14)
                    .padding(.vertical, 6)
                    .background(.white.opacity(0.15))
                    .clipShape(Capsule())

                Spacer().frame(height: 12)

                Text(profile.bio)
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.55))
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .padding(.horizontal, 20)

                Spacer()

                VStack(spacing: 10) {
                    HStack(spacing: 10) {
                        SocialButton(icon: .system("phone.fill"), label: "Phone", urlString: "tel:\(profile.phone.replacingOccurrences(of: " ", with: ""))")
                        SocialButton(icon: .system("envelope.fill"), label: "Email", urlString: "mailto:\(profile.email)")
                    }

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
