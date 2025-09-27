//
//  ContentView.swift
//  TurnosL9
//
//  Created by Jose Antonio Mendoza on 23/10/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(ShiftStore.self) var store
    @State private var path = NavigationPath()
    
    private var toolbarForegroundColor: Color {
        colorScheme == .dark ? Color.white : Color.black
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            locationPicker
            ShiftListView()
                .navigationTitle("Horarios L9")
                .navigationDestination(for: Train.self) { train in
                    TrainDetailView(train: train)
                }
                .navigationDestination(for: UUID.self) { shiftID in
                    if let index = store.shifts.firstIndex(where: { $0.id == shiftID }) {
                        ShiftDetailView(shift: Bindable(store).shifts[index])
                    }
                }
                .onOpenURL { url in
                    let trainNumberString = url.lastPathComponent
                    if let result = getShiftAndTrain(for: trainNumberString) {
                        path.removeLast(path.count)
                        path.append(result.shift.id)
                        path.append(result.train)
                    }
                }
        }
    }
}

#if DEBUG
#Preview {
    ContentView()
        .environment(ShiftStore())
}
#endif

extension ContentView {
    @ViewBuilder
    private var locationPicker: some View {
        Picker("Residencia", selection: Bindable(store).selectedShiftsLocation) {
            Text(Location.benidorm.rawValue).tag(Location.benidorm)
            Text(Location.denia.rawValue).tag(Location.denia)
        }
        .pickerStyle(.segmented)
        .padding(.vertical)
        .padding(.horizontal, 80)
    }
    
    private func getShiftAndTrain(for trainNumber: String) -> (shift: Shift, train: Train)? {
        guard let trainNumber = Int(trainNumber) else {
            return nil
        }
        for shift in store.shifts {
            for train in shift.trains {
                if train.number == trainNumber {
                    return (shift, train)
                }
            }
        }
        return nil
    }
}
