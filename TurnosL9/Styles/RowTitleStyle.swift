//
//  RowTitleStyle.swift
//  TurnosL9
//
//  Created by Jose Antonio Mendoza on 1/11/24.
//

import SwiftUI

struct RowTitleStyle: ViewModifier {
    let bold: Bool

    func body(content: Content) -> some View {
        content
            .font(.title2)
            .fontWeight(bold ? .heavy : .light)
            .fontDesign(.monospaced)
    }
}

extension View {
    public func rowTitleStyle(bold: Bool = false) -> some View {
        modifier(RowTitleStyle(bold: bold))
    }
}
