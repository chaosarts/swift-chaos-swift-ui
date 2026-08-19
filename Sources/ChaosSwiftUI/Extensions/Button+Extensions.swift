//
//  Button+Extensions.swift
//  Timer
//
//  Created by Fu Lam Diep on 31.08.24.
//

import SwiftUI

extension Button {
    public init<Title, Icon>(
        action: @escaping () -> Void,
        @ViewBuilder title: @escaping () -> Title,
        @ViewBuilder icon: @escaping () -> Icon,
    ) where Title: View, Icon: View, Label == SwiftUI.Label<Title, Icon> {
        self.init(action: action) {
            Label {
                title()
            } icon: {
                icon()
            }
        }
    }

    public init<Icon>(
        _ title: some StringProtocol,
        @ViewBuilder icon: @escaping () -> Icon,
        action: @escaping () -> Void,
    )
        where Icon: View, Label == SwiftUI.Label<Text, Icon> {
        self.init(action: action) {
            Label {
                Text(title)
            } icon: {
                icon()
            }
        }
    }

    public init(_ title: some StringProtocol, icon: Image, action: @escaping () -> Void)
        where Label == SwiftUI.Label<Text, Image> {
        self.init(action: action) {
            Label {
                Text(title)
            } icon: {
                icon
            }
        }
    }

    public init(_ title: some StringProtocol, name: String, bundle: Bundle = .main, action: @escaping () -> Void)
        where Label == SwiftUI.Label<Text, Image> {
        self.init(action: action) {
            Label {
                Text(title)
            } icon: {
                Image(name, bundle: bundle)
            }
        }
    }

    public init(_ title: some StringProtocol, systemName: String, action: @escaping () -> Void)
        where Label == SwiftUI.Label<Text, Image> {
        self.init(action: action) {
            Label {
                Text(title)
            } icon: {
                Image(systemName: systemName)
            }
        }
    }
}
