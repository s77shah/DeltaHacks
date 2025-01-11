import UIKit

class PhotoCaptureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var currentUser: User!  // This would be set when the user logs in
    var friends: [User] = [] // List of friends
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
    }
    
    // Function to present the photo capture UI
    @IBAction func takePhoto(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            present(imagePicker, animated: true, completion: nil)
        } else {
            print("Camera not available")
        }
    }
    
    // Delegate method: Handle photo capture
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            photoImageView.image = image
            currentUser.addPhoto(image) // Add the photo to the current user's profile
            
            // After capturing the photo, update friends' feeds
            updateFriendsFeeds(with: image)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    // Delegate method: Handle canceling the photo capture
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    // Function to update friends' feeds
    func updateFriendsFeeds(with photo: UIImage) {
        for friend in friends {
            friend.addPhoto(photo)  // Add the photo to each friend's photos list
        }
    }
    
    // Function to add a new friend to the current user's friend list
    @IBAction func addFriend(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Add Friend", message: "Enter username", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Friend's username"
        }
        let addAction = UIAlertAction(title: "Add", style: .default) { _ in
            if let username = alertController.textFields?.first?.text {
                let newFriend = User(username: username)
                self.friends.append(newFriend)  // Add friend to the list
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
}
