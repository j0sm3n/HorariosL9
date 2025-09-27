//
//  TrainRowView.swift
//  TurnosL9WatchOS Watch App
//
//  Created by Jose Antonio Mendoza on 27/9/25.
//

import SwiftUI

struct TrainRowView: View {
    let train: Train

    var body: some View {
        HStack(spacing: 40) {
            Text(train.number.formatted())
                .monospaced()
                .font(.title3)
                .fontWeight(train.isRunning ? .bold : .light)
            
            VStack {
                LabeledContent(train.origin.monogram) {
                    Text(train.departure.formattedTime)
                        .monospaced()
                }
                LabeledContent(train.destination.monogram) {
                    Text(train.arrival.formattedTime)
                        .monospaced()
                }
            }
            .font(.caption2)
            .fontWeight(train.isRunning ? .bold : .light)
        }
        .foregroundStyle(train.isRunning ? .black : .primary)
        .listRowBackground(
            RoundedRectangle(cornerRadius: 12)
                .background(Color.clear)
                .foregroundStyle(train.isRunning ? .row : Color.gray.opacity(0.2))
        )
    }
}

#Preview {
    TrainRowView(train: .preview)
}
