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
    
    var timeToShow: String {
        guard let selectedShift else { return "00:00" }
        switch selectedShift.shiftStatus {
            case .waiting:
                return selectedShift.departure.formatted(date: .omitted, time: .shortened)
            case .working:
                return selectedShift.arrival.formatted(date: .omitted, time: .shortened)
            case .finished:
                return Calendar.current.date(from: selectedShift.end)!.formatted(date: .omitted, time: .shortened)
        }
    }
    
    var staleDate: Date? {
        guard let selectedShift else { return nil }
        var components = Calendar.current.dateComponents([.year, .month, .day], from: .now)
        components.hour = selectedShift.end.hour
        components.minute = selectedShift.end.minute
        return Calendar.current.date(from: components)!
    }
    
//    var shouldUpdateLiveActivity: Bool {
//        guard let activity, let selectedShift else { return false }
//        switch selectedShift.shiftStatus {
//        case .waiting:
//            return selectedShift.nextTrain?.departure >= Date.now
//        case .working:
//            <#code#>
//        case .finished:
//            <#code#>
//        }
//        return true
//    }
    
    func startActivity(with shift: Shift) {
        if ActivityAuthorizationInfo().areActivitiesEnabled {
            guard self.activity == nil else { return }
            selectedShift = shift

            // driving the train
            if let currentTrain = shift.currentTrain {
                let journeyAttributes = JourneyAttributes(journeyId: currentTrain.id.uuidString)
                let journeyContentState = JourneyAttributes.ContentState(
                    currentLocationName: currentTrain.currentStopString,
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
                let journeyAttributes = JourneyAttributes(journeyId: nextTrain.id.uuidString)
                let journeyContentState = JourneyAttributes.ContentState(
                    currentLocationName: nextTrain.origin.monogram,
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
                let journeyAttributes = JourneyAttributes(journeyId: shift.id.uuidString)
                let journeyContentState = JourneyAttributes.ContentState(
                    currentLocationName: "",
                    nextStop: "",
                    timeString: timeToShow,
                    shiftStatus: shift.shiftStatus,
                    trainNumber: 0
                )
                
                do {
                    let activity = try Activity<JourneyAttributes>.request(
                        attributes: journeyAttributes,
                        content: .init(state: journeyContentState, staleDate: staleDate),
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
        let alertConfiguration: AlertConfiguration? = nil

        // driving the train
        if let currentTrain = selectedShift.currentTrain {
            // not in last stop
            if currentTrain.nextStop != nil {
                journeyContentState = JourneyAttributes.ContentState(
                    currentLocationName: currentTrain.currentStopString,
                    nextStop: currentTrain.nextStopString,
                    timeString: timeToShow,
                    shiftStatus: selectedShift.shiftStatus,
                    trainNumber: currentTrain.number
                )
//                alertConfiguration = AlertConfiguration(
//                    title: "Actualización del tren \(currentTrain.number)",
//                    body: "La próxima parada es \(currentTrain.nextStopString)",
//                    sound: .default
//                )
            // train last stop
            } else if currentTrain.nextStop == nil {
                journeyContentState = JourneyAttributes.ContentState(
                    currentLocationName: currentTrain.currentStopString,
                    nextStop: "",
                    timeString: timeToShow,
                    shiftStatus: selectedShift.shiftStatus,
                    trainNumber: currentTrain.number
                )
//                alertConfiguration = AlertConfiguration(
//                    title: "Actualización del tren \(currentTrain.number)",
//                    body: "Última parada",
//                    sound: .default
//                )
            }
        // waiting until next train
        } else if let nextTrain = selectedShift.nextTrain {
            journeyContentState = JourneyAttributes.ContentState(
                currentLocationName: "",
                nextStop: nextTrain.currentStopString,
                timeString: timeToShow,
                shiftStatus: selectedShift.shiftStatus,
                trainNumber: nextTrain.number
            )
//            alertConfiguration = AlertConfiguration(
//                title: "Actualización del próximo tren \(nextTrain.number)",
//                body: "Hora de salida: \(timeToShow)",
//                sound: .default
//            )
        // waiting to finish work
        } else {
            journeyContentState = JourneyAttributes.ContentState(
                currentLocationName: "",
                nextStop: "",
                timeString: timeToShow,
                shiftStatus: selectedShift.shiftStatus,
                trainNumber: 0
            )
        }
            
        if let journeyContentState {
            Task {
                await activity.update(.init(state: journeyContentState, staleDate: staleDate), alertConfiguration: alertConfiguration)
                print("Live activity updated: \(activity.id)")
            }
        }
    }

    func stopActivity() {
        guard let activity, let selectedShift, let currentTrain = selectedShift.currentTrain else { return }
        let journeyContentState = JourneyAttributes.ContentState(
            currentLocationName: currentTrain.currentStopString,
            nextStop: "",
            timeString: timeToShow,
            shiftStatus: selectedShift.shiftStatus,
            trainNumber: currentTrain.number
        )
        Task {
            await activity.end(.init(state: journeyContentState, staleDate: nil), dismissalPolicy: .immediate)
            print("🛑 Live activity ended: \(activity.id)")
            self.activity = nil
            self.selectedShift = nil
        }
    }
}
