//
//  ShiftDetailView.swift
//  TurnosL9
//
//  Created by Jose Antonio Mendoza on 31/10/24.
//

import SwiftUI

struct ShiftDetailView: View {
    let shift: Shift

    var body: some View {
        ScrollView {
            Section {
                ForEach(shift.trains) { train in
                    NavigationLink {
                        TrainDetailView(train: train)
                    } label: {
                        TrainRowView(train: train, color: train.color, showIndicator: true)
                    }
                }
            } header: {
                ShiftRowView(shift: shift)
            }
            .padding(.horizontal)
        }
        .contentMargins([.top, .bottom], 40)
        .overlay {
            if shift.trains.isEmpty {
                    ContentUnavailableView("Reserva y Maniobras", systemImage: "exclamationmark.triangle.fill")
            }
        }
    }
}

#if DEBUG
#Preview {
    NavigationStack {
        ShiftDetailView(shift: .preview)
    }
}
#endif
