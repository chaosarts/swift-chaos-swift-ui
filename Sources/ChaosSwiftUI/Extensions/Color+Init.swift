//
//  Color+Init.swift
//  Chrono24
//
//  Created by Fu Lam Diep on 30.04.22.
//

#if canImport(UIKit)
    import UIKit
#endif
import SwiftUI

extension Color {
    // swiftlint:disable:next large_tuple
    public typealias RGBTuple = (red: CGFloat, green: CGFloat, blue: CGFloat)

    public init(_ colorSpace: RGBColorSpace = .sRGB, hex: Int, opacity: Double = 1) {
        let components = Self.colorComponents(for: hex)
        self.init(colorSpace, red: components.red, green: components.green, blue: components.blue, opacity: opacity)
    }

    #if canImport(UIKit)
        public init(light: UIColor, dark: UIColor, unspecified: UIColor? = nil) {
            self.init(uiColor: UIColor(dynamicProvider: { trait in
                switch trait.userInterfaceStyle {
                case .light:
                    light
                case .dark:
                    dark
                case .unspecified:
                    unspecified ?? light
                @unknown default:
                    light
                }
            }))
        }

        public init(light: Int, dark: Int, unspecified: Int? = nil) {
            var unspecifiedColor: UIColor?
            if let unspecified {
                unspecifiedColor = Self.uiColor(forHex: unspecified)
            }
            self.init(light: Self.uiColor(forHex: light),
                      dark: Self.uiColor(forHex: dark),
                      unspecified: unspecifiedColor)
        }

        public static func uiColor(forComponents components: RGBTuple, alpha: CGFloat = 1) -> UIColor {
            UIColor(red: components.red,
                    green: components.green,
                    blue: components.blue,
                    alpha: alpha)
        }

        public static func uiColor(forHex hex: Int, alpha: CGFloat = 1) -> UIColor {
            uiColor(forComponents: colorComponents(for: hex), alpha: alpha)
        }
    #endif

    public static func colorComponents(for hex: Int) -> RGBTuple {
        if hex > 0xFFF {
            let red = CGFloat((hex & 0xFF0000) >> 16)
            let green = CGFloat((hex & 0x00FF00) >> 8)
            let blue = CGFloat(hex & 0x0000FF)
            return (red: red / 255, green: green / 255, blue: blue / 255)
        } else {
            let red = CGFloat(((hex & 0xF00) >> 4) + ((hex & 0xF00) >> 8))
            let green = CGFloat((hex & 0x0F0) + ((hex & 0x0F0) >> 4))
            let blue = CGFloat((hex & 0x00F) + ((hex & 0x0F) << 4))
            return (red: red / 255, green: green / 255, blue: blue / 255)
        }
    }
}

extension Color: @retroactive ExpressibleByIntegerLiteral {
    public init(integerLiteral value: IntegerLiteralType) {
        self.init(hex: value)
    }
}
