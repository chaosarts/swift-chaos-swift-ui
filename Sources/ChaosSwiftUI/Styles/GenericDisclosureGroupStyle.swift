//
//  Copyright © 2024 Fu Lam Diep <fulam.diep@gmail.com>
//

import SwiftUI

public struct GenericDisclosureGroupStyle<Content: View>: DisclosureGroupStyle {
    private let content: (Configuration) -> Content

    public func makeBody(configuration: Configuration) -> some View {
        content(configuration)
    }
}
