//
//  UserProfile.swift
//  HomeScreen
//
//  Created by Gaurang Pant on 15/04/26.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

// MARK: - Persisted user profile data

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

// MARK: - User Profile View

struct UserProfileView: View {
    @State private var profile = UserProfileData.load()
    @State private var isEditing = false
    @Environment(\.openURL) private var openURL

    var body: some View {
        NavigationStack {
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

                            Text(profile.name.isEmpty ? "Your Name" : profile.name)
                                .font(.system(size: 32, weight: .bold))
                                .foregroundStyle(.white.opacity(profile.name.isEmpty ? 0.4 : 1))

                            if !profile.jobRole.isEmpty {
                                Text(profile.jobRole)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.white)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .background(.white.opacity(0.18))
                                    .clipShape(Capsule())
                            }

                            if !profile.bio.isEmpty {
                                Text(profile.bio)
                                    .font(.callout)
                                    .foregroundStyle(.white.opacity(0.6))
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 24)
                            }

                            // QR Code
                            if !profile.name.isEmpty {
                                VStack(spacing: 8) {
                                    if let qrImage = generateQRCode() {
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
                            }

                            Spacer().frame(height: 8)
                        }
                        .padding(.vertical, 16)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 10)

                    // -- CONTACT SECTION --
                    if hasContactInfo {
                        VStack(spacing: 12) {
                            Text("CONTACT")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundStyle(.secondary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 4)

                            if !profile.phone.isEmpty || !profile.email.isEmpty {
                                HStack(spacing: 12) {
                                    if !profile.phone.isEmpty {
                                        ContactTile(icon: "phone.fill", label: "Phone", value: profile.phone, color: .green) {
                                            if let url = URL(string: "tel:\(profile.phone.replacingOccurrences(of: " ", with: ""))") {
                                                openURL(url)
                                            }
                                        }
                                    }
                                    if !profile.email.isEmpty {
                                        ContactTile(icon: "envelope.fill", label: "Email", value: profile.email, color: .blue) {
                                            if let url = URL(string: "mailto:\(profile.email)") {
                                                openURL(url)
                                            }
                                        }
                                    }
                                }
                            }

                            if !profile.instagram.isEmpty || !profile.linkedin.isEmpty {
                                HStack(spacing: 12) {
                                    if !profile.instagram.isEmpty {
                                        ContactTile(icon: "camera.fill", label: "Instagram", value: profile.instagram, color: .pink) {
                                            if let url = URL(string: "https://instagram.com/\(profile.instagram.replacingOccurrences(of: "@", with: ""))") {
                                                openURL(url)
                                            }
                                        }
                                    }
                                    if !profile.linkedin.isEmpty {
                                        ContactTile(icon: "person.2.fill", label: "LinkedIn", value: profile.linkedin, color: .indigo) {
                                            if let url = URL(string: "https://\(profile.linkedin)") {
                                                openURL(url)
                                            }
                                        }
                                    }
                                }
                            }

                            if !profile.x.isEmpty || !profile.github.isEmpty {
                                HStack(spacing: 12) {
                                    if !profile.x.isEmpty {
                                        ContactTile(icon: "at", label: "X", value: profile.x, color: Color(.label)) {
                                            if let url = URL(string: "https://x.com/\(profile.x.replacingOccurrences(of: "@", with: ""))") {
                                                openURL(url)
                                            }
                                        }
                                    }
                                    if !profile.github.isEmpty {
                                        ContactTile(icon: "terminal.fill", label: "GitHub", value: profile.github, color: .purple) {
                                            if let url = URL(string: "https://\(profile.github)") {
                                                openURL(url)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 24)
                    }

                    Spacer().frame(height: 40)
                }
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("My Profile")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isEditing = true
                    } label: {
                        Image(systemName: "pencil.circle.fill")
                            .font(.title3)
                    }
                }
            }
            .sheet(isPresented: $isEditing) {
                EditProfileView(profile: $profile) {
                    profile.save()
                }
            }
            .onChange(of: profile) {
                profile.save()
            }
        }
    }

    private var hasContactInfo: Bool {
        !profile.phone.isEmpty || !profile.email.isEmpty ||
        !profile.instagram.isEmpty || !profile.linkedin.isEmpty ||
        !profile.x.isEmpty || !profile.github.isEmpty
    }

    private func generateQRCode() -> UIImage? {
        let vcard = "BEGIN:VCARD\nVERSION:3.0\nFN:\(profile.name)\nTITLE:\(profile.jobRole)\nTEL:\(profile.phone)\nEMAIL:\(profile.email)\nURL:https://\(profile.github)\nEND:VCARD"
        let filter = CIFilter.qrCodeGenerator()
        guard let data = vcard.data(using: .utf8) else { return nil }
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

// MARK: - Edit Profile Sheet

struct EditProfileView: View {
    @Binding var profile: UserProfileData
    let onSave: () -> Void
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            Form {
                Section("Personal") {
                    EditField(label: "Name", text: $profile.name, icon: "person.fill")
                    EditField(label: "Job Role", text: $profile.jobRole, icon: "briefcase.fill")
                    EditField(label: "Bio", text: $profile.bio, icon: "text.quote")
                }

                Section("Contact") {
                    EditField(label: "Phone", text: $profile.phone, icon: "phone.fill", keyboard: .phonePad)
                    EditField(label: "Email", text: $profile.email, icon: "envelope.fill", keyboard: .emailAddress)
                }

                Section("Social") {
                    EditField(label: "Instagram", text: $profile.instagram, icon: "camera.fill")
                    EditField(label: "LinkedIn", text: $profile.linkedin, icon: "person.2.fill")
                    EditField(label: "X", text: $profile.x, icon: "at")
                    EditField(label: "GitHub", text: $profile.github, icon: "terminal.fill")
                }

                Section("Theme") {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(0..<CardTheme.themes.count, id: \.self) { index in
                                let theme = CardTheme.themes[index]
                                Circle()
                                    .fill(
                                        LinearGradient(
                                            colors: theme.gradientColors,
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .frame(width: 44, height: 44)
                                    .overlay(
                                        Circle()
                                            .strokeBorder(.white, lineWidth: profile.themeIndex == index ? 3 : 0)
                                    )
                                    .shadow(color: profile.themeIndex == index ? theme.accentColor.opacity(0.5) : .clear, radius: 6)
                                    .onTapGesture {
                                        profile.themeIndex = index
                                    }
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .navigationTitle("Edit Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        onSave()
                        dismiss()
                    }
                    .fontWeight(.semibold)
                }
            }
        }
    }
}

struct EditField: View {
    let label: String
    @Binding var text: String
    let icon: String
    var keyboard: UIKeyboardType = .default

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundStyle(.secondary)
                .frame(width: 24)
            TextField(label, text: $text)
                .keyboardType(keyboard)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
        }
    }
}

#Preview {
    UserProfileView()
}
