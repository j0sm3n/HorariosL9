//
//  LockScreenTextStyle.swift
//  TurnosL9
//
//  Created by Jose Antonio Mendoza on 6/6/25.
//

import SwiftUI

struct LockScreenTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title)
            .fontWeight(.semibold)
    }
}

extension View {
    public func lockScreenStyle() -> some View {
        modifier(LockScreenTextStyle())
    }
}
