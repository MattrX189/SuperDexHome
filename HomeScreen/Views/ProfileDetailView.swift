//
//  ProfileDetailView.swift
//  HomeScreen
//
//  Created by Gaurang Pant on 15/04/26.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct ProfileDetailView: View {
    let profile: ProfileCard
    @Environment(\.openURL) private var openURL
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {

                // -- CARD SECTION --
                ZStack {
                    RoundedRectangle(cornerRadius: 28)
                        .fill(
                            LinearGradient(
                                colors: profile.theme.gradientColors,
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )

                    Circle()
                        .fill(profile.theme.accentColor.opacity(0.2))
                        .frame(width: 200, height: 200)
                        .blur(radius: 50)
                        .offset(x: -100, y: -80)

                    Circle()
                        .fill(.white.opacity(0.08))
                        .frame(width: 180, height: 180)
                        .blur(radius: 40)
                        .offset(x: 110, y: 100)

                    RoundedRectangle(cornerRadius: 28)
                        .strokeBorder(.white.opacity(0.12), lineWidth: 1)

                    VStack(spacing: 16) {
                        Spacer().frame(height: 8)

                        ZStack {
                            Circle()
                                .fill(.white.opacity(0.12))
                                .frame(width: 90, height: 90)
                            Image(systemName: "person.fill")
                                .font(.system(size: 38))
                                .foregroundStyle(.white.opacity(0.9))
                        }

                        Text(profile.name)
                            .font(.system(size: 32, weight: .bold))
                            .foregroundStyle(.white)

                        Text(profile.jobRole)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(.white.opacity(0.18))
                            .clipShape(Capsule())

                        Text(profile.bio)
                            .font(.callout)
                            .foregroundStyle(.white.opacity(0.6))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 24)

                        // QR Code
                        VStack(spacing: 8) {
                            if let qrImage = generateQRCode(from: qrContent) {
                                Image(uiImage: qrImage)
                                    .interpolation(.none)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .padding(10)
                                    .background(.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                            }

                            Text("Scan to connect")
                                .font(.caption2)
                                .foregroundStyle(.white.opacity(0.4))
                        }
                        .padding(.top, 4)

                        Spacer().frame(height: 8)
                    }
                    .padding(.vertical, 16)
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)

                // -- CONTACT SECTION --
                VStack(spacing: 12) {
                    Text("CONTACT")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 4)

                    HStack(spacing: 12) {
                        ContactTile(icon: "phone.fill", label: "Phone", value: profile.phone, color: .green) {
                            if let url = URL(string: "tel:\(profile.phone.replacingOccurrences(of: " ", with: ""))") {
                                openURL(url)
                            }
                        }

                        ContactTile(icon: "envelope.fill", label: "Email", value: profile.email, color: .blue) {
                            if let url = URL(string: "mailto:\(profile.email)") {
                                openURL(url)
                            }
                        }
                    }

                    HStack(spacing: 12) {
                        ContactTile(icon: "camera.fill", label: "Instagram", value: profile.instagram, color: .pink) {
                            if let url = URL(string: "https://instagram.com/\(profile.instagram.replacingOccurrences(of: "@", with: ""))") {
                                openURL(url)
                            }
                        }

                        ContactTile(icon: "person.2.fill", label: "LinkedIn", value: profile.linkedin, color: .indigo) {
                            if let url = URL(string: "https://\(profile.linkedin)") {
                                openURL(url)
                            }
                        }
                    }

                    HStack(spacing: 12) {
                        ContactTile(icon: "at", label: "X", value: profile.x, color: Color(.label)) {
                            if let url = URL(string: "https://x.com/\(profile.x.replacingOccurrences(of: "@", with: ""))") {
                                openURL(url)
                            }
                        }

                        ContactTile(icon: "terminal.fill", label: "GitHub", value: profile.github, color: .purple) {
                            if let url = URL(string: "https://\(profile.github)") {
                                openURL(url)
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 24)
                .padding(.bottom, 40)
            }
        }
        .background(Color(.systemGroupedBackground))
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    HStack(spacing: 4) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 16, weight: .semibold))
                        Text("Back")
                            .font(.body)
                    }
                }
            }
        }
    }

    private var qrContent: String {
        "BEGIN:VCARD\nVERSION:3.0\nFN:\(profile.name)\nTITLE:\(profile.jobRole)\nTEL:\(profile.phone)\nEMAIL:\(profile.email)\nURL:https://\(profile.github)\nEND:VCARD"
    }

    private func generateQRCode(from string: String) -> UIImage? {
        let filter = CIFilter.qrCodeGenerator()
        guard let data = string.data(using: .utf8) else { return nil }
        filter.message = data
        filter.correctionLevel = "M"
        guard let ciImage = filter.outputImage else { return nil }
        let transform = CGAffineTransform(scaleX: 10, y: 10)
        let scaledImage = ciImage.transformed(by: transform)
        let context = CIContext()
        guard let cgImage = context.createCGImage(scaledImage, from: scaledImage.extent) else { return nil }
        return UIImage(cgImage: cgImage)
    }
}

#Preview {
    NavigationStack {
        ProfileDetailView(
            profile: ProfileCard(
                name: "Ben",
                jobRole: "iOS Developer",
                bio: "Building delightful apps one pixel at a time.",
                phone: "+1 (555) 100-2001",
                email: "ben@example.com",
                instagram: "@ben.dev",
                linkedin: "linkedin.com/in/ben",
                x: "@ben_dev",
                github: "github.com/ben",
                theme: CardTheme.themes[1]
            )
        )
    }
}
