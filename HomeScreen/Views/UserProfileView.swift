//
//  UserProfileView.swift
//  HomeScreen
//

import SwiftUI

struct UserProfileView: View {
    @State private var viewModel = UserProfileViewModel()
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
                                    colors: viewModel.profile.theme.gradientColors,
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )

                        Circle()
                            .fill(viewModel.profile.theme.accentColor.opacity(0.2))
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

                            Text(viewModel.profile.name.isEmpty ? "Your Name" : viewModel.profile.name)
                                .font(.system(size: 32, weight: .bold))
                                .foregroundStyle(.white.opacity(viewModel.profile.name.isEmpty ? 0.4 : 1))

                            if !viewModel.profile.jobRole.isEmpty {
                                Text(viewModel.profile.jobRole)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.white)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .background(.white.opacity(0.18))
                                    .clipShape(Capsule())
                            }

                            if !viewModel.profile.bio.isEmpty {
                                Text(viewModel.profile.bio)
                                    .font(.callout)
                                    .foregroundStyle(.white.opacity(0.6))
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 24)
                            }

                            // QR Code
                            if !viewModel.profile.name.isEmpty {
                                VStack(spacing: 8) {
                                    if let qrImage = viewModel.generateQRCode() {
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
                    if viewModel.hasContactInfo {
                        VStack(spacing: 12) {
                            Text("CONTACT")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundStyle(.secondary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 4)

                            if !viewModel.profile.phone.isEmpty || !viewModel.profile.email.isEmpty {
                                HStack(spacing: 12) {
                                    if !viewModel.profile.phone.isEmpty {
                                        ContactTile(icon: "phone.fill", label: "Phone", value: viewModel.profile.phone, color: .green) {
                                            if let url = URL(string: "tel:\(viewModel.profile.phone.replacingOccurrences(of: " ", with: ""))") {
                                                openURL(url)
                                            }
                                        }
                                    }
                                    if !viewModel.profile.email.isEmpty {
                                        ContactTile(icon: "envelope.fill", label: "Email", value: viewModel.profile.email, color: .blue) {
                                            if let url = URL(string: "mailto:\(viewModel.profile.email)") {
                                                openURL(url)
                                            }
                                        }
                                    }
                                }
                            }

                            if !viewModel.profile.instagram.isEmpty || !viewModel.profile.linkedin.isEmpty {
                                HStack(spacing: 12) {
                                    if !viewModel.profile.instagram.isEmpty {
                                        ContactTile(icon: "camera.fill", label: "Instagram", value: viewModel.profile.instagram, color: .pink) {
                                            if let url = URL(string: "https://instagram.com/\(viewModel.profile.instagram.replacingOccurrences(of: "@", with: ""))") {
                                                openURL(url)
                                            }
                                        }
                                    }
                                    if !viewModel.profile.linkedin.isEmpty {
                                        ContactTile(icon: "person.2.fill", label: "LinkedIn", value: viewModel.profile.linkedin, color: .indigo) {
                                            if let url = URL(string: "https://\(viewModel.profile.linkedin)") {
                                                openURL(url)
                                            }
                                        }
                                    }
                                }
                            }

                            if !viewModel.profile.x.isEmpty || !viewModel.profile.github.isEmpty {
                                HStack(spacing: 12) {
                                    if !viewModel.profile.x.isEmpty {
                                        ContactTile(icon: "at", label: "X", value: viewModel.profile.x, color: Color(.label)) {
                                            if let url = URL(string: "https://x.com/\(viewModel.profile.x.replacingOccurrences(of: "@", with: ""))") {
                                                openURL(url)
                                            }
                                        }
                                    }
                                    if !viewModel.profile.github.isEmpty {
                                        ContactTile(icon: "terminal.fill", label: "GitHub", value: viewModel.profile.github, color: .purple) {
                                            if let url = URL(string: "https://\(viewModel.profile.github)") {
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
                        viewModel.isEditing = true
                    } label: {
                        Image(systemName: "pencil.circle.fill")
                            .font(.title3)
                    }
                }
            }
            .sheet(isPresented: $viewModel.isEditing) {
                EditProfileView(profile: $viewModel.profile) {
                    viewModel.saveProfile()
                }
            }
            .onChange(of: viewModel.profile) {
                viewModel.saveProfile()
            }
        }
    }
}

#Preview {
    UserProfileView()
}
