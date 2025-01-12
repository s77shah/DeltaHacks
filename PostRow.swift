//import SwiftUI
//
//
//struct PostRow: View {
//    @Binding var post: Post
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 8) {
//            Text(post.username)
//                .font(.headline)
//
//            if let imageData = post.imageData, let image = UIImage(data: imageData) {
//                Image(uiImage: image)
//                    .resizable()
//                    .scaledToFit()
//                    .frame(height: 200)
//                    .cornerRadius(10)
//            }
//
//            Text(post.content)
//                .font(.body)
//
//            HStack {
//                Button(action: {
//                    post.isLiked.toggle()
//                    post.likes += post.isLiked ? 1 : -1
//                }) {
//                    HStack {
//                        Image(systemName: post.isLiked ? "heart.fill" : "heart")
//                            .foregroundColor(post.isLiked ? .red : .gray)
//                        Text("\(post.likes)")
//                    }
//                }
//                .buttonStyle(BorderlessButtonStyle())
//                Spacer()
//                Text(post.timestamp, style: .date)
//                    .font(.caption)
//            }
//        }
//        .padding()
//    }
//}
import SwiftUI

struct PostRow: View {
    @Binding var post: Post

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(post.username)
                .font(.headline)

            if let imageData = post.imageData, let image = UIImage(data: imageData) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .cornerRadius(10)
            }

            Text(post.content)
                .font(.body)

            HStack {
                Button(action: {
                    post.isLiked.toggle()
                    post.likes += post.isLiked ? 1 : -1
                }) {
                    HStack {
                        Image(systemName: post.isLiked ? "heart.fill" : "heart")
                            .foregroundColor(post.isLiked ? .red : .gray)
                        Text("\(post.likes)")
                    }
                }
                .buttonStyle(BorderlessButtonStyle())
                Spacer()
                Text(post.timestamp, style: .date)
                    .font(.caption)
            }
        }
        .padding()
        .cornerRadius(15)
    }
}
