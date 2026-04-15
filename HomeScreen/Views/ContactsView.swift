//
//  ContactsView.swift
//  HomeScreen
//

import SwiftUI

struct ContactsView: View {
    private let contacts: [ProfileCard] = sampleProfiles
    @State private var selectedProfile: ProfileCard?

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(contacts) { contact in
                        ContactRow(contact: contact)
                            .onTapGesture {
                                selectedProfile = contact
                            }
                    }
                }
                .padding(.horizontal)
                .padding(.top, 8)
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Contacts")
            .navigationDestination(item: $selectedProfile) { profile in
                ProfileDetailView(profile: profile)
            }
        }
    }
}

struct ContactRow: View {
    let contact: ProfileCard
    @Environment(\.openURL) private var openURL

    var body: some View {
        HStack(spacing: 14) {
            // Avatar
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: contact.theme.gradientColors,
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 48, height: 48)

                Image(systemName: "person.fill")
                    .font(.system(size: 20))
                    .foregroundStyle(.white.opacity(0.9))
            }

            // Name & Phone
            VStack(alignment: .leading, spacing: 3) {
                Text(contact.name)
                    .font(.headline)

                Text(contact.phone)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            // Call button
            Button {
                if let url = URL(string: "tel:\(contact.phone.replacingOccurrences(of: " ", with: ""))") {
                    openURL(url)
                }
            } label: {
                Image(systemName: "phone.fill")
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(.white)
                    .frame(width: 40, height: 40)
                    .background(.green.gradient)
                    .clipShape(Circle())
            }

            // Email button
            Button {
                if let url = URL(string: "mailto:\(contact.email)") {
                    openURL(url)
                }
            } label: {
                Image(systemName: "envelope.fill")
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(.white)
                    .frame(width: 40, height: 40)
                    .background(.blue.gradient)
                    .clipShape(Circle())
            }
        }
        .padding(14)
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    ContactsView()
}
