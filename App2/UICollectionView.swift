import UIKit

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var collectionView: UICollectionView!
    var images: [UIImage] = []
    
    var capturedImage: UIImage? {
        didSet {
            if let image = capturedImage {
                images.append(image)
                collectionView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Photo Feed"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Camera", style: .plain, target: self, action: #selector(openCamera))
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: "PhotoCell")
        view.addSubview(collectionView)
    }
    
    @objc private func openCamera() {
        let cameraVC = CameraViewController()
        navigationController?.pushViewController(cameraVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        cell.imageView.image = images[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100) // Adjust size as needed
    }
}

class PhotoCell: UICollectionViewCell {
    var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView = UIImageView(frame: contentView.bounds)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}