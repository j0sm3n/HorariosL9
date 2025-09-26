//
//  ShiftListView.swift
//  Horarios L9
//
//  Created by Jose Antonio Mendoza on 12/7/25.
//

import SwiftUI

struct ShiftListView: View {
    @Environment(ViewModel.self) var viewModel

    var body: some View {
        ScrollView {
            ForEach(viewModel.selectedShifts) { shift in
                NavigationLink(value: shift.id) {
                    ShiftRowView(shift: shift)
                }
            }
            .padding(.horizontal)
            .animation(.easeInOut, value: viewModel.selectedShiftsLocation)
        }
    }
}

#if DEBUG
#Preview {
    ShiftListView()
        .environment(ViewModel())
}
#endif
