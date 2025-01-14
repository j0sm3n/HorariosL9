//
//  ContentView.swift
//  TurnosL9
//
//  Created by Jose Antonio Mendoza on 23/10/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    @AppStorage("showBenidormShifts") var showBenidormShifts: Bool = true
    let shifts: [Shift]
    
    private var toolbarForegroundColor: Color {
        colorScheme == .dark ? Color.white : Color.black
    }
    
    private var filteredShifts: [Shift] {
        showBenidormShifts
        ? shifts.filter { $0.location == Location.benidorm.rawValue }
        : shifts.filter { $0.location == Location.denia.rawValue }
    }
    
    var body: some View {
        NavigationStack {
            Picker("Residencia", selection: $showBenidormShifts) {
                Text(Location.benidorm.rawValue).tag(true)
                Text(Location.denia.rawValue).tag(false)
            }
            .pickerStyle(.segmented)
            .padding(.vertical)
            .padding(.horizontal, 80)

            ScrollView {
                ForEach(filteredShifts) { shift in
                    NavigationLink {
                        ShiftDetailView(shift: shift)
                    } label: {
                        ShiftRowView(shift: shift)
                    }
                }
                .padding(.horizontal)
            }
            .navigationTitle("Horarios L9")
        }
    }
}

#if DEBUG
#Preview {
    ContentView(shifts: .preview)
}
#endif
