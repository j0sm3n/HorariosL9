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
        ScrollView {
            ForEach(trip.stops) { stop in
                let arrival: TimeInterval = TimeInterval(duration: trip.departure) + TimeInterval(duration: stop.duration)
                LabeledContent(stop.location.rawValue, value: arrival.positionalTimeString)
                    .listRowSeparator(.hidden)
                    .rowStyle()
            }
            .padding(.horizontal)
            .navigationTitle(trip.train)
        }
        .contentMargins([.top, .bottom], 40)
    }
}

#Preview {
    NavigationStack {
        TripDetailView(trip: .preview)
    }
}
