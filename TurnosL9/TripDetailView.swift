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
                ForEach(Array(trip.stops.enumerated()), id: \.offset) { index, stop in
                    LabeledContent(stop.location.rawValue) {
                        Text(arrival(for: stop))
                            .monospacedStyle()
                    }
                    .padding(.horizontal)
                    .rowStyle(in: .gray.opacity(index.isMultiple(of: 2) ? 0.5 : 0.2))
                }
            } header: {
                TripRowView(trip: trip, showIndicator: false)
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

#if DEBUG
#Preview {
    NavigationStack {
        TripDetailView(trip: .preview)
    }
}
#endif
