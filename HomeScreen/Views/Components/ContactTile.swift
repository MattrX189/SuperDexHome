//
//  ContactTile.swift
//  HomeScreen
//

import SwiftUI

struct ContactTile: View {
    let icon: String
    let label: String
    let value: String
    let color: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 10) {
                Image(systemName: icon)
                    .font(.title3)
                    .foregroundStyle(.white)
                    .frame(width: 40, height: 40)
                    .background(color.gradient)
                    .clipShape(RoundedRectangle(cornerRadius: 10))

                Text(label)
                    .font(.caption)
                    .foregroundStyle(.secondary)

                Text(value)
                    .font(.footnote)
                    .fontWeight(.medium)
                    .foregroundStyle(.primary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(14)
            .background(Color(.secondarySystemGroupedBackground))
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
        .buttonStyle(.plain)
    }
}
