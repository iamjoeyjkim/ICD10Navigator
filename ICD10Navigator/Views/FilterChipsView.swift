import SwiftUI

struct FilterChipsView: View {
    @Binding var selectedSystem: String
    @Binding var selectedLaterality: String
    @Binding var selectedEncounter: String
    
    let systems = [
        ("All", "waveform.path.ecg"),
        ("Respiratory", "lungs.fill"), // SF Symbol approximation
        ("Injury", "bandage.fill"),
        ("Neurological", "brain.head.profile"),
        ("Cardiovascular", "heart.fill"),
        ("Endocrine", "bolt.fill")
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // System Filter
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(systems, id: \.0) { system in
                        FilterChip(
                            label: system.0,
                            icon: system.1,
                            isSelected: selectedSystem == system.0,
                            action: { selectedSystem = system.0 }
                        )
                    }
                }
                .padding(.horizontal)
            }
            
            // Context Toggles
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    // Laterality Group
                    HStack(spacing: 0) {
                        ForEach(["All", "Left", "Right"], id: \.self) { lat in
                            ContextButton(
                                label: lat == "All" ? "Side: Any" : lat,
                                isSelected: selectedLaterality == lat,
                                action: { selectedLaterality = lat }
                            )
                        }
                    }
                    .background(Color.white)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.slate200, lineWidth: 1)
                    )
                    
                    // Encounter Group
                    HStack(spacing: 0) {
                        ForEach(["All", "Initial", "Subsequent"], id: \.self) { enc in
                            ContextButton(
                                label: enc == "All" ? "Visit: Any" : (enc == "Initial" ? "New" : "Follow-up"),
                                isSelected: selectedEncounter == enc,
                                action: { selectedEncounter = enc }
                            )
                        }
                    }
                    .background(Color.white)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.slate200, lineWidth: 1)
                    )
                }
                .padding(.horizontal)
            }
        }
    }
}

struct FilterChip: View {
    let label: String
    let icon: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.system(size: 12))
                Text(label)
                    .font(.system(size: 14, weight: .medium))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .foregroundColor(isSelected ? .white : .slate600)
            .background(isSelected ? Color.blue600 : Color.white)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(isSelected ? Color.blue600 : Color.slate200, lineWidth: 1)
            )
            .shadow(color: isSelected ? Color.blue200 : .clear, radius: 4, x: 0, y: 2)
        }
    }
}

struct ContextButton: View {
    let label: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(label)
                .font(.system(size: 12, weight: .medium))
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .foregroundColor(isSelected ? .blue700 : .slate500)
                .background(isSelected ? Color.blue100 : Color.clear)
        }
    }
}
