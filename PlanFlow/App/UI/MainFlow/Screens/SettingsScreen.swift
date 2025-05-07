import SwiftUI

@available(iOS 16.0, *)
struct SettingsScreen: View {
    @Binding var navPath: [Screens]
    
    var body: some View {
        VStack(spacing: 0) {
            Title(title: "Settings", withRefreshButton: false, refreshButtonAction: {}, navPath: $navPath)
            SettingsButtons
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(background)
    }
        
    private var SettingsButtons: some View {
        VStack(spacing: 20) {
            MainActionButton(label: "Contact us", padding: 17, font: .tt26, action: cuachuabuafuapapapapagrgr )
            MainActionButton(label: "Privacy policy", padding: 17, font: .tt26, action: pppppapupupupupugrrraaa)
            MainActionButton(label: "Rate us", padding: 17, font: .tt26, action: ruafuasuabuaguamuayaruahua)
        }
        .padding(EdgeInsets(top: 110, leading: 35, bottom: 0, trailing: 35))
    }
    
    private func cuachuabuafuapapapapagrgr() {
        if let url = URL(string: "mailto:(mail here)"),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    private func pppppapupupupupugrrraaa() {
        guard let url = URL(string: "(url here)") else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    private func ruafuasuabuaguamuayaruahua() {
        if let url = URL(string: "itms-apps://itunes.apple.com/app/id(id here)?action=write-review"),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    private var background: some View {
        VStack(spacing: 0) {
            Spacer()
            Image("mainImage")
                .frame(maxWidth: .infinity, maxHeight: 297)
        }
        .background(Color.background)
    }
    
    private func navigateToScreen(_ screen: Screens) {
        navPath.append(screen)
    }
}

#Preview {
    @State var navPath: [Screens] = []
    SettingsScreen(navPath: $navPath)
}
