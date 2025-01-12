//
//  Post.swift
//  dh2
//
//  Created by Sania Shah on 2025-01-11.
//

import Foundation
import UIKit

struct Post: Identifiable {
    let id: String
    let username: String
    let content: String
    let timestamp: Date
    var likes: Int
    var isLiked: Bool
    var imageData: Data? // Optional Data for image
}
