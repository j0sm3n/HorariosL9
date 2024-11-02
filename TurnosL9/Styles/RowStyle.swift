//
//  RowStyle.swift
//  TurnosL9
//
//  Created by Jose Antonio Mendoza on 31/10/24.
//

import SwiftUI

struct RowStyle: ViewModifier {
    var color: Color = .row

    func body(content: Content) -> some View {
        content
            .foregroundStyle(.primary)
            .frame(maxWidth: .infinity)
            .padding(10)
            .background(color, in: .rect(cornerRadius: 12))
    }
}

extension View {
    func rowStyle(in color: Color = .row) -> some View {
        modifier(RowStyle(color: color))
    }
}

