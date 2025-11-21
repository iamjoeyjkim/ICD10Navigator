import SwiftUI

extension Color {
    static let slate50 = Color(hex: "f8fafc")
    static let slate100 = Color(hex: "f1f5f9")
    static let slate200 = Color(hex: "e2e8f0")
    static let slate300 = Color(hex: "cbd5e1")
    static let slate400 = Color(hex: "94a3b8")
    static let slate500 = Color(hex: "64748b")
    static let slate600 = Color(hex: "475569")
    static let slate800 = Color(hex: "1e293b")
    static let slate900 = Color(hex: "0f172a")
    
    static let blue50 = Color(hex: "eff6ff")
    static let blue100 = Color(hex: "dbeafe")
    static let blue200 = Color(hex: "bfdbfe")
    static let blue500 = Color(hex: "3b82f6")
    static let blue600 = Color(hex: "2563eb")
    static let blue700 = Color(hex: "1d4ed8")
    
    static let emerald100 = Color(hex: "d1fae5")
    static let emerald200 = Color(hex: "a7f3d0")
    static let emerald700 = Color(hex: "047857")
    
    static let amber100 = Color(hex: "fef3c7")
    static let amber200 = Color(hex: "fde68a")
    static let amber700 = Color(hex: "b45309")
    
    static let rose500 = Color(hex: "f43f5e")
    
    static let purple50 = Color(hex: "faf5ff")
    static let purple100 = Color(hex: "f3e8ff")
    static let purple600 = Color(hex: "9333ea")
    
    static let indigo50 = Color(hex: "eef2ff")
    static let indigo100 = Color(hex: "e0e7ff")
    static let indigo600 = Color(hex: "4f46e5")
    
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
