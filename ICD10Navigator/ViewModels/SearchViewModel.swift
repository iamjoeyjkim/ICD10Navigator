import Foundation
import Combine

class SearchViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var searchResults: [ICD10Code] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private var currentTask: Task<Void, Never>?
    
    init() {
        $searchText
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] query in
                self?.performSearch(query: query)
            }
            .store(in: &cancellables)
    }
    
    private func performSearch(query: String) {
        currentTask?.cancel()
        
        guard !query.isEmpty else {
            searchResults = []
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        currentTask = Task { @MainActor in
            do {
                searchResults = try await DataManager.shared.search(query: query)
                isLoading = false
            } catch {
                if !Task.isCancelled {
                    errorMessage = "Failed to search: \(error.localizedDescription)"
                    isLoading = false
                }
            }
        }
    }
}
