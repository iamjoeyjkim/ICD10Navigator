import Foundation
import Combine

class DataManager: ObservableObject {
    static let shared = DataManager()
    
    private let baseURL = "https://clinicaltables.nlm.nih.gov/api/icd10cm/v3/search"
    
    private init() {}
    
    func search(query: String) async throws -> [ICD10Code] {
        guard !query.isEmpty else { return [] }
        
        var components = URLComponents(string: baseURL)!
        components.queryItems = [
            URLQueryItem(name: "terms", value: query),
            URLQueryItem(name: "sf", value: "code,name"),
            URLQueryItem(name: "df", value: "code,name")
        ]
        
        guard let url = components.url else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        // The API returns: [count, [codes], null, [[code, name], ...]]
        // We need to parse this heterogeneous array.
        // Since Swift's JSONDecoder expects a specific type, we can decode as [Any] using JSONSerialization
        
        guard let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [Any],
              jsonArray.count >= 4,
              let results = jsonArray[3] as? [[String]] else {
            return []
        }
        
        return results.compactMap { item in
            guard item.count >= 2 else { return nil }
            let code = item[0]
            let description = item[1]
            // The API doesn't always return a category in this view, so we'll use a placeholder or try to infer it if needed.
            // For now, we'll leave category empty or generic.
            return ICD10Code(code: code, description: description, category: "ICD-10-CM")
        }
    }
}
