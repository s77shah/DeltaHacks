import SwiftUI

@main
struct MyApp: App {
    @StateObject private var feedViewModel = FeedViewModel()

    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(feedViewModel) // Inject the ViewModel
        }
    }
}
