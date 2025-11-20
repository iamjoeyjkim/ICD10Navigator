import SwiftUI

struct ContentView: View {
    @StateObject private var favoritesViewModel = FavoritesViewModel()
    
    var body: some View {
        TabView {
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
                .environmentObject(favoritesViewModel)
            
            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "star.fill")
                }
                .environmentObject(favoritesViewModel)
        }
    }
}
