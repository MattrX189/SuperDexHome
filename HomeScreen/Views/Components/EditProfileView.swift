//
//  EditProfileView.swift
//  HomeScreen
//

import SwiftUI

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
