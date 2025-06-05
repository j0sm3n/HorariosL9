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
    private var activity: Activity<JourneyAttributes>?
    var nextUpdate: Date?
    
    var timeToShow: String {
        guard let nextUpdate else { return "00:00" }
        return nextUpdate.formatted(date: .omitted, time: .shortened)
    }
    
    func startActivity(with shift: Shift) {
        if ActivityAuthorizationInfo().areActivitiesEnabled {
            self.activity = nil
            self.selectedShift = shift

            // driving the train
            if let currentTrain = shift.currentTrain {
                nextUpdate = shift.arrival
                let journeyAttributes = JourneyAttributes(journeyId: currentTrain.id.uuidString)
                let journeyContentState = JourneyAttributes.ContentState(
                    nextStop: currentTrain.nextStop != nil ? currentTrain.nextStopString : "",
                    timeString: timeToShow,
                    shiftStatus: shift.shiftStatus,
                    trainNumber: currentTrain.number
                )
                
                do {
                    let activity = try Activity<JourneyAttributes>.request(
                        attributes: journeyAttributes,
                        content: .init(state: journeyContentState, staleDate: nil),
                        pushType: nil
                    )
                    self.activity = activity
                    print("Live activity started: \(activity.id)")
                } catch {
                    print("Error starting live activity: \(error)")
                }
            // waiting until next train
            } else if let nextTrain = shift.nextTrain {
                nextUpdate = shift.departure
                let journeyAttributes = JourneyAttributes(journeyId: nextTrain.id.uuidString)
                let journeyContentState = JourneyAttributes.ContentState(
                    nextStop: "",
                    timeString: timeToShow,
                    shiftStatus: shift.shiftStatus,
                    trainNumber: nextTrain.number
                )
                
                do {
                    let activity = try Activity<JourneyAttributes>.request(
                        attributes: journeyAttributes,
                        content: .init(state: journeyContentState, staleDate: nil),
                        pushType: nil
                    )
                    self.activity = activity
                    print("Live activity started: \(activity.id)")
                } catch {
                    print("Error starting live activity: \(error)")
                }
            // waiting to finish
            } else {
                nextUpdate = shift.endDate
                let journeyAttributes = JourneyAttributes(journeyId: shift.id.uuidString)
                let journeyContentState = JourneyAttributes.ContentState(
                    nextStop: "",
                    timeString: timeToShow,
                    shiftStatus: shift.shiftStatus,
                    trainNumber: 0
                )
                
                do {
                    let activity = try Activity<JourneyAttributes>.request(
                        attributes: journeyAttributes,
                        content: .init(state: journeyContentState, staleDate: nil),
                        pushType: nil
                    )
                    self.activity = activity
                    print("Live activity started: \(activity.id)")
                } catch {
                    print("Error starting live activity: \(error)")
                }
            }
        }
    }
    
    func updateActivity() {
        guard let activity, let selectedShift else { return }
        
        var journeyContentState: JourneyAttributes.ContentState? = nil

        // driving the train
        if let currentTrain = selectedShift.currentTrain {
            nextUpdate = selectedShift.arrival
            // not in last stop
            if currentTrain.nextStop != nil {
                journeyContentState = JourneyAttributes.ContentState(
                    nextStop: currentTrain.nextStopString,
                    timeString: timeToShow,
                    shiftStatus: selectedShift.shiftStatus,
                    trainNumber: currentTrain.number
                )
            }
        // waiting until next train
        } else if let nextTrain = selectedShift.nextTrain {
            nextUpdate = selectedShift.departure
            journeyContentState = JourneyAttributes.ContentState(
                nextStop: nextTrain.currentStopString,
                timeString: timeToShow,
                shiftStatus: selectedShift.shiftStatus,
                trainNumber: nextTrain.number
            )
        // waiting to finish work
        } else {
            nextUpdate = selectedShift.endDate
            journeyContentState = JourneyAttributes.ContentState(
                nextStop: "",
                timeString: timeToShow,
                shiftStatus: selectedShift.shiftStatus,
                trainNumber: 0
            )
        }
            
        if let journeyContentState {
            Task {
                let alertConfiguration = AlertConfiguration(title: "Turno actualizado", body: "Se ha actualizado el estadu del turno", sound: .default)
                await activity.update(.init(state: journeyContentState, staleDate: nil), alertConfiguration: alertConfiguration)
                print("Live activity updated: \(activity.id)")
            }
        }
    }

    func stopActivity() {
        let journeyContentState = JourneyAttributes.ContentState(
            nextStop: "",
            timeString: selectedShift != nil ? "Finalizado turno \(selectedShift!.name)" : "Turno finalizado",
            shiftStatus: .finished,
            trainNumber: 0
        )
        Task {
            let oneMinuteLater = Date().addingTimeInterval(60)
            await activity?.end(.init(state: journeyContentState, staleDate: nil), dismissalPolicy: .after(oneMinuteLater))
            print("🛑 Live activity ended: \(activity?.id ?? "unknown")")
            self.activity = nil
            self.selectedShift = nil
        }
    }
}
