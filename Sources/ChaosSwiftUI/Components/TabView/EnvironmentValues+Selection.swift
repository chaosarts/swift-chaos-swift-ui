//
//  Copyright © 2024 Fu Lam Diep <fulam.diep@gmail.com>
//

import SwiftUI

class TabBarSelection<Value>: ObservableObject {
    let value: Binding<Value>

    init(value: Binding<Value>) {
        self.value = value
    }
}

extension View {
    func tabBarSelection(_ selection: Binding<some Hashable>) -> some View {
        environmentObject(TabBarSelection(value: selection))
    }
}
