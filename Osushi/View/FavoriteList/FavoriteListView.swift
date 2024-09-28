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
            .navigationTitle(Strings.FavoriteList.title)
            .overlay {
                if favoritePosts.isEmpty {
                    ContentUnavailableView {
                        Label(Strings.FavoriteList.emptyListTitle, systemImage: "tray.fill")
                    } description: {
                        Text(Strings.FavoriteList.emptyListMessage)
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
