//
//  RowStyle.swift
//  TurnosL9
//
//  Created by Jose Antonio Mendoza on 31/10/24.
//

import SwiftUI

struct RowStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(.primary)
            .frame(maxWidth: .infinity)
            .padding(10)
            .background(Color.row.shadow(.inner(color: .white, radius: 5)), in: .rect(cornerRadius: 16))
    }
}

extension View {
    func rowStyle() -> some View {
        modifier(RowStyle())
    }
}

