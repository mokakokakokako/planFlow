import SwiftUI

@available(iOS 16.0, *)
struct HomeScreen: View {
    @Binding var navPath: [Screens]
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            HomeButtons
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(background)
    }
        
    private var HomeButtons: some View {
        VStack(spacing: 20) {
            MainActionButton(label: "Add a Task", padding: 17, font: .tt26, action: { navigateToScreen(.taskAdding) })
            MainActionButton(label: "Plans", padding: 17, font: .tt26, action: { navigateToScreen(.plans) })
            MainActionButton(label: "Methods", padding: 17, font: .tt26, action: { navigateToScreen(.methods) })
            MainActionButton(label: "Settings", padding: 17, font: .tt26, action: { navigateToScreen(.settings) })
        }
        .padding(EdgeInsets(top: 0, leading: 35, bottom: 100, trailing: 35))
    }
    
    private var background: some View {
        VStack(spacing: 0) {
            Image("mainImage")
                .frame(maxWidth: .infinity, maxHeight: 297)
                .padding(.top, 30)
            Spacer()
        }
        .background(Color.background)
    }
    
    private func navigateToScreen(_ screen: Screens) {
        navPath.append(screen)
    }
}

#Preview {
    @State var navPath: [Screens] = []
    HomeScreen(navPath: $navPath)
}
