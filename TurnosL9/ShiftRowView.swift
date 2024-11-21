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
                .font(.largeTitle)
                .bold()
                .rowTitleStyle()
                .frame(width: 72, height: 48)
            
            Spacer()
            
            HStack(spacing: 4) {
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
            }
        }
        .rowStyle()
        .lineLimit(1)
        .minimumScaleFactor(0.8)
    }
}

#if DEBUG
#Preview {
    ShiftRowView(shift: .preview)
        .padding(.horizontal)
}
#endif
