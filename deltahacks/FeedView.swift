//
//  FeedView.swift
//  dh2
//
//  Created by Sania Shah on 2025-01-11.
//
import SwiftUI

struct FeedView: View {
    @EnvironmentObject var feedViewModel: FeedViewModel

    var body: some View {
        NavigationView {
            List($feedViewModel.posts) { $post in // Bind each post for mutability
                PostRow(post: $post)
            }
            .navigationTitle("Feed")
            .refreshable {
                await feedViewModel.fetchPosts()
            }
        }
    }
}
