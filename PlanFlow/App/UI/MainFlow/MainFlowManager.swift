import SwiftUI

struct MainFlowManager: View {
    @State var navPath: [Screens] = []
    
    var body: some View {
        NavigationStack(path: $navPath) {
            HomeScreen(navPath: $navPath)
            .navigationDestination(for: Screens.self) { screen in
                switch screen {
                case .home:
                    HomeScreen(navPath: $navPath)
                case .info(let id):
                    InfoScreen(navPath: $navPath, id: id)
                case .taskAdding:
                    TaskAddingScreen(navPath: $navPath)
                case .plans:
                    PlansScreen(navPath: $navPath)
                case .methods:
                    MethodsScreen(navPath: $navPath)
                case .settings:
                    SettingsScreen(navPath: $navPath)
                }
            }
        }
    }
}

enum Screens: Hashable {
    case home
    case info(UUID)
    case taskAdding
    case plans
    case methods
    case settings
}
