//
//  TripRowView.swift
//  TurnosL9
//
//  Created by Jose Antonio Mendoza on 1/11/24.
//

import SwiftUI

struct TripRowView: View {
    let trip: Trip
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
                    Text(trip.departure.timeString)
                        .monospacedStyle()
                }

                VStack(alignment: .center) {
                    Text(trip.destination)
                    Text(trip.arrival.timeString)
                        .monospacedStyle()
                }
            }
            .font(.callout)
            .frame(width: 125, alignment: .center)
        }
        .rowStyle(in: .gray.opacity(trip.isEven ? 0.5 : 0.2))
        .overlay(alignment: .topLeading) {
            TimelineView(.animation) { _ in
                Circle()
                    .frame(width: 8, height: 8)
                    .tint(.red)
                    .offset(x: -10, y: trip.tripIndicatorPosition)
                    .opacity(opacity)
            }
        }
    }
}

#if DEBUG
#Preview {
    TripRowView(trip: .preview, showIndicator: true)
        .padding(.horizontal)
}
#endif
