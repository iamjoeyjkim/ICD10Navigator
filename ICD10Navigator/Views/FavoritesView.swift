import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var favoritesViewModel: FavoritesViewModel
    
    var body: some View {
        NavigationStack {
            List {
                let favorites = favoritesViewModel.getFavoriteCodes()
                if favorites.isEmpty {
                    Text("No favorites yet")
                        .foregroundColor(.secondary)
                } else {
                    ForEach(favorites) { code in
                        NavigationLink(destination: CodeDetailView(code: code)) {
                            VStack(alignment: .leading) {
                                Text(code.code)
                                    .font(.headline)
                                    .foregroundColor(.blue)
                                Text(code.description)
                                    .font(.subheadline)
                                    .lineLimit(1)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Favorites")
        }
    }
}
