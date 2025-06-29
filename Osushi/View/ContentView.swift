import SwiftUI

struct ContentView: View {
    @State private var selection: Tab = .top
    
    private enum Tab {
        case top
        case favorite
        case setting
    }
    
    var body: some View {
        TabView(selection: $selection) {
            PostListView()
                .tabItem {
                    Label("ホーム", systemImage: "house")
                }
                .tag(Tab.top)
            
            FavoriteListView()
                .modelContainer(for: Favorite.self)
                .tabItem {
                    Label("お気に入り", systemImage: "star")
                }
                .tag(Tab.favorite)
            
            InfoListView()
                .tabItem {
                    Label("iOS Osushi", image: .tabOsushi)
                }.tag(Tab.setting)
        }
    }
}

#Preview {
    ContentView()
}
