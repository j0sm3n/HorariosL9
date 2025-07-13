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
        }
    }
}

#if DEBUG
#Preview {
    TrainRowView(train: .preview, color: .row, showIndicator: true)
        .padding(.horizontal)
}
#endif

// MARK: - Dynamic size row
extension TrainRowView {
    var smallTrainRow: some View {
        HStack {
            Text(train.number.formatted())
                .rowTitleStyle(bold: train.isRunning)
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
            .groupStyle(highlight: train.isRunning)
            .frame(maxWidth: .infinity, alignment: .center)
        }
    }
    
    var mediumTrainRow: some View {
        HStack {
            Text(train.number.formatted())
                .rowTitleStyle(bold: train.isRunning)
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
            .groupStyle(highlight: train.isRunning)
            .frame(maxWidth: .infinity, alignment: .center)
        }
    }
    
    var largeTrainRow: some View {
        HStack {
            Text(train.number.formatted())
                .rowTitleStyle(bold: train.isRunning)
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
            .groupStyle(highlight: train.isRunning)
            .frame(maxWidth: .infinity, alignment: .center)
        }
    }
    
    var xLargeTrainRow: some View {
        HStack {
            Text(train.number.formatted())
                .rowTitleStyle(bold: train.isRunning)
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
            .groupStyle(highlight: train.isRunning)
        }
    }
    
    var xxLargeTrainRow: some View {
        VStack(spacing: 0) {
            Text(train.number.formatted())
                .rowTitleStyle(bold: train.isRunning)
            
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
            .groupStyle(highlight: train.isRunning)
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

fileprivate struct GroupStyle: ViewModifier {
    let highlight: Bool

    func body(content: Content) -> some View {
        content
            .font(.callout)
            .fontWeight(highlight ? .bold : .light)
    }
}

extension View {
    public func groupStyle(highlight: Bool = false) -> some View {
        modifier(GroupStyle(highlight: highlight))
    }
}
