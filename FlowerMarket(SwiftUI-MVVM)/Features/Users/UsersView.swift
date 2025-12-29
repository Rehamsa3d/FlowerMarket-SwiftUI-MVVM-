//
//  ContentView.swift
//  await + MVVM
//
//  Created by Reham on 28/12/2025.
//

import SwiftUI

struct UsersView: View {

    let users: [User]

    var body: some View {
        NavigationStack {
            List(users) { user in
                HStack {
                    AsyncImage(url: URL(string: user.image)) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())

                    VStack(alignment: .leading) {
                        Text("\(user.firstName) \(user.lastName)")
                        Text("Age: \(user.age)")
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("Users")
        }
    }
}
