import SwiftUI
import MarkdownUI

struct PostListView: View {
    @StateObject private var viewModel = PostListViewModel()

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.sortedPosts, id: \.self) { post in
                    NavigationLink {
                        DetailPostView(markdownContent: post)
                            .modelContainer(for: Favorite.self)
                    } label: {
                        PostRowView(markdownContent: post)
                    }
                }
            }
            .navigationTitle("投稿一覧")
            .refreshable {
                viewModel.fetchPosts()
            }
        }
        .onAppear {
            viewModel.fetchPosts()
        }
    }
}

#Preview {
    PostListView()
}
