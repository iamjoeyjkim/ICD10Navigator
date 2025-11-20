import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()
    @EnvironmentObject var favoritesViewModel: FavoritesViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                List(viewModel.searchResults) { code in
                    NavigationLink(destination: CodeDetailView(code: code)) {
                        VStack(alignment: .leading) {
                            HStack {
                                Text(code.code)
                                    .font(.headline)
                                    .foregroundColor(.blue)
                                Spacer()
                                if favoritesViewModel.isFavorite(code: code) {
                                    Image(systemName: "star.fill")
                                        .foregroundColor(.yellow)
                                        .font(.caption)
                                }
                            }
                            Text(code.description)
                                .font(.subheadline)
                                .lineLimit(2)
                        }
                        .padding(.vertical, 4)
                    }
                }
                
                if viewModel.isLoading {
                    ProgressView()
                        .scaleEffect(1.5)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.white.opacity(0.5))
                }
                
                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .padding()
                }
            }
            .navigationTitle("ICD10 Search")
            .searchable(text: $viewModel.searchText, prompt: "Search codes (e.g. 'cholera')")
        }
    }
}
