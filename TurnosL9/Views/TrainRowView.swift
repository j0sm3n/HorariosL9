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
    
    var body: some View {
        TimelineView(.animation) { _ in
            createRow(for: dynamicTypeSize)
                .rowStyle(in: color)
                .overlay(alignment: overlayAlignment) {
                    Circle()
                        .frame(width: width, height: width)
                        .foregroundStyle(.red)
                        .offset(x: offset.x, y: offset.y)
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

// MARK: - Computed properties
extension TrainRowView {
    var opacity: Double {
        train.isRunning && showIndicator ? 1 : 0
    }
    
    var width: CGFloat {
        switch dynamicTypeSize {
            case .accessibility1, .accessibility2:
                return 12
            case .accessibility3, .accessibility4, .accessibility5:
                return 16
            default:
                return 8
        }
    }
    
    var overlayAlignment: Alignment {
        dynamicTypeSize > .accessibility2 ? .topLeading : .leading
    }
    
    var offset: (x: CGFloat, y: CGFloat) {
        switch dynamicTypeSize {
            case .xxxLarge, .accessibility1, .accessibility2:
                return (x: 6, y: 0)
            case .accessibility3, .accessibility4, .accessibility5:
                return (x: 12, y: 24)
            default:
                return (x: 12, y: 0)
        }
    }
}

// MARK: - Dynamic size row
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
                    Text(train.departure.formattedTime)
                        .monospacedStyle()
                }
                
                VStack(alignment: .center) {
                    Text(train.destination.rawValue)
                    Text(train.arrival.formattedTime)
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
                    Text(train.departure.formattedTime)
                        .monospacedStyle()
                }
                
                VStack(alignment: .center) {
                    Text(train.destination.rawValue)
                    Text(train.arrival.formattedTime)
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
                    Text(train.departure.formattedTime)
                        .monospacedStyle()
                }
                
                VStack(alignment: .center) {
                    Text(train.destination.rawValue)
                    Text(train.arrival.formattedTime)
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
                .frame(width: 130)
            
            VStack(spacing: 0) {
                LabeledContent {
                    Text(train.departure.formattedTime)
                        .monospacedStyle()
                } label: {
                    Text(train.origin.monogram)
                }
                
                LabeledContent {
                    Text(train.arrival.formattedTime)
                        .monospacedStyle()
                } label: {
                    Text(train.destination.monogram)
                }
            }
            .font(.callout)
        }
    }
    
    var xxLargeTrainRow: some View {
        VStack(spacing: 0) {
            Text(train.number.formatted())
                .rowTitleStyle()
            
            Group {
                LabeledContent {
                    Text(train.departure.formattedTime)
                        .monospacedStyle()
                } label: {
                    Text(train.origin.monogram)
                }
                
                LabeledContent {
                    Text(train.arrival.formattedTime)
                        .monospacedStyle()
                } label: {
                    Text(train.destination.monogram)
                }
            }
            .font(.callout)
        }
    }

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
