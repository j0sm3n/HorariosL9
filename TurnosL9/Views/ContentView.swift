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
    
    private var toolbarForegroundColor: Color {
        colorScheme == .dark ? Color.white : Color.black
    }
    
    private var filteredShifts: [Shift] {
        showBenidormShifts
        ? viewModel.shifts.filter { $0.location == Location.benidorm.rawValue }
        : viewModel.shifts.filter { $0.location == Location.denia.rawValue }
    }
    
    var body: some View {
        NavigationStack {
            locationPicker
            ShiftListView(shifts: filteredShifts)
                .navigationTitle("Horarios L9")
                .navigationDestination(for: Shift.self) { shift in
                    ShiftDetailView(shift: Binding<Shift>(
                        get: { shift },
                        set: { newShift in
                            if let index = viewModel.shifts.firstIndex(where: { $0.id == shift.id }) {
                                viewModel.shifts[index] = newShift
                            }
                        }
                    ))
                }
                .navigationDestination(for: Train.self) { train in
                    TrainDetailView(train: train)
                }
        }
    }
    
    private var locationPicker: some View {
        Picker("Residencia", selection: $showBenidormShifts) {
            Text(Location.benidorm.rawValue).tag(true)
            Text(Location.denia.rawValue).tag(false)
        }
        .pickerStyle(.segmented)
        .padding(.vertical)
        .padding(.horizontal, 80)
    }
}

#if DEBUG
#Preview {
    ContentView()
        .environment(ViewModel())
}
#endif
