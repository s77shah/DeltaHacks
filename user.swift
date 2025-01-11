import UIKit

// Define the User Model
class User {
    var username: String
    var photos: [UIImage]
    
    init(username: String) {
        self.username = username
        self.photos = []
    }
    
    // Function to add a photo to the user's profile
    func addPhoto(_ photo: UIImage) {
        photos.append(photo)
    }
}
