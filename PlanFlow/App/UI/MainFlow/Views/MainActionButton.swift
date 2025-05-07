import SwiftUI

@available(iOS 16.0, *)
struct MainActionButton: View {
    let label: String
    let padding: CGFloat
    let font: FontBuilder
    var action: () -> Void
    var backgroundColor: Color = Color.accent
    
    var body: some View {
        Button(action: action) {
            Text(label)
                .cwf(Color.black, font)
                .padding(padding)
                .frame(maxWidth: .infinity)
                .background(backgroundColor)
                .cornerRadius(14)
                .shadow(color: Color.black, radius: 0, x: 2, y: 5)
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color.black, lineWidth: 1)
                )
        }
    }
}
