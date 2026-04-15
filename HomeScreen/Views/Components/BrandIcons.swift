//
//  BrandIcons.swift
//  HomeScreen
//

import SwiftUI

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
        Text("\u{1D54F}")
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
            Circle()
                .fill(Color.white.opacity(0.75))
                .frame(width: 5, height: 5)
                .offset(x: -3.5, y: -5)
            Circle()
                .fill(Color.white.opacity(0.75))
                .frame(width: 5, height: 5)
                .offset(x: 3.5, y: -5)
            Circle()
                .fill(Color.white.opacity(0.75))
                .frame(width: 12, height: 12)
            Circle()
                .fill(Color.black.opacity(0.9))
                .frame(width: 10, height: 10)
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
