import Foundation

struct FirebasePost: Codable {
    let id: String
    let username: String
    let content: String
    let timestamp: Date
    let imageUrl: String
    let likes: Int
    let isLiked: Bool
}
