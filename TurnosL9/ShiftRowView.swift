//
//  ShiftRowView.swift
//  TurnosL9
//
//  Created by Jose Antonio Mendoza on 23/10/24.
//

import SwiftUI

struct ShiftRowView: View {
    let shift: Shift

    var body: some View {
        HStack {
            Text(shift.name)
                .frame(height: 48)
                .font(.largeTitle)
                .bold()
                .rowTitleStyle()
            
            Spacer()
            
            VStack(alignment: .leading) {
                LabeledContent("Inicio", value: shift.shiftStart.positionalTimeString)
                LabeledContent("Fin", value: shift.shiftEnd.positionalTimeString)
            }
            .font(.callout)
            .frame(width: 90, alignment: .leading)
            
            Spacer()
            
            VStack(alignment: .leading) {
                LabeledContent("Jornada", value: shift.shiftDuration.positionalTimeString)
                if let saturation = shift.saturation {
                    LabeledContent("Saturación") {
                        Text("\(saturation.formatted()) %")
                    }
                } else {
                    Text("")
                }
            }
            .font(.callout)
            .frame(width: 160, alignment: .leading)
        }
        .rowStyle()
        .lineLimit(1)
    }
}

#Preview {
    ShiftRowView(shift: .preview)
        .padding(.horizontal)
}
