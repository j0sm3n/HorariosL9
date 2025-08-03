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
                NavigationLink(value: shift.id) {
                    ShiftRowView(shift: shift)
                }
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
