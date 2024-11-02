//
//  ContentView.swift
//  TurnosL9
//
//  Created by Jose Antonio Mendoza on 23/10/24.
//

import SwiftUI

struct ContentView: View {
    let shifts: [Shift]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(shifts) { shift in
                    NavigationLink {
                        ShiftDetailView(shift: shift)
                    } label: {
                        ShiftRowView(shift: shift)
                    }
                }
                .padding(.horizontal)
                .navigationTitle("Turnos L9")
            }
            .contentMargins([.top, .bottom], 40)
        }
    }
}

#if DEBUG
#Preview {
    ContentView(shifts: .preview)
}
#endif
