//
//  ShiftDetailView.swift
//  TurnosL9
//
//  Created by Jose Antonio Mendoza on 31/10/24.
//

import SwiftUI

struct ShiftDetailView: View {
    @Environment(LocationManager.self) var locationManager
    @State private var activityManager = LiveActivityManager()
    @State private var timer: Timer? = nil
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
        if shift.isLiveActivityRegistered {
            stopActivity()
        } else {
            startActivity()
        }
    }
    
    private func startActivity() {
        shift.isLiveActivityRegistered = true
        activityManager.startActivity(with: shift)
        var components = Calendar.current.dateComponents([.year, .month, .day], from: .now)
        components.hour = shift.end.hour
        components.minute = shift.end.minute
        if let endOfShift = Calendar.current.date(from: components) {
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                if Date.now > endOfShift {
                    stopActivity()
                } else {
                    if let nextUpdate = activityManager.nextUpdate, Date.now >= nextUpdate {
                        activityManager.updateActivity()
                    }
                }
            }
        }
    }
    
    private func stopActivity() {
        activityManager.stopActivity()
        shift.isLiveActivityRegistered = false
        timer?.invalidate()
    }
}

#if DEBUG
#Preview {
    @Previewable @State var shift: Shift = .preview
    
    NavigationStack {
        ShiftDetailView(shift: $shift)
            .environment(LocationManager())
    }
}
#endif
