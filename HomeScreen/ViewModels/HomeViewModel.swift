//
//  HomeViewModel.swift
//  HomeScreen
//

import SwiftUI

@Observable
final class HomeViewModel {
    var searchText = ""
    var groups: [CardGroup] = CardGroup.loadAll()
    var showingNewGroupAlert = false
    var newGroupName = ""
    var expandedGroupID: UUID?
    var selectedProfile: ProfileCard?

    func toggleExpansion(for groupID: UUID) {
        if expandedGroupID == groupID {
            expandedGroupID = nil
        } else {
            expandedGroupID = groupID
        }
    }

    func createGroup() {
        let trimmed = newGroupName.trimmingCharacters(in: .whitespaces)
        if !trimmed.isEmpty {
            groups.append(CardGroup(name: trimmed))
            CardGroup.saveAll(groups)
        }
    }

    func prepareNewGroup() {
        newGroupName = ""
        showingNewGroupAlert = true
    }
}
