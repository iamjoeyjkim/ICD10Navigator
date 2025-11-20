import SwiftUI

struct CodeDetailView: View {
    let code: ICD10Code
    @EnvironmentObject var favoritesViewModel: FavoritesViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Text(code.code)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                    
                    Spacer()
                    
                    Button(action: {
                        favoritesViewModel.toggleFavorite(code: code)
                    }) {
                        Image(systemName: favoritesViewModel.isFavorite(code: code) ? "star.fill" : "star")
                            .foregroundColor(.yellow)
                            .font(.title)
                    }
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Description")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    Text(code.description)
                        .font(.body)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Category")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    Text(code.category)
                        .font(.body)
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                }
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Code Details")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}
