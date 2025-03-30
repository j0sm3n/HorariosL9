//
//  ShiftRowView.swift
//  TurnosL9
//
//  Created by Jose Antonio Mendoza on 23/10/24.
//

import SwiftUI

struct ShiftRowView: View {
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    let shift: Shift
    
    var body: some View {
        createRow(for: dynamicTypeSize)
    }
}

#if DEBUG
#Preview {
    ShiftRowView(shift: .preview)
        .padding(.horizontal)
}
#endif

extension ShiftRowView {
    var smallShiftRow: some View {
        HStack {
            Text(shift.name)
                .font(.largeTitle)
                .bold()
                .rowTitleStyle()
                .frame(width: 72, height: 48)
            
            Spacer()
            
            HStack(spacing: 4) {
                VStack(alignment: .leading) {
                    LabeledContent("Inicio") {
                        Text(shift.start.positionalTimeString)
                            .monospacedStyle()
                    }
                    LabeledContent("Fin") {
                        Text(shift.end.positionalTimeString)
                            .monospacedStyle()
                    }
                }
                .font(.callout)
                .frame(width: 100, alignment: .leading)
                
                Spacer()
                
                VStack(alignment: .leading) {
                    LabeledContent("Jornada") {
                        Text(shift.duration.positionalTimeString)
                            .monospacedStyle()
                    }
                    if let saturation = shift.saturation {
                        LabeledContent("Saturación") {
                            Text("\(saturation.formatted()) %")
                                .fontWeight(.semibold)
                        }
                    } else {
                        Text("")
                    }
                }
                .font(.callout)
                .frame(width: 150, alignment: .leading)
            }
        }
        .rowStyle()
        .lineLimit(1)
    }
    
    var mediumShiftRow: some View {
        HStack {
            Text(shift.name)
                .font(.largeTitle)
                .bold()
                .rowTitleStyle()
                .frame(width: 72, height: 48)
            
            HStack(spacing: 4) {
                VStack(alignment: .leading) {
                    LabeledContent("Inicio") {
                        Text(shift.start.positionalTimeString)
                            .monospacedStyle()
                    }
                    LabeledContent("Fin") {
                        Text(shift.end.positionalTimeString)
                            .monospacedStyle()
                    }
                }
                .font(.callout)
                .frame(width: 120, alignment: .leading)
                
                Spacer()
                
                VStack(alignment: .leading) {
                    LabeledContent("Jorn.") {
                        Text(shift.duration.positionalTimeString)
                            .monospacedStyle()
                    }
                    if let saturation = shift.saturation {
                        LabeledContent("Sat.") {
                            Text("\(saturation.formatted()) %")
                                .fontWeight(.semibold)
                        }
                    } else {
                        Text("")
                    }
                }
                .font(.callout)
                .frame(width: 130, alignment: .leading)
            }
        }
        .rowStyle()
        .lineLimit(1)
    }
    
    var largeShiftRow: some View {
        HStack(alignment: .top) {
            Text(shift.name)
                .font(.largeTitle)
                .bold()
                .rowTitleStyle()
                .frame(width: 80, height: 48)
                .padding(.top, 16)
            
            VStack(alignment: .leading, spacing: 2) {
                LabeledContent("Inicio") {
                    Text(shift.start.positionalTimeString)
                        .monospacedStyle()
                }
                LabeledContent("Fin") {
                    Text(shift.end.positionalTimeString)
                        .monospacedStyle()
                }
                
                LabeledContent("Jornada") {
                    Text(shift.duration.positionalTimeString)
                        .monospacedStyle()
                }
                if let saturation = shift.saturation {
                    LabeledContent("Saturación") {
                        Text("\(saturation.formatted()) %")
                            .fontWeight(.semibold)
                    }
                } else {
                    Text("")
                }
            }
            .font(.callout)
        }
        .rowStyle()
        .lineLimit(1)
    }
    
    var xLargeShiftRow: some View {
        HStack(alignment: .top) {
            Text(shift.name)
                .font(.largeTitle)
                .bold()
                .rowTitleStyle()
                .frame(width: 90, height: 48)
                .padding(.top, 18)
            
            VStack(alignment: .leading, spacing: 2) {
                LabeledContent("Inicio") {
                    Text(shift.start.positionalTimeString)
                        .monospacedStyle()
                }
                LabeledContent("Fin") {
                    Text(shift.end.positionalTimeString)
                        .monospacedStyle()
                }
                
                LabeledContent("Jor.") {
                    Text(shift.duration.positionalTimeString)
                        .monospacedStyle()
                }
                if let saturation = shift.saturation {
                    LabeledContent("Sat.") {
                        Text("\(saturation.formatted()) %")
                            .fontWeight(.semibold)
                    }
                } else {
                    Text("")
                }
            }
            .font(.callout)
        }
        .rowStyle()
        .lineLimit(1)
    }
    
    var xxLargeShiftRow: some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack {
                Text(shift.name)
                    .font(.largeTitle)
                    .bold()
                    .rowTitleStyle()
                    .frame(width: 96, height: 48)
            }
            .padding(.vertical,24)
            .frame(maxWidth: .infinity, alignment: .center)
            
            LabeledContent("Inicio") {
                Text(shift.start.positionalTimeString)
                    .monospacedStyle()
            }
            LabeledContent("Fin") {
                Text(shift.end.positionalTimeString)
                    .monospacedStyle()
            }
            
            LabeledContent("Jorn.") {
                Text(shift.duration.positionalTimeString)
                    .monospacedStyle()
            }
            if let saturation = shift.saturation {
                LabeledContent("Satu.") {
                    Text("\(saturation.formatted()) %")
                        .fontWeight(.semibold)
                }
            } else {
                Text("")
            }
        }
        .font(.callout)
        .rowStyle()
        .lineLimit(1)
    }
}

extension ShiftRowView {
    @ViewBuilder
    private func createRow(for size: DynamicTypeSize) -> some View {
        if size > .accessibility3 {
            xxLargeShiftRow
        } else if size > .accessibility1 {
            xLargeShiftRow
        } else if size > .xxLarge {
            largeShiftRow
        } else if size > .large {
            mediumShiftRow
        } else {
            smallShiftRow
        }
    }
}
