//
//  GroupCardView.swift
//  HomeScreen
//

import SwiftUI

struct GroupCardView: View {
    let group: CardGroup
    var isExpanded: Bool = false
    @Binding var selectedProfile: ProfileCard?
    var onHeaderTap: () -> Void = {}
    @State private var isListLayout = false

    var body: some View {
        VStack(spacing: 0) {
            // Tappable header area
            VStack(spacing: 0) {
                // Top area with gradient background and icon
                ZStack {
                    LinearGradient(
                        colors: [group.color, group.color.opacity(0.6)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )

                    // Decorative background circles
                    Circle()
                        .fill(.white.opacity(0.1))
                        .frame(width: 120, height: 120)
                        .offset(x: -60, y: -30)

                    Circle()
                        .fill(.white.opacity(0.08))
                        .frame(width: 80, height: 80)
                        .offset(x: 70, y: 20)

                    // Icon
                    Image(systemName: group.icon)
                        .font(.system(size: 40))
                        .foregroundStyle(.white)
                        .padding(20)
                        .background(.white.opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }
                .frame(height: 140)
                .clipped()

                // Info bar
                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(group.name)
                            .font(.headline)
                            .foregroundStyle(.primary)

                        Text("0 items")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }

                    Spacer()

                    if isExpanded {
                        Button {
                            withAnimation(.spring(response: 0.35, dampingFraction: 0.85)) {
                                isListLayout.toggle()
                            }
                        } label: {
                            Image(systemName: isListLayout ? "rectangle.grid.1x2.fill" : "square.grid.2x2.fill")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundStyle(group.color)
                                .padding(10)
                                .background(group.color.opacity(0.15))
                                .clipShape(Circle())
                        }
                    }

                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(group.color)
                        .padding(10)
                        .background(group.color.opacity(0.15))
                        .clipShape(Circle())
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
            }
            .contentShape(Rectangle())
            .onTapGesture {
                onHeaderTap()
            }

            // Expanded profile cards section (inside the card)
            if isExpanded {
                Divider()
                    .padding(.horizontal, 16)

                if isListLayout {
                    HProfileCardsView(selectedProfile: $selectedProfile)
                        .frame(maxHeight: 600)
                        .padding(.vertical, 16)
                        .transition(.opacity.combined(with: .scale(scale: 0.95, anchor: .top)))
                } else {
                    ProfileCardsView(selectedProfile: $selectedProfile)
                        .frame(height: 380)
                        .padding(.vertical, 16)
                        .transition(.opacity.combined(with: .scale(scale: 0.95, anchor: .top)))
                }
            }
        }
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black.opacity(0.1), radius: 8, y: 4)
    }
}
