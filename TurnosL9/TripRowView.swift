//
//  TripRowView.swift
//  TurnosL9
//
//  Created by Jose Antonio Mendoza on 1/11/24.
//

import SwiftUI

struct TripRowView: View {
    let trip: Trip

    var body: some View {
        HStack {
            Text(trip.train)
                .rowTitleStyle()
            
            Spacer()
            
            Group {
                VStack(alignment: .center) {
                    Text(trip.origin)
                    Text(trip.departure.timeString)
                        .timeStyle(with: .callout)
                }

                VStack(alignment: .center) {
                    Text(trip.destination)
                    Text(trip.arrival.timeString)
                        .timeStyle(with: .callout)
                }
            }
            .font(.callout)
            .frame(width: 125, alignment: .center)
        }
        .rowStyle(in: .gray.opacity(trip.isEven ? 0.5 : 0.2))
    }
}

#if DEBUG
#Preview {
    TripRowView(trip: .preview)
        .padding(.horizontal)
}
#endif
