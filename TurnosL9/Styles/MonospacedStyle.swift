//
//  MonospacedStyle.swift
//  TurnosL9
//
//  Created by Jose Antonio Mendoza on 4/11/24.
//

import SwiftUI

struct MonospacedStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.callout)
            .fontDesign(.monospaced)
            .fontWeight(.semibold)
    }
}

extension View {
    public func monospacedStyle() -> some View {
        modifier(MonospacedStyle())
    }
}
