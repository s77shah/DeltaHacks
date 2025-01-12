//
//  HistoryView.swift
//  dh2
//
//  Created by Sania Shah on 2025-01-11.
//
import SwiftUI

struct HistoryView: View {
    @EnvironmentObject var feedViewModel: FeedViewModel

    var body: some View {
        NavigationView {
            List {
                ForEach(feedViewModel.posts.filter { $0.username == "Current User" }, id: \.id) { post in
                    PostRow(post: .constant(post)) // Bind constant `Post` for the history
                }
            }
            .navigationTitle("Your Posts")
        }
    }
}
