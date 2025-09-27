//
//  ShiftRowView.swift
//  TurnosL9WatchOS Watch App
//
//  Created by Jose Antonio Mendoza on 27/9/25.
//

import SwiftUI

struct ShiftRowView: View {
    let shift: Shift

    var body: some View {
        HStack {
            Text(shift.name)
                .font(.title2)
                .bold()
                .frame(width: 48, alignment: .leading)
            VStack(alignment: .leading) {
                LabeledContent("Inicio") {
                    Text(shift.start.formattedTime)
                        .monospaced()
                }
                LabeledContent("Fin") {
                    Text(shift.end.formattedTime)
                        .monospaced()
                }
            }
            .font(.caption2)
        }
        .lineLimit(1)
    }
}

#Preview {
    ShiftRowView(shift: .preview)
}
