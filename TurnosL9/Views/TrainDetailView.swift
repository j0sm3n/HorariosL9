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
                ForEach(Array(train.stops.enumerated()), id: \.offset) { index, stop in
                    LabeledContent(dynamicTypeSize > .accessibility2 ? stop.location.monogram : stop.location.rawValue) {
                        Text(stop.departure.formattedTime)
                            .monospacedStyle()
                    }
                    .padding(.horizontal)
                    .rowStyle(in: color(for: index))
                    .overlay(alignment: .leading) {
                        TimelineView(.animation) { _ in
                            Circle()
                                .frame(width: 8, height: 8)
                                .offset(x: 12)
                                .opacity(showIndicator(for: stop, with: index) ? 1 : 0)
                                .foregroundStyle(.red)
                                .animation(.easeInOut(duration: 1), value: showIndicator(for: stop, with: index))
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
                        Text(dynamicTypeSize > .accessibility2 ? train.origin.monogram : train.origin.rawValue)
                        Text(train.departure.formattedTime)
                            .monospacedStyle()
                    }
                    
                    VStack(alignment: .center) {
                        Text(dynamicTypeSize > .accessibility2 ? train.destination.monogram : train.destination.rawValue)
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
    private func showIndicator(for stop: Stop, with index: Int) -> Bool {
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
}
