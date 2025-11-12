//
//  ShiftDetailView.swift
//  TurnosL9
//
//  Created by Jose Antonio Mendoza on 31/10/24.
//

import SwiftUI

struct ShiftDetailView: View {
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    @Environment(LiveActivityManager.self) var activityManager
    @Environment(NotificationManager.self) var notificationManager
    @Binding var shift: Shift
    @State private var errorMessage: String?
    @State private var shouldPresentError: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            headerView
            TrainListView(trains: shift.trains)
        }
        .contentMargins(.top, 30)
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
                    Image(systemName: activityManager.selectedShift != nil ? "stop.circle" : "play.circle")
                        .font(.title2)
                        .symbolEffect(.rotate, value: shift.isLiveActivityRegistered)
                        .sensoryFeedback(.success, trigger: shift.isLiveActivityRegistered)
                }
            }
        }
        .alert(errorMessage ?? "Error", isPresented: $shouldPresentError, actions: {})
    }
}

#if DEBUG
#Preview {
    @Previewable @State var shift: Shift = .preview
    
    NavigationStack {
        ShiftDetailView(shift: $shift)
            .environment(LiveActivityManager())
            .environment(NotificationManager())
    }
}
#endif

extension ShiftDetailView {
    // MARK: - Private views
    @ViewBuilder
    private var headerView: some View {
        VStack {
            Text(shift.name)
                .font(.largeTitle)
                .rowTitleStyle(bold: true)
            
            if dynamicTypeSize < .xxLarge {
                HStack(spacing: 16) {
                    VStack(alignment: .leading) {
                        LabeledContent("Inicio") {
                            Text(shift.start.formattedTime)
                                .monospacedStyle()
                        }
                        LabeledContent("Fin") {
                            Text(shift.end.formattedTime)
                                .monospacedStyle()
                        }
                    }
                    .font(.callout)
                    
                    VStack(alignment: .leading) {
                        LabeledContent("Jornada") {
                            Text(shift.duration.positionalTimeString)
                                .monospacedStyle()
                        }
                        if let saturation = shift.saturation {
                            LabeledContent("Saturación") {
                                Text("\(saturation.formatted()) %")
                                    .monospacedStyle()
                            }
                        }
                    }
                    .font(.callout)
                }
            } else {
                VStack {
                    LabeledContent("Inicio") {
                        Text(shift.start.formattedTime)
                            .monospacedStyle()
                    }
                    LabeledContent("Fin") {
                        Text(shift.end.formattedTime)
                            .monospacedStyle()
                    }
                    LabeledContent("Jornada") {
                        Text(shift.duration.positionalTimeString)
                            .monospacedStyle()
                    }
                    if let saturation = shift.saturation {
                        LabeledContent("Saturación") {
                            Text("\(saturation.formatted()) %")
                                .monospacedStyle()
                        }
                    }
                }
                .font(.callout)
            }
        }
        .padding()
        .background(Color.row)
    }
    
    // MARK: - Private functions
    private func changeActivityStatus() {
        if shift.isLiveActivityRegistered {
            stopActivity()
        } else {
            startActivity()
        }
    }
    
    private func startActivity() {
        do {
            shift.isLiveActivityRegistered = true
            activityManager.selectedShift = shift
            try activityManager.startActivity(with: shift)
        } catch {
            stopActivity()
            errorMessage = error.localizedDescription
            shouldPresentError = true
        }
    }
    
    private func stopActivity() {
        activityManager.stopActivity()
        shift.isLiveActivityRegistered = false
        activityManager.selectedShift = nil
        notificationManager.clearRequests()
    }
    
    private func scheduleNotifications() {
        Task {
            try? await notificationManager.requestAuthorization()
            notificationManager.clearRequests()
            notificationManager.scheduleNotification(for: shift.getRestDates())
        }
    }
}
