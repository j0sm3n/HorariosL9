//
//  ShiftListView.swift
//  Horarios L9
//
//  Created by Jose Antonio Mendoza on 12/7/25.
//

import SwiftUI

struct ShiftListView: View {
    @Environment(ShiftStore.self) var store

    var body: some View {
        ScrollView {
            ForEach(store.selectedShifts) { shift in
                NavigationLink(value: shift.id) {
                    ShiftRowView(shift: shift)
                }
            }
            .padding(.horizontal)
            .animation(.easeInOut, value: store.selectedShiftsLocation)
        }
    }
}

#if DEBUG
#Preview {
    ShiftListView()
        .environment(ShiftStore())
}
#endif
