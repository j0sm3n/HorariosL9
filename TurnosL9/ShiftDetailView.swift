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
                ForEach(shift.trips) { trip in
                    NavigationLink {
                        TripDetailView(trip: trip)
                    } label: {
                        TripRowView(trip: trip)
                    }
                }
            } header: {
                ShiftRowView(shift: shift)
            }
            .padding(.horizontal)
        }
        .contentMargins([.top, .bottom], 40)
        .overlay {
            if shift.trips.isEmpty {
                    ContentUnavailableView("Reserva y Maniobras", systemImage: "exclamationmark.triangle.fill")
            }
        }
    }
}

#Preview {
    NavigationStack {
        ShiftDetailView(shift: .preview)
    }
}
