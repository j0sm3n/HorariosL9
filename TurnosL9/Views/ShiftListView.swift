//
//  ShiftListView.swift
//  Horarios L9
//
//  Created by Jose Antonio Mendoza on 12/7/25.
//

import SwiftUI

struct ShiftListView: View {
    let shifts: [Shift]

    var body: some View {
        ScrollView {
            ForEach(shifts) { shift in
                NavigationLink(value: shift) {
                    ShiftRowView(shift: shift)
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    ShiftListView(shifts: .preview)
}
