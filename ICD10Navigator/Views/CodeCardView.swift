import SwiftUI

struct CodeCardView: View {
    let code: ICD10Code
    @EnvironmentObject var favoritesViewModel: FavoritesViewModel
    @State private var isCopied = false
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            // Background with hover effect simulation (static for iOS)
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .shadow(color: Color.slate200, radius: 4, x: 0, y: 1)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.slate100, lineWidth: 1)
                )
            
            // Blue accent line on left (simulating group-hover)
            // On iOS we can just show it always or make it subtle
            HStack(spacing: 0) {
                Rectangle()
                    .fill(Color.blue500)
                    .frame(width: 4)
                Spacer()
            }
            .mask(RoundedRectangle(cornerRadius: 16))
            
            VStack(alignment: .leading, spacing: 12) {
                // Header: Code + Laterality + Heart
                HStack(alignment: .top) {
                    HStack(spacing: 8) {
                        Text(code.code)
                            .font(.system(.title3, design: .monospaced))
                            .fontWeight(.bold)
                            .foregroundColor(.blue700)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 4)
                            .background(Color.blue50)
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.blue100, lineWidth: 1)
                            )
                        
                        if let laterality = code.laterality {
                            Text(laterality)
                                .font(.system(size: 10, weight: .bold))
                                .textCase(.uppercase)
                                .foregroundColor(laterality == "Right" ? .purple600 : .indigo600)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 2)
                                .background(laterality == "Right" ? Color.purple50 : Color.indigo50)
                                .cornerRadius(12)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(laterality == "Right" ? Color.purple100 : Color.indigo100, lineWidth: 1)
                                )
                        }
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        favoritesViewModel.toggleFavorite(code: code)
                    }) {
                        Image(systemName: favoritesViewModel.isFavorite(code: code) ? "heart.fill" : "heart")
                            .foregroundColor(favoritesViewModel.isFavorite(code: code) ? .rose500 : .slate300)
                            .font(.system(size: 18))
                    }
                }
                
                // Description
                Text(code.description)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.slate800)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
                
                Spacer(minLength: 0)
                
                // Tags: Encounter + Chapter
                HStack {
                    if let encounter = code.encounter {
                        Text(encounter)
                            .font(.caption)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(encounterColor(for: encounter).opacity(0.1))
                            .foregroundColor(encounterColor(for: encounter))
                            .cornerRadius(6)
                            .overlay(
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(encounterColor(for: encounter).opacity(0.2), lineWidth: 1)
                            )
                    }
                    
                    Text(code.chapter)
                        .font(.caption)
                        .foregroundColor(.slate500)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.slate50)
                        .cornerRadius(6)
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(Color.slate100, lineWidth: 1)
                        )
                    
                    Spacer()
                    
                    // Copy Button
                    Button(action: {
                        UIPasteboard.general.string = code.code
                        withAnimation {
                            isCopied = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                isCopied = false
                            }
                        }
                    }) {
                        HStack(spacing: 4) {
                            Image(systemName: isCopied ? "checkmark" : "doc.on.doc")
                                .font(.system(size: 10))
                            Text(isCopied ? "Copied" : "Copy")
                                .font(.system(size: 10, weight: .medium))
                        }
                        .foregroundColor(.white)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(Color.slate900)
                        .cornerRadius(12)
                    }
                }
            }
            .padding(16)
        }
    }
    
    func encounterColor(for encounter: String) -> Color {
        switch encounter {
        case "Initial": return .emerald700
        case "Subsequent": return .blue700
        case "Sequela": return .amber700
        default: return .slate600
        }
    }
}
