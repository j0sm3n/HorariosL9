//
//  LiveActivityManager.swift
//  LiveActivityExtension
//
//  Created by Jose Antonio Mendoza on 2/4/25.
//

import Foundation
import ActivityKit

@Observable
final class LiveActivityManager {
    private var selectedShift: Shift? = nil
    private var activity: Activity<ShiftAttributes>?
    
    func startActivity(with shift: Shift) {
        if ActivityAuthorizationInfo().areActivitiesEnabled {
            selectedShift = shift
            // Attributes
            guard let endHour = shift.end.hour, let endMinute = shift.end.minute else { return }
            let endTime = Calendar.current.date(bySettingHour: endHour, minute: endMinute, second: 0, of: .now)!
            let attributes = ShiftAttributes(shiftName: shift.name, endTime: endTime)
            // State
            let shiftContentState = ShiftAttributes.ContentState(shift: shift)
            // Start activity
            do {
                let activity = try Activity<ShiftAttributes>.request(
                    attributes: attributes,
                    content: .init(state: shiftContentState, staleDate: nil),
                    pushType: nil
                )
                self.activity = activity
                print("Live activity started: \(activity.id)")
            } catch {
                print("Error starting live activity: \(error)")
            }
        }
    }
    
    func updateActivity() {
        guard let activity, let selectedShift, activity.attributes.shiftName == selectedShift.name else { return }
        let shiftContentState = ShiftAttributes.ContentState(shift: selectedShift)
        let alertConfiguration = AlertConfiguration(
            title: "Actualización de turno",
            body: "El nuevo destino es \(selectedShift.destination)",
            sound: .default
        )
        Task {
            await activity.update(.init(state: shiftContentState, staleDate: nil), alertConfiguration: alertConfiguration)
            print("Live activity updated: \(activity.id)")
        }
    }
    
    func stopActivity() {
        guard let activity, let selectedShift else { return }
        let shiftContentState = ShiftAttributes.ContentState(shift: selectedShift)
        Task {
            await activity.end(.init(state: shiftContentState, staleDate: nil), dismissalPolicy: .immediate)
            print("Live activity ended: \(activity.id)")
        }
    }
}
