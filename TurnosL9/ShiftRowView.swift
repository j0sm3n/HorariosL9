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
                Text("Inicio: \(shift.startTime.positionalTimeString)")
                Text("Fin: \(shift.endTime.positionalTimeString)")
            }
            .font(.callout)
            .frame(width: 90, alignment: .leading)
            
            Spacer()
            
            VStack(alignment: .leading) {
                Text("Jornada: \(shift.duration.abbreviatedTimeString)")
                if let saturation = shift.saturation {
                    Text("Saturación: \(saturation.formatted()) %")
                } else {
                    Text("")
                }
            }
            .font(.callout)
            .frame(width: 150, alignment: .leading)
        }
        .foregroundStyle(.primary)
        .frame(maxWidth: .infinity)
        .padding(10)
        .background(Color.row.shadow(.inner(color: .white, radius: 5)), in: .rect(cornerRadius: 16))
    }
}

#Preview {
    ContentView()
}
