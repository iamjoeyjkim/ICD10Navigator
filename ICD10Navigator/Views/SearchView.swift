import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()
    @EnvironmentObject var favoritesViewModel: FavoritesViewModel
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                Color.slate50.ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Header
                    HStack {
                        VStack(alignment: .leading) {
                            Text("CLINICAL ASSISTANT")
                                .font(.system(size: 10, weight: .bold))
                                .tracking(1.5)
                                .foregroundColor(.blue600)
                            Text("CodeFlow")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.slate900)
                        }
                        Spacer()
                        Circle()
                            .fill(Color.slate100)
                            .frame(width: 32, height: 32)
                            .overlay(
                                Text("JD")
                                    .font(.system(size: 12, weight: .bold))
                                    .foregroundColor(.slate500)
                            )
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 16)
                    .background(Color.white.opacity(0.8))
                    
                    // Search Bar
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.slate400)
                        TextField("Search diagnosis (e.g. Strep, Fx wrist)...", text: $viewModel.searchText)
                            .foregroundColor(.slate900)
                        if !viewModel.searchText.isEmpty {
                            Button(action: { viewModel.searchText = "" }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.slate400)
                            }
                        }
                    }
                    .padding(12)
                    .background(Color.white)
                    .cornerRadius(16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.slate200, lineWidth: 1)
                    )
                    .padding(.horizontal)
                    .padding(.bottom, 16)
                    
                    // Filters
                    FilterChipsView(
                        selectedSystem: $viewModel.selectedSystem,
                        selectedLaterality: $viewModel.selectedLaterality,
                        selectedEncounter: $viewModel.selectedEncounter
                    )
                    .padding(.bottom, 16)
                    
                    // Results Count
                    HStack {
                        Text("\(viewModel.filteredResults.count) Results Found")
                            .font(.system(size: 10, weight: .semibold))
                            .foregroundColor(.slate400)
                            .textCase(.uppercase)
                            .tracking(0.5)
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 8)
                    
                    // List
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            if viewModel.isLoading {
                                ProgressView()
                                    .padding(.top, 40)
                            } else if viewModel.filteredResults.isEmpty && !viewModel.searchText.isEmpty {
                                VStack(spacing: 16) {
                                    Image(systemName: "line.3.horizontal.decrease.circle")
                                        .font(.system(size: 40))
                                        .foregroundColor(.slate300)
                                        .padding()
                                        .background(Color.slate200)
                                        .clipShape(Circle())
                                    Text("No codes found")
                                        .font(.headline)
                                        .foregroundColor(.slate600)
                                    Text("Try adjusting your filters or searching for a different keyword.")
                                        .font(.caption)
                                        .foregroundColor(.slate400)
                                        .multilineTextAlignment(.center)
                                }
                                .padding(.top, 40)
                            } else {
                                ForEach(viewModel.filteredResults) { code in
                                    NavigationLink(destination: CodeDetailView(code: code)) {
                                        CodeCardView(code: code)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 20)
                    }
                }
            }
            // Hide default navigation bar since we have a custom header
            .toolbar(.hidden, for: .navigationBar)
        }
    }
}
