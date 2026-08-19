//
//  DynamicColor.swift
//  ChaosSwiftUI
//
//  Created by Fu Lam Diep on 19.08.26.
//

import SwiftUI

public struct DynamicColor: ShapeStyle {
    public typealias Resolved = Color

    public typealias ColorResolver = @Sendable (EnvironmentValues) -> Color

    private let resolve: ColorResolver

    public init(resolve: @escaping ColorResolver) {
        self.resolve = resolve
    }

    public init(resolveForScheme: @escaping @Sendable (ColorScheme) -> Color) {
        self.init { values in
            resolveForScheme(values.colorScheme)
        }
    }

    public init(light: Color, dark: Color) {
        self.init { scheme in
            switch scheme {
            case .dark:
                return dark
            case .light:
                return light
            @unknown default:
                assertionFailure("Missing scheme support")
                return light
            }
        }
    }

    public func resolve(in environment: EnvironmentValues) -> Color {
        resolve(environment)
    }
}
