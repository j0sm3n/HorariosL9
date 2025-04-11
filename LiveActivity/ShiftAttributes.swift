//
//  ShiftAttributes.swift
//  LiveActivityExtension
//
//  Created by Jose Antonio Mendoza on 31/3/25.
//

import Foundation
import ActivityKit

struct ShiftAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var shiftStatus: ShiftStatus
        var trainNumber: Int?
        var origin: String?
        var destination: String?
        var departureTime: Date?
        var arrivalTime: Date?
        
        init(shift: Shift) {
            self.shiftStatus = shift.shiftStatus
            self.trainNumber = shift.trainNumber
            self.origin = shift.origin
            self.destination = shift.destination
            self.departureTime = shift.departure
            self.arrivalTime = shift.arrival
        }
    }

    // Fixed non-changing properties about your activity go here!
    var shiftName: String
    var endTime: Date
}

enum ShiftStatus: Codable {
    case waiting
    case working
    case finished
}
