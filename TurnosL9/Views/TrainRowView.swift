//
//  TrainRowView.swift
//  TurnosL9
//
//  Created by Jose Antonio Mendoza on 1/11/24.
//

import SwiftUI

struct TrainRowView: View {
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    let train: Train
    let color: Color
    let showIndicator: Bool
    
    var opacity: Double {
        train.isRunning && showIndicator ? 1 : 0
    }
    
    var body: some View {
        createRow(for: dynamicTypeSize)
            .rowStyle(in: color)
            .overlay(alignment: .topLeading) {
                TimelineView(.animation) { _ in
                    Circle()
                        .frame(width: 8, height: 8)
                        .foregroundStyle(.red)
                        .offset(x: -12, y: train.indicatorPosition)
                        .opacity(opacity)
                }
            }
    }
}

#if DEBUG
#Preview {
    TrainRowView(train: .preview, color: .row, showIndicator: true)
        .padding(.horizontal)
}
#endif

extension TrainRowView {
    var smallTrainRow: some View {
        HStack {
            Text(train.number.formatted())
                .rowTitleStyle()
                .frame(width: 72)
            
            Spacer()
            
            Group {
                VStack(alignment: .center) {
                    Text(train.origin.rawValue)
                    Text(train.departure.positionalTimeString)
                        .monospacedStyle()
                }
                
                VStack(alignment: .center) {
                    Text(train.destination.rawValue)
                    Text(train.arrival.positionalTimeString)
                        .monospacedStyle()
                }
            }
            .font(.callout)
            .frame(maxWidth: .infinity, alignment: .center)
        }
    }
    
    var mediumTrainRow: some View {
        HStack {
            Text(train.number.formatted())
                .rowTitleStyle()
                .frame(width: 90)
            
            Spacer()
            
            Group {
                VStack(alignment: .center) {
                    Text(train.origin.rawValue)
                    Text(train.departure.positionalTimeString)
                        .monospacedStyle()
                }
                
                VStack(alignment: .center) {
                    Text(train.destination.rawValue)
                    Text(train.arrival.positionalTimeString)
                        .monospacedStyle()
                }
            }
            .font(.callout)
            .frame(maxWidth: .infinity, alignment: .center)
        }
    }
    
    var largeTrainRow: some View {
        HStack {
            Text(train.number.formatted())
                .rowTitleStyle()
                .frame(width: 110)
            
            Spacer()
            
            Group {
                VStack(alignment: .center) {
                    Text(train.origin.rawValue)
                    Text(train.departure.positionalTimeString)
                        .monospacedStyle()
                }
                
                VStack(alignment: .center) {
                    Text(train.destination.rawValue)
                    Text(train.arrival.positionalTimeString)
                        .monospacedStyle()
                }
            }
            .font(.callout)
            .frame(maxWidth: .infinity, alignment: .center)
        }
    }
    
    var xLargeTrainRow: some View {
        HStack {
            Text(train.number.formatted())
                .rowTitleStyle()
                .frame(width: 120)
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 0) {
                LabeledContent {
                    Text(train.departure.positionalTimeString)
                        .monospacedStyle()
                } label: {
                    Text(train.origin.rawValue)
                }
                
                LabeledContent {
                    Text(train.arrival.positionalTimeString)
                        .monospacedStyle()
                } label: {
                    Text(train.destination.rawValue)
                }
            }
            .font(.callout)
            .frame(maxWidth: .infinity, alignment: .center)
        }
    }
    
    var xxLargeTrainRow: some View {
        VStack(alignment: .leading) {
            Text(train.number.formatted())
                .rowTitleStyle()
                .frame(width: 160)
                        
            VStack(alignment: .leading, spacing: 0) {
                LabeledContent {
                    Text(train.departure.positionalTimeString)
                        .monospacedStyle()
                } label: {
                    Text(train.origin.rawValue)
                }
                
                LabeledContent {
                    Text(train.arrival.positionalTimeString)
                        .monospacedStyle()
                } label: {
                    Text(train.destination.rawValue)
                }
            }
            .font(.callout)
            .frame(maxWidth: .infinity, alignment: .center)
        }
    }
}

extension TrainRowView {
    @ViewBuilder
    private func createRow(for size: DynamicTypeSize) -> some View {
                if size > .accessibility2 {
                    xxLargeTrainRow
                } else if size > .accessibility1 {
                    xLargeTrainRow
                } else
        if size > .xxxLarge {
            largeTrainRow
                } else if size > .medium {
            mediumTrainRow
        } else {
            smallTrainRow
        }
    }
}
