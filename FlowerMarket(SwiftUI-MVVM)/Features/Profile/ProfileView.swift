//
//  ProfileView.swift
//  FlowerMarket(SwiftUI-MVVM)
//
//  Created by Reham on 01/01/2026.
//


import SwiftUI

struct ProfileView: View {

    var body: some View {

        ScrollView {

            VStack(spacing: 24) {

                // MARK: - Header
                VStack(spacing: 12) {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .frame(width: 90, height: 90)
                        .foregroundStyle(.blue)

                    Text("Reham Saad")
                        .font(.title2.bold())

                    Text("reham@email.com")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.top, 32)

                // MARK: - Options
                VStack(spacing: 16) {

                    profileRow(
                        icon: "bag",
                        title: "My Orders"
                    )

                    profileRow(
                        icon: "location",
                        title: "Shipping Address"
                    )

                    profileRow(
                        icon: "gearshape",
                        title: "Settings"
                    )

                    profileRow(
                        icon: "questionmark.circle",
                        title: "Help & Support"
                    )
                }

                // MARK: - Logout
                Button {
                    // Logout action
                } label: {
                    Text("Log Out")
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.red.opacity(0.3))
                        )
                }
                .padding(.top, 16)
            }
            .padding(.horizontal)
        }
    }

    // MARK: - Reusable Row
    private func profileRow(icon: String, title: String) -> some View {
        HStack(spacing: 16) {

            Image(systemName: icon)
                .frame(width: 32)
                .foregroundColor(.blue)

            Text(title)
                .font(.body)

            Spacer()

            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(16)
    }
}
