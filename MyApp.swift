//import SwiftUI
//
//@main
//struct MyApp: App {
//    @StateObject private var feedViewModel = FeedViewModel()
//
//    var body: some Scene {
//        WindowGroup {
//            MainTabView()
//                .environmentObject(feedViewModel) // Inject the ViewModel
//        }
//    }
//}
import SwiftUI

@main
struct MyApp: App {
    @StateObject private var feedViewModel = FeedViewModel() // Initialize FeedViewModel

    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(feedViewModel) // Pass FeedViewModel to all child views
        }
    }
}
