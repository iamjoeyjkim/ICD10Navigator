import Foundation

struct ICD10Code: Codable, Identifiable, Hashable {
    var id: String { code }
    let code: String
    let description: String
    let category: String
    
    // Helpers for UI filters (inferred since API doesn't provide them directly)
    var chapter: String {
        // Simplified mapping based on first letter
        switch code.prefix(1) {
        case "A", "B": return "Infectious"
        case "C", "D": return "Neoplasms"
        case "E": return "Endocrine"
        case "F": return "Mental"
        case "G": return "Neurological"
        case "H": return "Eye/Ear"
        case "I": return "Cardiovascular"
        case "J": return "Respiratory"
        case "K": return "Digestive"
        case "L": return "Skin"
        case "M": return "Musculoskeletal"
        case "N": return "Genitourinary"
        case "O": return "Pregnancy"
        case "P": return "Perinatal"
        case "Q": return "Congenital"
        case "R": return "Symptoms"
        case "S", "T": return "Injury"
        case "V", "W", "X", "Y": return "External"
        case "Z": return "Factors"
        default: return "Other"
        }
    }
    
    var laterality: String? {
        if description.localizedCaseInsensitiveContains("right") { return "Right" }
        if description.localizedCaseInsensitiveContains("left") { return "Left" }
        if description.localizedCaseInsensitiveContains("bilateral") { return "Bilateral" }
        return nil
    }
    
    var encounter: String? {
        if code.hasSuffix("A") { return "Initial" }
        if code.hasSuffix("D") { return "Subsequent" }
        if code.hasSuffix("S") { return "Sequela" }
        return nil
    }
}
