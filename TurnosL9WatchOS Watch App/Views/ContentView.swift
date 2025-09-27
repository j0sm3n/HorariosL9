//
//  ContentView.swift
//  TurnosL9WatchOS Watch App
//
//  Created by Jose Antonio Mendoza on 26/9/25.
//

import SwiftUI

struct ContentView: View {
    @Environment(ShiftStore.self) var store
    @State private var selectedShiftId: Shift.ID?
    @State private var selectedTrainId: Train.ID?

    var body: some View {
        NavigationSplitView {
            ShiftListView(selectedShiftId: $selectedShiftId)
        } content: {
            if let shift = store.shift(id: selectedShiftId),
               shift.trains.isEmpty == false {
                TrainListView(selectedTrainId: $selectedTrainId, shift: shift)
            } else {
                ContentUnavailableView("Reserva y Maniobras", systemImage: "exclamationmark.triangle.fill")
                    .offset(y: 30)
            }
        } detail: {
            if let shift = store.shift(id: selectedShiftId),
               let train = store.train(id: selectedTrainId, shift: shift) {
                StopListView(train: train)
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(ShiftStore())
}
