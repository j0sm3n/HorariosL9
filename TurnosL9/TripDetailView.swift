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
                    stopRowView(stop: stop)
                        .rowStyle(in: color(for: index))
                        .overlay(alignment: .leading) {
                            TimelineView(.animation) { _ in
                                Circle()
                                    .frame(width: 8, height: 8)
                                    .offset(x: -12)
                                    .opacity(showIndicator(for: stop, with: index) ? 1 : 0)
                                    .foregroundStyle(.red)
                            }
                        }
                }
            } header: {
                TripRowView(trip: trip, color: .row, showIndicator: false)
            }
            .padding(.horizontal)
        }
        .contentMargins([.top, .bottom], 40)
    }
}

#if DEBUG
#Preview {
    NavigationStack {
        TripDetailView(trip: .preview)
    }
}
#endif

extension TripDetailView {
    func stopRowView(stop: Stop) -> some View {
        LabeledContent(stop.location.rawValue) {
            Text(arrivalString(for: stop))
                .monospacedStyle()
        }
        .padding(.horizontal)
    }
    
    private func arrivalString(for stop: Stop) -> String {
        (trip.tripDeparture + stop.stopDuration).positionalTimeString
    }
    
    private func showIndicator(for stop: Stop, with index: Int) -> Bool {
        guard trip.isRunning else { return false }
        
        let timeRunning = trip.currentTime - trip.tripDeparture

        if index == 0 {
            return timeRunning == 0 // Ok
        } else {
            return timeRunning <= stop.stopDuration && timeRunning > trip.stops[index - 1].stopDuration
        }
    }
    
    private func color(for index: Int) -> Color {
        .gray.opacity(index.isMultiple(of: 2) ? 0.5 : 0.2)
    }
}
