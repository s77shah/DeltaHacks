struct PostingPage: View {
    @State private var content: String = ""
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImage: UIImage? = nil
    @EnvironmentObject var feedViewModel: FeedViewModel

    private let firebaseManager = FirebaseManager()

    var body: some View {
        NavigationView {
            ZStack {
                Color.lightGreen
                    .ignoresSafeArea()

                VStack(spacing: 20) {
                    if let selectedImage = selectedImage {
                        Image(uiImage: selectedImage)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                            .cornerRadius(10)
                            .padding()
                    } else {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.gray.opacity(0.2))
                            .frame(height: 200)
                            .overlay(Text("No Image Selected").foregroundColor(.black))
                            .padding()
                    }

                    PhotosPicker(
                        selection: $selectedItem,
                        matching: .images,
                        photoLibrary: .shared()
                    ) {
                        Label("Select a Photo", systemImage: "photo")
                            .font(.headline)
                            .padding()
                            .background(Color.backgroundGreen)
                            .foregroundColor(.foregroundWhite)
                            .cornerRadius(8)
                    }
                    .onChange(of: selectedItem) { newItem in
                        Task {
                            if let data = try? await newItem?.loadTransferable(type: Data.self),
                               let uiImage = UIImage(data: data) {
                                DispatchQueue.main.async {
                                    self.selectedImage = uiImage
                                }
                            }
                        }
                    }

                    TextField("Write something...", text: $content)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .background(Color.foregroundWhite)
                        .cornerRadius(10)
                        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)

                    Button(action: {
                        guard let selectedImage = selectedImage else { return }

                        firebaseManager.uploadImage(selectedImage) { result in
                            switch result {
                            case .success(let imageUrl):
                                let newPost = FirebasePost(
                                    id: UUID().uuidString,
                                    username: "Eric Yoon",
                                    content: content,
                                    timestamp: Date(),
                                    imageUrl: imageUrl,
                                    likes: 0,
                                    isLiked: false
                                )
                                firebaseManager.savePost(newPost) { saveResult in
                                    switch saveResult {
                                    case .success():
                                        content = ""
                                        self.selectedImage = nil
                                    case .failure(let error):
                                        print("Error saving post: \(error)")
                                    }
                                }
                            case .failure(let error):
                                print("Error uploading image: \(error)")
                            }
                        }
                    }) {
                        Text("Post")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.backgroundGreen)
                            .foregroundColor(.foregroundWhite)
                            .cornerRadius(8)
                    }
                    .padding()

                    Spacer()
                }
                .navigationTitle("Create Post")
                .padding()
            }
        }
    }
}
