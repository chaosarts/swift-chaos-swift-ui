//
//  EdgeInsets+Init.swift
//  Chrono24
//
//  Created by Fu Lam Diep on 30.04.22.
//

import Foundation
import SwiftUI

extension EdgeInsets {
    public static let zero: EdgeInsets = .init(0)

    public init(horizontal: CGFloat = 0, vertical: CGFloat = 0) {
        self.init(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
    }

    public init(_ value: CGFloat) {
        self.init(top: value, leading: value, bottom: value, trailing: value)
    }
}
