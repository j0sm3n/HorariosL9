//
//  LiveActivityManager.swift
//  LiveActivityExtension
//
//  Created by Jose Antonio Mendoza on 2/4/25.
//

import Foundation
import ActivityKit

enum LiveActivityError: Error {
    case notWorking
}

extension LiveActivityError: LocalizedError {
    public var errorDescription: String? {
        switch self {
            case .notWorking:
                return NSLocalizedString("El turno seleccionado está fuera de horario de trabajo.", comment: "Selected shift is not working")
        }
    }
}

@Observable
final class LiveActivityManager {
    var nextUpdate: Date?
    private var updateTimer: Timer?

    var timeToShow: String {
        guard let nextUpdate else { return "00:00" }
        return nextUpdate.formatted(date: .omitted, time: .shortened)
    }

    func startActivity(attributes: JourneyAttributes, state: JourneyAttributes.ContentState) throws -> Activity<JourneyAttributes>? {
        var activity: Activity<JourneyAttributes>?
        
        if ActivityAuthorizationInfo().areActivitiesEnabled {
            do {
                activity = try Activity<JourneyAttributes>.request(
                    attributes: attributes,
                    content: .init(state: state, staleDate: nil),
                    pushType: nil
                )
                print("🚂 Live activity started: \(activity?.id, default: "No Activity ID")")
            } catch {
                print("Error starting live activity: \(error)")
            }
        }
        
        return activity
    }

    func updateActivity(activityID: String, state: JourneyAttributes.ContentState) {
        Task {
            let alertConfiguration = AlertConfiguration(title: "Turno actualizado", body: "Se ha actualizado el estado del turno", sound: .default)
            if let activity = Activity<JourneyAttributes>.activities.first(where: { $0.id == activityID }) {
                await activity.update(.init(state: state, staleDate: nil), alertConfiguration: alertConfiguration)
                print("Live activity updated: \(activity.id)")
            } else {
                print("No activity found with ID: \(activityID)")
            }
        }
    }

    func stopActivity() {
        let journeyContentState = JourneyAttributes.ContentState(
            nextStop: "",
            timeString: "Turno finalizado",
            shiftStatus: .finished,
            trainNumber: 0
        )
        Task {
            for activity in Activity<JourneyAttributes>.activities {
                await activity.end(.init(state: journeyContentState, staleDate: nil), dismissalPolicy: .immediate)
                print("🛑 Live activity ended: \(activity.id)")
            }
        }
    }
}
