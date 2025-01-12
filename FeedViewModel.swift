//
//  FeedViewModel.swift
//  dh2
//
//  Created by Sania Shah on 2025-01-11.
//

import Foundation

@MainActor
class FeedViewModel: ObservableObject {
    @Published var posts: [Post] = []

    func fetchPosts() async {
        try? await Task.sleep(nanoseconds: 1_000_000_000) // Simulate delay
        posts = [
            Post(id: UUID().uuidString, username: "User1", content: "First post!", timestamp: Date(), likes: 10, isLiked: false, imageData: nil),
            Post(id: UUID().uuidString, username: "User2", content: "SwiftUI is amazing!", timestamp: Date(), likes: 25, isLiked: false, imageData: nil)
        ]
    }

    func addPost(_ post: Post) {
        posts.insert(post, at: 0) // Add the post to the top of the list
    }
}

