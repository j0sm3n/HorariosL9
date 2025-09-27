//
//  ShiftListView.swift
//  TurnosL9WatchOS Watch App
//
//  Created by Jose Antonio Mendoza on 27/9/25.
//

import SwiftUI

struct ShiftListView: View {
    @Environment(ShiftStore.self) var store
    @Binding var selectedShiftId: UUID?

    var body: some View {
        List(store.selectedShifts, selection: $selectedShiftId) { shift in
            ShiftRowView(shift: shift)
        }
        .navigationTitle("Horarios L9")
        .toolbar {
            ToolbarItem(placement: .automatic) {
                Button {
                    store.toggleShiftsLocation()
                } label: {
                    Text(store.selectedShiftsLocation == .benidorm ? "Benidorm" : "Denia")
                        .foregroundStyle(.black)
                }
                .tint(Color.row)
            }
        }
    }
}

#Preview {
    @Previewable @State var selectedShiftId: UUID? = Shift.preview.id
    ShiftListView(selectedShiftId: $selectedShiftId)
        .environment(ShiftStore())
}
