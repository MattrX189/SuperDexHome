//
//  SocialButtons.swift
//  HomeScreen
//

import SwiftUI

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
