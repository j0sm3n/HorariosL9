//
//  StopListView.swift
//  TurnosL9WatchOS Watch App
//
//  Created by Jose Antonio Mendoza on 27/9/25.
//

import SwiftUI

struct StopListView: View {
    let train: Train
    
    var body: some View {
        ScrollViewReader { proxy in
            List(train.stops) { stop in
                LabeledContent(stop.location.monogram) {
                    Text(stop.departure.formattedTime)
                        .monospaced()
                }
                .id(indexOf(stop: stop))
                .fontWeight(fontWeight(for: stop))
            }
            .task {
                proxy.scrollTo(getCurrentStopIndex())
            }
        }
        .toolbar {
            ToolbarItem(placement: .automatic) {
                Button { } label: { trainDetails }
                    .tint(Color.row)
            }
        }
    }
}

#Preview {
    StopListView(train: .preview)
}

extension StopListView {
    // MARK: - Private views
    @ViewBuilder
    private var trainDetails: some View {
        VStack(spacing: 0) {
            HStack {
                Image(systemName: "tram")
                Text(train.number.formatted())
            }
            
            HStack {
                Group {
                    VStack(alignment: .center) {
                        Text(train.origin.rawValue)
                        Text(train.departure.formattedTime)
                            .monospaced()
                    }
                    
                    VStack(alignment: .center) {
                        Text(train.destination.rawValue)
                        Text(train.arrival.formattedTime)
                            .monospaced()
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .font(.system(size: 12))
        .foregroundStyle(.black)
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
    
    private func fontWeight(for stop: Stop) -> Font.Weight {
        isHighlighted(stop: stop) ? .heavy : .light
    }
    
    private func indexOf(stop: Stop) -> Int? {
        train.stops.firstIndex(of: stop)
    }
    
    private func getCurrentStopIndex() -> Int? {
        train.stops.firstIndex(where: { isHighlighted(stop: $0) })
    }
}
