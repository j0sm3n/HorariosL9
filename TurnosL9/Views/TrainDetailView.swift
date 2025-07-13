//
//  TrainDetailView.swift
//  TurnosL9
//
//  Created by Jose Antonio Mendoza on 31/10/24.
//

import SwiftUI

struct TrainDetailView: View {
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    let train: Train
    
    var body: some View {
        VStack(spacing: 0) {
            headerView
            ScrollView {
                TimelineView(.animation) { _ in
                    ForEach(Array(train.stops.enumerated()), id: \.offset) { index, stop in
                        LabeledContent(stopString(for: stop.location)) {
                            Text(stop.departure.formattedTime)
                                .monospaced()
                        }
                        .padding(.horizontal)
                        .fontWeight(isHighlighted(for: stop, with: index) ? .heavy : .light)
                        .rowStyle(in: color(for: index))
                    }
                }
                .padding(.horizontal)
            }
        }
        .contentMargins(.top, 30)
    }
}

#if DEBUG
#Preview {
    NavigationStack {
        TrainDetailView(train: .preview)
    }
}
#endif

extension TrainDetailView {
    // MARK: - Private views
    @ViewBuilder
    private var headerView: some View {
        VStack(spacing: 16) {
            HStack {
                Image(systemName: "tram")
                Text(train.number.formatted())
                    .rowTitleStyle()
            }
            
            HStack {
                Group {
                    VStack(alignment: .center) {
                        Text(stopString(for: train.origin))
                        Text(train.departure.formattedTime)
                            .monospacedStyle()
                    }
                    
                    VStack(alignment: .center) {
                        Text(stopString(for: train.destination))
                        Text(train.arrival.formattedTime)
                            .monospacedStyle()
                    }
                }
                .font(.callout)
                .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .padding()
        .background(Color.row)
    }

    // MARK: - Private functions
    private func isHighlighted(for stop: Stop, with index: Int) -> Bool {
        guard train.isRunning else { return false }
        
        if index == 0 {
            return train.currentTime == stop.departure
        } else {
            return train.currentTime.isEarlierOrEqual(to: stop.departure) && train.stops[index - 1].departure.isEarlier(than: train.currentTime)
        }
    }
    
    private func color(for index: Int) -> Color {
        .gray.opacity(index.isMultiple(of: 2) ? 0.5 : 0.2)
    }
    
    private func stopString(for location: Location) -> String {
        dynamicTypeSize > .accessibility2 ? location.monogram : location.rawValue
    }
}
