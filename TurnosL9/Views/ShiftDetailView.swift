//
//  ShiftDetailView.swift
//  TurnosL9
//
//  Created by Jose Antonio Mendoza on 31/10/24.
//

import SwiftUI

struct ShiftDetailView: View {
    @State private var activityManager = LiveActivityManager()
    @Binding var shift: Shift
    
    var body: some View {
        ScrollView {
            Section {
                ForEach(shift.trains) { train in
                    NavigationLink {
                        TrainDetailView(train: train)
                    } label: {
                        TrainRowView(train: train, color: train.color, showIndicator: true)
                    }
                }
            } header: {
                ShiftRowView(shift: shift)
            }
            .padding(.horizontal)
        }
        .contentMargins([.top, .bottom], 40)
        .overlay {
            if shift.trains.isEmpty {
                ContentUnavailableView("Reserva y Maniobras", systemImage: "exclamationmark.triangle.fill")
            }
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    changeActivityStatus()
                } label: {
                    Image(systemName: shift.isLiveActivityRegistered ? "stop.circle" : "play.circle")
                        .font(.title2)
                        .symbolEffect(.rotate, value: shift.isLiveActivityRegistered)
                        .sensoryFeedback(.success, trigger: shift.isLiveActivityRegistered)
                }
            }
        }
    }
    
    private func changeActivityStatus() {
        Task {
            if shift.isLiveActivityRegistered {
                activityManager.stopActivity()
                shift.isLiveActivityRegistered = false
            } else {
                activityManager.startActivity(with: shift)
                shift.isLiveActivityRegistered = true
            }
        }
    }
}

#if DEBUG
#Preview {
    @Previewable @State var shift: Shift = .preview
    
    NavigationStack {
        ShiftDetailView(shift: $shift)
    }
}
#endif
