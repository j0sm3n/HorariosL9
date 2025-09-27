//
//  TrainListView.swift
//  TurnosL9WatchOS Watch App
//
//  Created by Jose Antonio Mendoza on 27/9/25.
//

import SwiftUI

struct TrainListView: View {
    @Environment(ShiftStore.self) var store
    @Binding var selectedTrainId: UUID?
    let shift: Shift

    var body: some View {
        ScrollViewReader { proxy in
            List(shift.trains, selection: $selectedTrainId) { train in
                TrainRowView(train: train)
                    .id(train.id)
            }
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button {} label: { shiftDetails }
                        .tint(Color.row)
                }
            }
            .task {
                proxy.scrollTo(getRunningTrainId())
            }
        }
    }
}

#Preview {
    @Previewable @State var selectedTrainId: UUID? = Train.preview.id
    @Previewable @State var shift: Shift = .preview
    
    TrainListView(selectedTrainId: $selectedTrainId, shift: shift)
        .environment(ShiftStore())
}

extension TrainListView {
    var shiftDetails: some View {
        VStack(spacing: 0) {
            Text("\(shift.name)")
                .bold()
            HStack {
                VStack(alignment: .leading) {
                    LabeledContent("Inicio") {
                        Text(shift.start.formattedTime)
                            .monospaced()
                    }
                    LabeledContent("Fin") {
                        Text(shift.end.formattedTime)
                            .monospaced()
                    }
                }
                
                VStack(alignment: .leading) {
                    LabeledContent("Jorn.") {
                        Text(shift.duration.positionalTimeString)
                            .monospaced()
                    }
                    if let saturation = shift.saturation {
                        LabeledContent("Sat.") {
                            Text("\(saturation.formatted())")
                                .monospaced()
                        }
                    }
                }
            }
            .font(.system(size: 12))
        }
        .foregroundStyle(.black)
    }
    
    func getRunningTrainId() -> UUID? {
        shift.trains.first(where: { $0.isRunning })?.id
    }
}
