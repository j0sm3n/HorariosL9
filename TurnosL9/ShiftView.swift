//
//  ShiftView.swift
//  TurnosL9
//
//  Created by Jose Antonio Mendoza on 28/10/24.
//

import SwiftUI

struct ShiftView: View {
    let shift: Shift

    var body: some View {
        VStack {
            Header(shift: shift)
        }
    }
}

#Preview {
    ShiftView(shift: .preview)
}

extension ShiftView {
    struct Header: View {
        let shift: Shift

        var body: some View {
            HStack {
                Text(shift.name)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundStyle(.row)
                    .fontDesign(.monospaced)
                    .frame(minWidth: 64, minHeight: 64)
                    .background(Color.primary.shadow(.inner(color: .white, radius: 5)), in: .rect(cornerRadius: 16))
                
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
            .foregroundStyle(.primary)
            .frame(maxWidth: .infinity)
            .padding(10)
            .background(Color.row.opacity(0.5).shadow(.inner(color: .white, radius: 5)), in: .rect(cornerRadius: 16))
        }
    }
}
