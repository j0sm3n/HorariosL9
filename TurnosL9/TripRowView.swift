//
//  TripRowView.swift
//  TurnosL9
//
//  Created by Jose Antonio Mendoza on 1/11/24.
//

import SwiftUI

struct TripRowView: View {
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    let trip: Trip
    let color: Color
    let showIndicator: Bool
    
    var opacity: Double {
        trip.isRunning && showIndicator ? 1 : 0
    }
    
    var body: some View {
        createRow(for: dynamicTypeSize)
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

extension TripRowView {
    var smallTripRow: some View {
        HStack {
            Text(trip.train)
                .rowTitleStyle()
                .frame(width: 72)
            
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
            .frame(maxWidth: .infinity, alignment: .center)
        }
    }
    
    var mediumTripRow: some View {
        HStack {
            Text(trip.train)
                .rowTitleStyle()
                .frame(width: 90)
            
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
            .frame(maxWidth: .infinity, alignment: .center)
        }
    }
    
    var largeTripRow: some View {
        HStack {
            Text(trip.train)
                .rowTitleStyle()
                .frame(width: 110)
            
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
            .frame(maxWidth: .infinity, alignment: .center)
        }
    }
    
    var xLargeTripRow: some View {
        HStack {
            Text(trip.train)
                .rowTitleStyle()
                .frame(width: 120)
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 0) {
                LabeledContent {
                    Text(trip.tripDeparture.positionalTimeString)
                        .monospacedStyle()
                } label: {
                    Text(trip.origin)
                }
                
                LabeledContent {
                    Text(trip.tripArrival.positionalTimeString)
                        .monospacedStyle()
                } label: {
                    Text(trip.destination)
                }
            }
            .font(.callout)
            .frame(maxWidth: .infinity, alignment: .center)
        }
    }
    
    var xxLargeTripRow: some View {
        VStack(alignment: .leading) {
            Text(trip.train)
                .rowTitleStyle()
                .frame(width: 160)
                        
            VStack(alignment: .leading, spacing: 0) {
                LabeledContent {
                    Text(trip.tripDeparture.positionalTimeString)
                        .monospacedStyle()
                } label: {
                    Text(trip.origin)
                }
                
                LabeledContent {
                    Text(trip.tripArrival.positionalTimeString)
                        .monospacedStyle()
                } label: {
                    Text(trip.destination)
                }
            }
            .font(.callout)
            .frame(maxWidth: .infinity, alignment: .center)
        }
    }
}

extension TripRowView {
    @ViewBuilder
    private func createRow(for size: DynamicTypeSize) -> some View {
                if size > .accessibility2 {
                    xxLargeTripRow
                } else if size > .accessibility1 {
                    xLargeTripRow
                } else
        if size > .xxxLarge {
            largeTripRow
                } else if size > .medium {
            mediumTripRow
        } else {
            smallTripRow
        }
    }
}
