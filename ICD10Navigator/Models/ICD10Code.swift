import Foundation

struct ICD10Code: Codable, Identifiable, Hashable {
    var id: String { code }
    let code: String
    let description: String
    let category: String
}
