import SwiftUI

struct Title: View {
    let title: String
    let withRefreshButton: Bool
    var refreshButtonAction: () -> Void
    @Binding var navPath: [Screens]
        
    var body: some View {
        ZStack {
            HStack(spacing: 0) {
                Button(action: {
                    if !navPath.isEmpty {
                        navPath.removeLast()
                    }
                }) {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .frame(maxWidth: 21, maxHeight: 19)
                }
                Spacer()
                Button(action:
                        refreshButtonAction
                ) {
                    Image("refresh")
                        .resizable()
                        .frame(maxWidth: 26, maxHeight: 28)
                }
                .disabled(!withRefreshButton)
                .opacity(withRefreshButton ? 1 : 0)
            }
            .navigationBarBackButtonHidden(true)
            .padding(.horizontal, 35)
            
            Text(title)
                .customFont(.tt28)
                .frame(maxWidth: 200)
                .minimumScaleFactor(0.5)
                .lineLimit(1)
                
        }
        .foregroundStyle(Color.black)
        .padding(.top, 15)
    }
}


