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
        var trainNumber: String?
        var origin: String?
        var destination: String?
        var departureTime: Date?
        var arrivalTime: Date?
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
