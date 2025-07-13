//
//  ShiftListView.swift
//  Horarios L9
//
//  Created by Jose Antonio Mendoza on 12/7/25.
//

import SwiftUI

struct ShiftListView: View {
    @Environment(ViewModel.self) var viewModel
    let shifts: [Shift]

    var body: some View {
        ScrollView {
            ForEach(shifts) { shift in
                NavigationLink {
                    ShiftDetailView(shift: Binding<Shift>(
                        get: { shift },
                        set: { newShift in
                            if let index = viewModel.shifts.firstIndex(where: { $0.id == shift.id }) {
                                viewModel.shifts[index] = newShift
                            }
                        }
                    ))
                } label: {
                    ShiftRowView(shift: shift)
                }

//                NavigationLink(value: shift) {
//                    ShiftRowView(shift: shift)
//                }
            }
            .padding(.horizontal)
        }
    }
}

#if DEBUG
#Preview {
    ShiftListView(shifts: .preview)
}
#endif
