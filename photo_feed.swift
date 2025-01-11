import UIKit

class FriendsFeedViewController: UIViewController, UITableViewDataSource {

    var currentUser: User!  // The current logged-in user
    var friends: [User] = []  // List of friends
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }
    
    // TableView: Return number of rows (number of friends)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    // TableView: Return the cell for a friend
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath)
        let friend = friends[indexPath.row]
        let photo = friend.photos.first // Display the first photo for simplicity
        
        if let image = photo {
            cell.imageView?.image = image
        }
        cell.textLabel?.text = friend.username
        return cell
    }
}
