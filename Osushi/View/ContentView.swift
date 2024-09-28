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
                    Label(Strings.Home.home, systemImage: "house")
                }
                .tag(Tab.top)
            
            FavoriteListView()
                .modelContainer(for: Favorite.self)
                .tabItem {
                    Label(Strings.Home.favorite, image: "star")
                }
                .tag(Tab.favorite)
            
            InfoListView()
                .tabItem {
                    Label(Strings.Home.iosOsushi, image: .tabOsushi)
                }.tag(Tab.setting)
        }
    }
}

#Preview {
    ContentView()
}
