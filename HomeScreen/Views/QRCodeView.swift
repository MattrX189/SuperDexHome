//
//  QRCodeView.swift
//  HomeScreen
//
//  Created by Gaurang Pant on 15/04/26.
//

import SwiftUI

struct QRCodeView: View {
    @State private var viewModel = QRCodeViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: viewModel.profile.theme.gradientColors,
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                Circle()
                    .fill(viewModel.profile.theme.accentColor.opacity(0.15))
                    .frame(width: 250, height: 250)
                    .blur(radius: 60)
                    .offset(x: -120, y: -200)

                Circle()
                    .fill(.white.opacity(0.06))
                    .frame(width: 200, height: 200)
                    .blur(radius: 50)
                    .offset(x: 130, y: 200)

                VStack(spacing: 24) {
                    Spacer()

                    if viewModel.profile.name.isEmpty {
                        VStack(spacing: 16) {
                            Image(systemName: "qrcode")
                                .font(.system(size: 60))
                                .foregroundStyle(.white.opacity(0.3))

                            Text("No Profile Yet")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundStyle(.white.opacity(0.7))

                            Text("Set up your profile to generate\na personal QR code.")
                                .font(.subheadline)
                                .foregroundStyle(.white.opacity(0.4))
                                .multilineTextAlignment(.center)
                        }
                    } else {
                        Text(viewModel.profile.name)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)

                        if !viewModel.profile.jobRole.isEmpty {
                            Text(viewModel.profile.jobRole)
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .foregroundStyle(.white.opacity(0.7))
                                .padding(.horizontal, 16)
                                .padding(.vertical, 6)
                                .background(.white.opacity(0.15))
                                .clipShape(Capsule())
                        }

                        if let qrImage = viewModel.generateQRCode() {
                            VStack(spacing: 16) {
                                Image(uiImage: qrImage)
                                    .interpolation(.none)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 200, height: 200)
                            }
                            .padding(24)
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 24))
                            .shadow(color: .black.opacity(0.15), radius: 20, y: 10)
                        }

                        Text("Scan to save contact")
                            .font(.footnote)
                            .foregroundStyle(.white.opacity(0.4))
                    }

                    Spacer()
                }
                .padding(.horizontal, 20)
            }
            .navigationTitle("My QR Code")
            .toolbarColorScheme(.dark, for: .navigationBar)
            .onAppear {
                viewModel.reloadProfile()
            }
        }
    }
}

#Preview {
    QRCodeView()
}
