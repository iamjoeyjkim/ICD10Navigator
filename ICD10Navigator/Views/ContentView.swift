import SwiftUI

struct ContentView: View {
    @StateObject private var favoritesViewModel = FavoritesViewModel()
    @State private var selectedTab = 0
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // Main Content
            Group {
                switch selectedTab {
                case 0:
                    SearchView()
                        .environmentObject(favoritesViewModel)
                case 1:
                    FavoritesView()
                        .environmentObject(favoritesViewModel)
                default:
                    Text("Coming Soon")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.slate50)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            // Custom Tab Bar
            HStack {
                TabButton(icon: "house.fill", label: "Home", isSelected: selectedTab == 0) {
                    selectedTab = 0
                }
                Spacer()
                TabButton(icon: "heart.fill", label: "Favorites", isSelected: selectedTab == 1) {
                    selectedTab = 1
                }
                Spacer()
                TabButton(icon: "clock.fill", label: "History", isSelected: selectedTab == 2) {
                    selectedTab = 2
                }
                Spacer()
                TabButton(icon: "gearshape.fill", label: "Settings", isSelected: selectedTab == 3) {
                    selectedTab = 3
                }
            }
            .padding(.horizontal, 32)
            .padding(.top, 16)
            .padding(.bottom, 8) // Safe area handled by background
            .background(
                Color.white.opacity(0.9)
                    .background(.ultraThinMaterial)
                    .ignoresSafeArea(edges: .bottom)
            )
            .overlay(
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.slate200),
                alignment: .top
            )
        }
    }
}

struct TabButton: View {
    let icon: String
    let label: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.system(size: 24))
                Text(label)
                    .font(.system(size: 10, weight: .medium))
            }
            .foregroundColor(isSelected ? .blue600 : .slate400)
            .scaleEffect(isSelected ? 1.05 : 1.0)
            .animation(.spring(response: 0.3), value: isSelected)
        }
    }
}
