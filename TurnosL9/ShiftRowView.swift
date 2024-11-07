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
                LabeledContent("Inicio") {
                    Text(shift.shiftStart.positionalTimeString)
                        .monospacedStyle()
                }
                LabeledContent("Fin") {
                    Text(shift.shiftEnd.positionalTimeString)
                        .monospacedStyle()
                }
            }
            .font(.callout)
            .frame(width: 100, alignment: .leading)
            
            Spacer()
            
            VStack(alignment: .leading) {
                LabeledContent("Jornada") {
                    Text(shift.shiftDuration.positionalTimeString)
                        .monospacedStyle()
                }
                if let saturation = shift.saturation {
                    LabeledContent("Saturación") {
                        Text("\(saturation.formatted()) %")
                            .fontWeight(.semibold)
                    }
                } else {
                    Text("")
                }
            }
            .font(.callout)
            .frame(width: 150, alignment: .leading)
        }
        .rowStyle()
        .lineLimit(1)
    }
}

#if DEBUG
#Preview {
    ShiftRowView(shift: .preview)
        .padding(.horizontal)
}
#endif
