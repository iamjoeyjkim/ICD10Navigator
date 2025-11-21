import Foundation
import Combine

class SearchViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var searchResults: [ICD10Code] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    // Filter States
    @Published var selectedSystem: String = "All"
    @Published var selectedLaterality: String = "All"
    @Published var selectedEncounter: String = "All"
    
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
    
    var filteredResults: [ICD10Code] {
        searchResults.filter { code in
            let matchesSystem = selectedSystem == "All" || code.chapter == selectedSystem
            let matchesLaterality = selectedLaterality == "All" || code.laterality == selectedLaterality
            let matchesEncounter = selectedEncounter == "All" || code.encounter == selectedEncounter
            return matchesSystem && matchesLaterality && matchesEncounter
        }
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
