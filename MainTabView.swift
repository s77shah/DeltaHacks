//
//  MainTabView.swift
//  dh2
//
//  Created by Sania Shah on 2025-01-11.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var feedViewModel: FeedViewModel // Use the shared instance

    var body: some View {
        TabView {
            FeedView()
                .tabItem {
                    Label("Feed", systemImage: "house")
                }

            PostingPage()
                .tabItem {
                    Label("Post", systemImage: "plus.square")
                }

            HistoryView()
                .tabItem {
                    Label("History", systemImage: "clock")
                }
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
    }
}
