//
//  Double+Angle.swift
//
//
//  Created by fu.lam.diep on 30.08.22.
//

import Foundation

extension Double {
    // MARK: Constant Angles

    /// Represents the angle pointing north on a circle in UIKit
    public static let north: Double = .pi * 1.5

    /// Represents the angle pointing east on a circle in UIKit
    public static let east: Double = 0.0

    /// Represents the angle pointing south on a circle in UIKit
    public static let south: Double = .pi * 0.5

    /// Represents the angle pointing west on a circle in UIKit
    public static let west: Double = .pi

    // MARK: Conversion

    /// Calculates the degree of an angle corresponding to the given radian
    public static func degree(_ rad: Double) -> Double {
        rad / .pi * 180
    }

    /// Calculates the radian of an angle corresponding to the given degree
    public static func radian(_ deg: Double) -> Double {
        deg / 180 * .pi
    }

    public var deg: Double {
        Self.degree(self)
    }

    public var rad: Double {
        Self.radian(self)
    }
}
