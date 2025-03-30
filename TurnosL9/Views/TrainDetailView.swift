//
//  TrainDetailView.swift
//  TurnosL9
//
//  Created by Jose Antonio Mendoza on 31/10/24.
//

import SwiftUI

struct TrainDetailView: View {
    let train: Train
    
    var body: some View {
        ScrollView {
            Section {
                ForEach(Array(train.stops.enumerated()), id: \.offset) { index, stop in
                    stopRowView(stop: stop)
                        .rowStyle(in: color(for: index))
                        .overlay(alignment: .leading) {
                            TimelineView(.animation) { _ in
                                Circle()
                                    .frame(width: 8, height: 8)
                                    .offset(x: -12)
                                    .opacity(showIndicator(for: stop, with: index) ? 1 : 0)
                                    .foregroundStyle(.red)
                                    .animation(.easeInOut(duration: 1), value: showIndicator(for: stop, with: index))
                            }
                        }
                }
            } header: {
                TrainRowView(train: train, color: .row, showIndicator: false)
            }
            .padding(.horizontal)
        }
        .contentMargins([.top, .bottom], 40)
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
    func stopRowView(stop: Stop) -> some View {
        LabeledContent(stop.location.rawValue) {
            Text(stop.departure.positionalTimeString)
                .monospacedStyle()
        }
        .padding(.horizontal)
    }
    
    private func showIndicator(for stop: Stop, with index: Int) -> Bool {
        guard train.isRunning else { return false }
        
        if index == 0 {
            return train.currentTime == stop.departure
        } else {
            return train.currentTime <= stop.departure && train.currentTime > train.stops[index - 1].departure
        }
    }
    
    private func color(for index: Int) -> Color {
        .gray.opacity(index.isMultiple(of: 2) ? 0.5 : 0.2)
    }
}
