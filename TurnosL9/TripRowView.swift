//
//  TripRowView.swift
//  TurnosL9
//
//  Created by Jose Antonio Mendoza on 1/11/24.
//

import SwiftUI

struct TripRowView: View {
    let trip: Trip
    let color: Color
    let showIndicator: Bool
    
    var opacity: Double {
        trip.isRunning && showIndicator ? 1 : 0
    }

    var body: some View {
        HStack {
            Text(trip.train)
                .rowTitleStyle()
            
            Spacer()
            
            Group {
                VStack(alignment: .center) {
                    Text(trip.origin)
                    Text(trip.tripDeparture.positionalTimeString)
                        .monospacedStyle()
                }

                VStack(alignment: .center) {
                    Text(trip.destination)
                    Text(trip.tripArrival.positionalTimeString)
                        .monospacedStyle()
                }
            }
            .font(.callout)
            .frame(width: 125, alignment: .center)
        }
        .rowStyle(in: color)
        .overlay(alignment: .topLeading) {
            TimelineView(.animation) { _ in
                Circle()
                    .frame(width: 8, height: 8)
                    .foregroundStyle(.red)
                    .offset(x: -12, y: trip.tripIndicatorPosition)
                    .opacity(opacity)
            }
        }
    }
}

#if DEBUG
#Preview {
    TripRowView(trip: .preview, color: .row, showIndicator: true)
        .padding(.horizontal)
}
#endif
