//
//  RowTitleStyle.swift
//  TurnosL9
//
//  Created by Jose Antonio Mendoza on 1/11/24.
//

import SwiftUI

struct RowTitleStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title2)
            .fontDesign(.monospaced)
            .foregroundStyle(.background)
            .rowStyle(in: Color.primary)
    }
}

extension View {
    public func rowTitleStyle() -> some View {
        modifier(RowTitleStyle())
    }
}
