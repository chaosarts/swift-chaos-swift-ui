//
//  WebView+MimeType.swift
//  ChaosSwiftUI
//
//  Created by Fu Lam Diep on 17.08.26.
//

import Foundation

extension WebView {
    public struct MimeType: CustomStringConvertible, Equatable, Hashable {
        // swiftlint:disable:next nesting
        public typealias RawValue = String

        public static let typeSeparator: Character = "/"

        public static let parameterSeparator: Character = ";"

        public let type: String

        public let subtype: String

        public let parameters: [String: String]

        public var description: String {
            let strings = ["\(type)\(Self.typeSeparator)\(subtype)"] + parameters.map { "\($0)=\($1)" }
            return strings.joined(separator: "\(Self.parameterSeparator) ")
        }

        public init(_ type: String, subtype: String, parameters: [String: String] = [:]) {
            self.type = type
            self.subtype = subtype
            self.parameters = parameters
        }

        public static func application(_ subtype: String, parameters: [String: String] = [:]) -> Self {
            MimeType("application", subtype: subtype, parameters: parameters)
        }

        public static func text(_ subtype: String, parameters: [String: String] = [:]) -> Self {
            MimeType("text", subtype: subtype, parameters: parameters)
        }
    }
}
