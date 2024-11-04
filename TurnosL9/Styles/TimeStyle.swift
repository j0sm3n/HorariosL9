//
//  TimeStyle.swift
//  TurnosL9
//
//  Created by Jose Antonio Mendoza on 4/11/24.
//

import SwiftUI

struct TimeStyle: ViewModifier {
    let font: Font

    func body(content: Content) -> some View {
        content
            .font(font)
            .fontDesign(.monospaced)
            .fontWeight(.semibold)
    }
}

extension View {
    public func timeStyle(with font: Font) -> some View {
        modifier(TimeStyle(font: font))
    }
}
