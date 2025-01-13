import Foundation
import FirebaseFirestore
import FirebaseStorage
import UIKit

class FirebaseManager {
    private let firestore = Firestore.firestore()
    private let storage = Storage.storage()

    // Upload image and get URL
    func uploadImage(_ image: UIImage, completion: @escaping (Result<String, Error>) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            completion(.failure(NSError(domain: "ImageConversionError", code: -1, userInfo: nil)))
            return
        }

        let imageRef = storage.reference().child("images/\(UUID().uuidString).jpg")
        imageRef.putData(imageData, metadata: nil) { _, error in
            if let error = error {
                completion(.failure(error))
            } else {
                imageRef.downloadURL { url, error in
                    if let error = error {
                        completion(.failure(error))
                    } else if let url = url {
                        completion(.success(url.absoluteString))
                    }
                }
            }
        }
    }

    // Save post to Firestore
    func savePost(_ post: FirebasePost, completion: @escaping (Result<Void, Error>) -> Void) {
        let postDict = try? post.dictionary()
        firestore.collection("posts").document(post.id).setData(postDict ?? [:]) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
}

// Helper extension to convert Codable to Dictionary
extension Encodable {
    func dictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        return try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] ?? [:]
    }
}
