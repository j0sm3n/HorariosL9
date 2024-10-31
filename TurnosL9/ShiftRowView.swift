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
                .font(.title2)
                .fontDesign(.monospaced)
                .padding(.leading)
            
            Spacer()
            
            VStack(alignment: .leading) {
                Text("Inicio: \(shift.shiftStart.positionalTimeString)")
                Text("Fin: \(shift.shiftEnd.positionalTimeString)")
            }
            .font(.callout)
            .frame(width: 90, alignment: .leading)
            
            Spacer()
            
            VStack(alignment: .leading) {
                Text("Jornada: \(shift.shiftDuration.abbreviatedTimeString)")
                if let saturation = shift.saturation {
                    Text("Saturación: \(saturation.formatted()) %")
                } else {
                    Text("")
                }
            }
            .font(.callout)
            .frame(width: 150, alignment: .leading)
        }
        .rowStyle()
    }
}

#Preview {
    ContentView(shifts: .preview)
}
