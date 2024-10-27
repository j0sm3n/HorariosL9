//
//  ContentView.swift
//  TurnosL9
//
//  Created by Jose Antonio Mendoza on 23/10/24.
//

import SwiftUI

struct ContentView: View {
    let shifts: [Shift] = Shift.shifts
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(shifts) { shift in
                    NavigationLink {
                        Image(shift.imageName)
                            .resizable()
                            .scaledToFit()
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

#Preview {
    ContentView()
}
