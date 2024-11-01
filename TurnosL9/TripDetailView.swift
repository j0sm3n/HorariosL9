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
            Section {
                ForEach(trip.stops) { stop in
                    LabeledContent(stop.location.rawValue, value: arrival(for: stop))
                        .listRowSeparator(.hidden)
                        .rowStyle()
                }
            } header: {
                TripRowView(trip: trip)
            }
            .padding(.horizontal)
        }
        .contentMargins([.top, .bottom], 40)
    }
    
    private func arrival(for stop: Stop) -> String {
        let arrival = TimeInterval(duration: trip.departure) + TimeInterval(duration: stop.duration)
        return arrival.positionalTimeString
    }
}

#Preview {
    NavigationStack {
        TripDetailView(trip: .preview)
    }
}
