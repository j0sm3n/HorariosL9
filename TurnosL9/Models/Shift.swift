//
//  Shift.swift
//  TurnosL9
//
//  Created by Jose Antonio Mendoza on 23/10/24.
//

import SwiftUI

struct Shift: Hashable, Identifiable {
    let id: UUID = .init()
    var name: String
    var start: TimeInterval
    var duration: TimeInterval
    var saturation: Double?
    var location: String
    var trains: [Train]
    
    var isLiveActivityRegistered: Bool = false
}

extension Shift {
    struct Wrapper: Codable {
        var shifts: [Shift]
    }
}

extension Shift: Codable {
    enum CodingKeys: String, CodingKey {
        case name, duration, saturation, location, trains
        case start = "start_time"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.name = try container.decode(String.self, forKey: .name)
        self.saturation = try container.decodeIfPresent(Double.self, forKey: .saturation)
        self.location = try container.decode(String.self, forKey: .location)
        self.trains = try container.decode([Train].self, forKey: .trains)

        let startTime = try container.decode(Time.self, forKey: .start)
        self.start = TimeInterval(duration: startTime)
        
        let shiftDuration = try container.decode(Time.self, forKey: .duration)
        self.duration = TimeInterval(duration: shiftDuration)
    }
}

extension Shift {
    var end: TimeInterval { start + duration }
    
    var isWorking: Bool {
       let timeSinceStartOfDay = timeSinceStartOfDay()
        return timeSinceStartOfDay >= start && timeSinceStartOfDay < end
    }

    var currentTrain: Train? { trains.first { $0.isRunning } }
    
    var nextTrain: Train? { trains.first { $0.departure > timeSinceStartOfDay() } }
    
    var isRunning: Bool { currentTrain != nil }
    
    var isResting: Bool { !isRunning && nextTrain != nil }
    
    private func timeSinceStartOfDay() -> TimeInterval {
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        return now.timeIntervalSince(startOfDay)
    }
    
    var timeToFinish: TimeInterval {
        guard isWorking else { return 0.0 }
        return end - timeSinceStartOfDay()
    }
}
