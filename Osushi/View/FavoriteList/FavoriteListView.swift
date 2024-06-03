import SwiftUI
import SwiftData

struct FavoriteListView: View {
    @Environment(\.modelContext) private var context
    @Query private var favoritePosts: [Favorite]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(favoritePosts, id: \.self) { favoritePost in
                    NavigationLink {
                        DetailPostView(markdownContent: favoritePost.post)
                            .modelContainer(for: Favorite.self)
                    } label: {
                        PostRowView(markdownContent: favoritePost.post)
                    }
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        delete(post: favoritePosts[index])
                    }
                }
            }
            .navigationTitle("お気に入り一覧")
            .overlay {
                if favoritePosts.isEmpty {
                    ContentUnavailableView {
                        Label("お気に入りがありません", systemImage: "tray.fill")
                    } description: {
                        Text("お気に入りボタンをタップして追加してみよう🍣")
                    }
                }
            }
        }
    }
    
    private func delete(post: Favorite) {
        context.delete(post)
    }
}

#Preview {
    FavoriteListView()
        .modelContainer(for: Favorite.self)
}
