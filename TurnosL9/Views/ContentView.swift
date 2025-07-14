//
//  ContentView.swift
//  TurnosL9
//
//  Created by Jose Antonio Mendoza on 23/10/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(ViewModel.self) var viewModel
    @AppStorage("showBenidormShifts") var showBenidormShifts: Bool = true
    @State private var path = NavigationPath()
    
    private var toolbarForegroundColor: Color {
        colorScheme == .dark ? Color.white : Color.black
    }
    
    private var filteredShifts: [Shift] {
        showBenidormShifts
        ? viewModel.shifts.filter { $0.location == Location.benidorm.rawValue }
        : viewModel.shifts.filter { $0.location == Location.denia.rawValue }
    }
    
    var body: some View {
        @Bindable var viewModel = self.viewModel
        NavigationStack(path: $path) {
            locationPicker
            ShiftListView(shifts: filteredShifts)
                .navigationTitle("Horarios L9")
                .navigationDestination(for: Train.self) { train in
                    TrainDetailView(train: train)
                }
                .navigationDestination(for: UUID.self) { shiftID in
                    if let index = viewModel.shifts.firstIndex(where: { $0.id == shiftID }) {
                        ShiftDetailView(shift: $viewModel.shifts[index])
                    }
                }
                .onOpenURL { url in
                    print("onOpenUrl: \(url)")
                    let trainNumberString = url.lastPathComponent
                    print("Train \(trainNumberString)")
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
        .environment(ViewModel())
}
#endif

extension ContentView {
    private var locationPicker: some View {
        Picker("Residencia", selection: $showBenidormShifts) {
            Text(Location.benidorm.rawValue).tag(true)
            Text(Location.denia.rawValue).tag(false)
        }
        .pickerStyle(.segmented)
        .padding(.vertical)
        .padding(.horizontal, 80)
    }
    
    private func getShiftAndTrain(for trainNumber: String) -> (shift: Shift, train: Train)? {
        guard let trainNumber = Int(trainNumber) else {
            return nil
        }
        for shift in viewModel.shifts {
            for train in shift.trains {
                if train.number == trainNumber {
                    return (shift, train)
                }
            }
        }
        return nil
    }
}
