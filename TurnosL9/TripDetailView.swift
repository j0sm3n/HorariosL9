//
//  TripDetailView.swift
//  TurnosL9
//
//  Created by Jose Antonio Mendoza on 31/10/24.
//

import SwiftUI

struct TripDetailView: View {
    let trip: Trip

    var body: some View {
        List {
            ForEach(trip.stops) { stop in
                Text(stop.location.rawValue)
            }
        }
    }
}

#Preview {
    TripDetailView(trip: .preview)
}
