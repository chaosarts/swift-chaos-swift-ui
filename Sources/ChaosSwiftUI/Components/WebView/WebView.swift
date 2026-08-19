//
//  Copyright © 2024 Fu Lam Diep <fulam.diep@gmail.com>
//

import SwiftUI
import WebKit

@MainActor
public struct WebView {
    public typealias Configuration = WKWebViewConfiguration

    @Binding var navigator: Navigator

    private let configuration: Configuration

    public init(navigator: Binding<Navigator>, configuration: Configuration = .init()) {
        _navigator = navigator
        self.configuration = configuration
    }

    public func makeCoordinator() -> Coordinator {
        Coordinator()
    }
}
