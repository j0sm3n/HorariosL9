//
//  JourneyAttributes.swift
//  LiveActivityExtension
//
//  Created by Jose Antonio Mendoza on 14/5/25.
//

import ActivityKit

struct JourneyAttributes: ActivityAttributes {
    struct ContentState: Codable, Hashable {
        var nextStop: String
        var timeString: String
        var shiftStatus: ShiftStatus
        var trainNumber: Int
    }
    
    var journeyId: String
}
