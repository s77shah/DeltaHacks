import UIKit

// PhotoCaptureViewController - To capture the photo
class PhotoCaptureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var photoImageView: UIImageView!
    
    var capturedPhoto: UIImage?  // Store the captured photo
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
    }
    
    @IBAction func takePhoto(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            present(imagePicker, animated: true, completion: nil)
        } else {
            print("Camera not available")
        }
    }
    
    // Delegate method to handle photo capture
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            capturedPhoto = image  // Store the captured photo
            photoImageView.image = image  // Show it in the current screen
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    // Navigate to PhotoDisplayViewController to show the captured photo
    @IBAction func showCapturedPhoto(_ sender: UIButton) {
        if let photo = capturedPhoto {
            // Navigate to the new screen to show the captured photo
            performSegue(withIdentifier: "showCapturedPhoto", sender: photo)
        }
    }
    
    // Prepare for the segue to pass the captured photo to the new view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCapturedPhoto" {
            if let destinationVC = segue.destination as? PhotoDisplayViewController {
                if let photo = sender as? UIImage {
                    destinationVC.capturedPhoto = photo
                }
            }
        }
    }
}

// PhotoDisplayViewController - To display the captured photo
class PhotoDisplayViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!  // ImageView to display the photo
    
    var capturedPhoto: UIImage?  // Variable to hold the captured photo
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Check if the captured photo is available, then display it
        if let photo = capturedPhoto {
            imageView.image = photo
        }
    }
}
