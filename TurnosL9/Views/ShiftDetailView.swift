//
//  ShiftDetailView.swift
//  TurnosL9
//
//  Created by Jose Antonio Mendoza on 31/10/24.
//

import ActivityKit
import SwiftUI

struct ShiftDetailView: View {
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    @Environment(NotificationManager.self) var notificationManager
    @Binding var shift: Shift
    @State private var errorMessage: String?
    @State private var shouldPresentError: Bool = false
    
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var activity: Activity<JourneyAttributes>?
    @State private var nextUpdate: Date?
    
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
                    Image(systemName: shift.isLiveActivityRegistered ? "stop.circle" : "play.circle")
                        .font(.title2)
                        .symbolEffect(.rotate, value: shift.isLiveActivityRegistered)
                        .sensoryFeedback(.success, trigger: shift.isLiveActivityRegistered)
                }
            }
        }
        .alert(errorMessage ?? "Error", isPresented: $shouldPresentError, actions: {})
        .onReceive(timer) { time in
            if shift.isLiveActivityRegistered {
                print("Time: \(time)")
                if time >= shift.endDate {
                    print("El turno ha terminado el ultimo tren")
                    stopActivity()
                } else if let nextUpdate, time >= nextUpdate {
                    print("La hora actual (\(time.formatted(date: .omitted, time: .shortened))) es mayor o igual que la hora de actualización (\(nextUpdate.formatted(date: .omitted, time: .shortened))), por lo que se va a actualizar la actividad.")
                    updateActivity()
                } else {
                    print(time.formatted(date: .omitted, time: .shortened))
                }
            }
        }
    }
}

#if DEBUG
#Preview {
    @Previewable @State var shift: Shift = .preview
    
    NavigationStack {
        ShiftDetailView(shift: $shift)
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
            print("-- Starting activity --")
            print("End date: \(shift.endDate)")
            print("Next update: \(shift.nextUpdateTimeString)")
            shift.isLiveActivityRegistered = true
            nextUpdate = shift.nextUpdate
            print("Next update: \(shift.nextUpdateTimeString)")
            let journeyAttributes = JourneyAttributes(journeyId: shift.id.uuidString)
            let journeyState = JourneyAttributes.ContentState(
                nextStop: shift.nextStop,
                timeString: shift.nextUpdateTimeString,
                shiftStatus: shift.shiftStatus,
                trainNumber: shift.trainNumber
            )
            self.activity = try LiveActivityManager().startActivity(attributes: journeyAttributes, state: journeyState)
            self.timer = Timer.publish(every: 10.0, on: .main, in: .common).autoconnect()
            scheduleNotifications()
        } catch {
            stopActivity()
            errorMessage = error.localizedDescription
            shouldPresentError = true
        }
    }
    
    private func updateActivity() {
        guard let activity else { return }
        nextUpdate = shift.nextUpdate
        print("Next update: \(nextUpdate, default: "N/A")")
        let journeyState = JourneyAttributes.ContentState(
            nextStop: shift.nextStop,
            timeString: shift.nextUpdateTimeString,
            shiftStatus: shift.shiftStatus,
            trainNumber: shift.trainNumber
        )
        LiveActivityManager().updateActivity(activityID: activity.id, state: journeyState)
    }
    
    private func stopActivity() {
        LiveActivityManager().stopActivity()
        shift.isLiveActivityRegistered = false
        self.activity = nil
        self.nextUpdate = nil
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
