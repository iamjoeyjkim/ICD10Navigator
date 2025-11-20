import Foundation

class FavoritesViewModel: ObservableObject {
    @Published var favorites: Set<ICD10Code> = []
    
    private let favoritesKey = "favorites_v2"
    
    init() {
        loadFavorites()
    }
    
    func toggleFavorite(code: ICD10Code) {
        if favorites.contains(code) {
            favorites.remove(code)
        } else {
            favorites.insert(code)
        }
        saveFavorites()
    }
    
    func isFavorite(code: ICD10Code) -> Bool {
        favorites.contains(code)
    }
    
    func getFavoriteCodes() -> [ICD10Code] {
        return Array(favorites).sorted { $0.code < $1.code }
    }
    
    private func saveFavorites() {
        if let encoded = try? JSONEncoder().encode(favorites) {
            UserDefaults.standard.set(encoded, forKey: favoritesKey)
        }
    }
    
    private func loadFavorites() {
        if let data = UserDefaults.standard.data(forKey: favoritesKey),
           let decoded = try? JSONDecoder().decode(Set<ICD10Code>.self, from: data) {
            favorites = decoded
        }
    }
}
