//
//  HomeView.swift
//  HomeScreen
//

import SwiftUI

struct HomeView: View {
    @State private var viewModel = HomeViewModel()

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        // Greeting section
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Hello, Gaurang")
                                .font(.largeTitle)
                                .fontWeight(.bold)

                            Text("Welcome to SuperDex")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        .padding(.horizontal)

                        // Search bar
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundStyle(.secondary)

                            TextField("Search", text: $viewModel.searchText)
                        }
                        .padding(12)
                        .background(Color(.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .padding(.horizontal)

                        // Group cards
                        if viewModel.groups.isEmpty {
                            ContentUnavailableView(
                                "No Groups Yet",
                                systemImage: "rectangle.stack.badge.plus",
                                description: Text("Tap the + button to create a group.")
                            )
                            .padding(.top, 40)
                        } else {
                            LazyVStack(spacing: 16) {
                                ForEach(viewModel.groups) { group in
                                    GroupCardView(
                                        group: group,
                                        isExpanded: viewModel.expandedGroupID == group.id,
                                        selectedProfile: $viewModel.selectedProfile,
                                        onHeaderTap: {
                                            withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                                                viewModel.toggleExpansion(for: group.id)
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
                    viewModel.prepareNewGroup()
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
            .navigationDestination(item: $viewModel.selectedProfile) { profile in
                ProfileDetailView(profile: profile)
            }
            .alert("New Group", isPresented: $viewModel.showingNewGroupAlert) {
                TextField("Group name", text: $viewModel.newGroupName)
                Button("Cancel", role: .cancel) { }
                Button("Create") {
                    viewModel.createGroup()
                }
            } message: {
                Text("Enter a name for the new group.")
            }
        }
    }
}
