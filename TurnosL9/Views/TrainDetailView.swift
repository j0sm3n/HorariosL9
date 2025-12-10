//
//  TrainDetailView.swift
//  TurnosL9
//
//  Created by Jose Antonio Mendoza on 31/10/24.
//

import SwiftUI

struct TrainDetailView: View {
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    @State private var showMonogram: Bool = false
    let train: Train
    
    var body: some View {
        VStack(spacing: 0) {
            headerView
            ScrollView {
                TimelineView(.animation) { _ in
                    ForEach(train.stops) { stop in
                        LabeledContent(stopString(for: stop.location)) {
                            Text(stop.departure.formattedTime)
                                .monospaced()
                        }
                        .padding(.horizontal)
                        .fontWeight(fontWeight(for: stop))
                        .rowStyle(in: color(for: stop))
                        .onTapGesture {
                            showMonogram.toggle()
                        }
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
    private func isHighlighted(stop: Stop) -> Bool {
        guard let index = indexOf(stop: stop) else { return false }
        
        if index == 0 {
            return train.currentTime == stop.departure
        } else {
            return train.currentTime.isEarlierOrEqual(to: stop.departure) && train.stops[index - 1].departure.isEarlier(than: train.currentTime)
        }
    }
    
    private func color(for stop: Stop) -> Color {
        if isHighlighted(stop: stop) {
            return Color.row
        } else {
            guard let index = indexOf(stop: stop) else { return Color.white }
            return Color.gray.opacity(index.isMultiple(of: 2) ? 0.5 : 0.2)
        }
    }
    
    private func fontWeight(for stop: Stop) -> Font.Weight {
        isHighlighted(stop: stop) ? .heavy : .light
    }
    
    private func stopString(for location: Location) -> String {
        (dynamicTypeSize > .accessibility2 || showMonogram) ? location.monogram : location.rawValue
    }
    
    private func indexOf(stop: Stop) -> Int? {
        train.stops.firstIndex(of: stop)
    }
}
