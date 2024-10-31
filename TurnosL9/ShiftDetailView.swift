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
        List(shift.trips) { trip in
            NavigationLink {
                TripDetailView(trip: trip)
            } label: {
                Text(trip.train)
            }

        }
    }
}

#Preview {
    ShiftDetailView(shift: .preview)
}
