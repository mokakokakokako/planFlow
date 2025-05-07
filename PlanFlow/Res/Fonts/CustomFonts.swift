import Foundation
import SwiftUI

enum CustomFonts: String {
    case mulish = "Mulish"
}

struct FontBuilder {
    
    let font: Font
    let tracking: Double
    let lineSpacing: Double
    let verticalPadding: Double
    
    init(
        customFont: CustomFonts,
        fontSize: Double,
        weight: Font.Weight = .regular,
        letterSpacing: Double = 0,
        lineHeight: Double
    ) {
        self.font = Font.custom(customFont, size: fontSize).weight(weight)
        self.tracking = fontSize * letterSpacing
        
        let uiFont = UIFont(name: customFont.rawValue, size: fontSize) ?? .systemFont(ofSize: fontSize)
        self.lineSpacing = lineHeight - uiFont.lineHeight
        self.verticalPadding = self.lineSpacing / 2
    }
    
}

extension FontBuilder {
   
    static let tt28 = FontBuilder(
        customFont: .mulish,
        fontSize: 28,
        weight: .regular,
        lineHeight: 28
    )
    
    static let tt26 = FontBuilder(
        customFont: .mulish,
        fontSize: 26,
        weight: .regular,
        lineHeight: 26
    )
    
    static let tt25 = FontBuilder(
        customFont: .mulish,
        fontSize: 25,
        weight: .regular,
        lineHeight: 25
    )
    
    static let tt22 = FontBuilder(
        customFont: .mulish,
        fontSize: 22,
        weight: .regular,
        lineHeight: 22
    )
    
    static let tt19 = FontBuilder(
        customFont: .mulish,
        fontSize: 19,
        weight: .regular,
        lineHeight: 19
    )
    
    static let tt18 = FontBuilder(
        customFont: .mulish,
        fontSize: 18,
        weight: .regular,
        lineHeight: 18
    )
    
    static let tt16 = FontBuilder(
        customFont: .mulish,
        fontSize: 16,
        weight: .regular,
        lineHeight: 16
    )
    
    static let tt15 = FontBuilder(
        customFont: .mulish,
        fontSize: 15,
        weight: .regular,
        lineHeight: 15
    )
    
    static let tt12 = FontBuilder(
        customFont: .mulish,
        fontSize: 12,
        weight: .regular,
        lineHeight: 12
    )
    
    static let tt8 = FontBuilder(
        customFont: .mulish,
        fontSize: 8,
        weight: .regular,
        lineHeight: 8
    )
}

extension Font {
    static func custom(_ fontName: CustomFonts, size: Double) -> Font {
        Font.custom(fontName.rawValue, size: size)
    }
}


@available(iOS 16.0, *)
struct CustomFontsModifire: ViewModifier {

    private let fontBuilder: FontBuilder

    init(_ fontBuilder: FontBuilder) {
        self.fontBuilder = fontBuilder
    }

    func body(content: Content) -> some View {
        content
            .font(fontBuilder.font)
            .lineSpacing(fontBuilder.lineSpacing)
            .padding([.vertical], fontBuilder.verticalPadding)
            .tracking(fontBuilder.tracking)
    }

}

@available(iOS 16.0, *)
extension View {
    func customFont(_ fontBuilder: FontBuilder) -> some View {
        modifier(CustomFontsModifire(fontBuilder))
    }
}

struct ColorWithFont: ViewModifier {
    let color: Color
    let font: FontBuilder

    func body(content: Content) -> some View {
        content
            .foregroundStyle(color)
            .customFont(font)
    }
}

@available(iOS 16.0, *)
extension View {
    func cwf(_ color: Color, _ font: FontBuilder) -> some View {
        self.modifier(ColorWithFont(color: color, font: font))
    }
}


