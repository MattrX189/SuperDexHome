//
//  ContentView.swift
//  HomeScreen
//
//  Created by Gaurang Pant on 15/04/26.
//

import SwiftUI

struct CardGroup: Identifiable, Codable {
    let id: UUID
    var name: String
    var colorName: String
    var icon: String

    private static let colorMap: [String: Color] = [
        "blue": .blue, "purple": .purple, "orange": .orange,
        "pink": .pink, "teal": .teal, "indigo": .indigo
    ]
    private static let colorNames: [String] = Array(colorMap.keys)
    private static let icons: [String] = [
        "folder.fill", "star.fill", "heart.fill", "flag.fill",
        "bookmark.fill", "tag.fill", "mappin.circle.fill",
        "airplane", "camera.fill", "gift.fill"
    ]

    var color: Color {
        Self.colorMap[colorName] ?? .blue
    }

    init(name: String) {
        self.id = UUID()
        self.name = name
        self.colorName = Self.colorNames.randomElement()!
        self.icon = Self.icons.randomElement()!
    }

    static func loadAll() -> [CardGroup] {
        guard let data = UserDefaults.standard.data(forKey: "savedGroups"),
              let groups = try? JSONDecoder().decode([CardGroup].self, from: data) else {
            return []
        }
        return groups
    }

    static func saveAll(_ groups: [CardGroup]) {
        if let data = try? JSONEncoder().encode(groups) {
            UserDefaults.standard.set(data, forKey: "savedGroups")
        }
    }
}

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house.fill") {
                HomeView()
            }
            
            Tab("QR Code", systemImage: "qrcode") {
                QRCodeView()
            }
            
            Tab("Profile", systemImage: "person.fill") {
                UserProfileView()
            }
        }
    }
}

struct HomeView: View {
    @State private var searchText = ""
    @State private var groups: [CardGroup] = CardGroup.loadAll()
    @State private var showingNewGroupAlert = false
    @State private var newGroupName = ""
    @State private var expandedGroupID: UUID?
    @State private var selectedProfile: ProfileCard?

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        // Greeting section
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Hello, Vanessa")
                                .font(.largeTitle)
                                .fontWeight(.bold)

                            Text("Welcome to TripSlide")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        .padding(.horizontal)

                        // Search bar
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundStyle(.secondary)

                            TextField("Search", text: $searchText)
                        }
                        .padding(12)
                        .background(Color(.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .padding(.horizontal)

                        // Group cards
                        if groups.isEmpty {
                            ContentUnavailableView(
                                "No Groups Yet",
                                systemImage: "rectangle.stack.badge.plus",
                                description: Text("Tap the + button to create a group.")
                            )
                            .padding(.top, 40)
                        } else {
                            LazyVStack(spacing: 16) {
                                ForEach(groups) { group in
                                    GroupCardView(
                                        group: group,
                                        isExpanded: expandedGroupID == group.id,
                                        selectedProfile: $selectedProfile,
                                        onHeaderTap: {
                                            withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                                                if expandedGroupID == group.id {
                                                    expandedGroupID = nil
                                                } else {
                                                    expandedGroupID = group.id
                                                }
                                            }
                                        }
                                    )
                                }
                            }
                            .padding(.horizontal)
                            .padding(.bottom, 80)
                        }
                    }
                    .padding(.top)
                }

                // Floating + button
                Button {
                    newGroupName = ""
                    showingNewGroupAlert = true
                } label: {
                    Image(systemName: "plus")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(width: 56, height: 56)
                        .background(Color.accentColor)
                        .clipShape(Circle())
                        .shadow(color: .accentColor.opacity(0.4), radius: 8, y: 4)
                }
                .padding(.trailing, 20)
                .padding(.bottom, 20)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(item: $selectedProfile) { profile in
                ProfileDetailView(profile: profile)
            }
            .alert("New Group", isPresented: $showingNewGroupAlert) {
                TextField("Group name", text: $newGroupName)
                Button("Cancel", role: .cancel) { }
                Button("Create") {
                    let trimmed = newGroupName.trimmingCharacters(in: .whitespaces)
                    if !trimmed.isEmpty {
                        groups.append(CardGroup(name: trimmed))
                        CardGroup.saveAll(groups)
                    }
                }
            } message: {
                Text("Enter a name for the new group.")
            }
        }
    }
}

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

#Preview {
    ContentView()
}
