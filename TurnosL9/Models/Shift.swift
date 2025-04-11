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
    var start: DateComponents
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
        self.start = DateComponents(hour: startTime.hour, minute: startTime.minute)
        
        let shiftDuration = try container.decode(Time.self, forKey: .duration)
        self.duration = TimeInterval(duration: shiftDuration)
    }
}

extension Shift {
    var end: DateComponents {
        let startDate = Calendar.current.date(from: start)!
        let endDate = startDate.addingTimeInterval(duration)
        return Calendar.current.dateComponents([.hour, .minute], from: endDate)
    }
    
    // TODO: Think about whether the following variables are necessary
    var isWorking: Bool {
        start.isEarlierOrEqual(to: currentTime) && currentTime.isEarlier(than: end)
    }

    var currentTrain: Train? { trains.first { $0.isRunning } }
    
    var nextTrain: Train? { trains.first { currentTime.isEarlier(than: $0.departure) } }
    
    var isRunning: Bool { currentTrain != nil }
    
    var isResting: Bool { !isRunning && nextTrain != nil }
    
    var currentTime: DateComponents {
        return Calendar.current.dateComponents([.hour, .minute], from: .now)
    }
    // -----------------------
    
    var shiftStatus: ShiftStatus {
        if isWorking && isRunning {
            return .working
        } else if isWorking && isResting {
            return .waiting
        } else {
            return .finished
        }
    }
    
    var trainNumber: Int {
        switch shiftStatus {
        case .working:
            return currentTrain!.number
        case .waiting:
            return nextTrain!.number
        case .finished:
            return 0
        }
    }
    
    var origin: String {
        switch shiftStatus {
        case .working:
            return currentTrain!.currentStopString
        case .waiting:
            return nextTrain!.origin.monogram
        case .finished:
            return ""
        }
    }
    
    var destination: String {
        switch shiftStatus {
        case .working:
            return currentTrain!.nextStopString
        case .waiting:
            return nextTrain!.destination.monogram
        case .finished:
            return ""
        }
    }
    
    var departure: Date {
        let now = Date()
        let calendar = Calendar.current
        switch shiftStatus {
        case .waiting:
            let departureComponents = nextTrain!.departure
            return calendar.date(bySettingHour: departureComponents.hour!, minute: departureComponents.minute!, second: 0, of: now)!
        case .working:
            let departureComponents = currentTrain!.currentStop!.departure
            return calendar.date(bySettingHour: departureComponents.hour!, minute: departureComponents.minute!, second: 0, of: now)!
        case .finished:
            return now
        }
    }
    
    var arrival: Date {
        let now = Date()
        let calendar = Calendar.current
        switch shiftStatus {
        case .waiting:
            let arrivalComponents = nextTrain!.arrival
            return calendar.date(bySettingHour: arrivalComponents.hour!, minute: arrivalComponents.minute!, second: 0, of: now)!
        case .working:
            let arrivalComponents = currentTrain!.nextStop!.departure
            return calendar.date(bySettingHour: arrivalComponents.hour!, minute: arrivalComponents.minute!, second: 0, of: now)!
        case .finished:
            return now
        }
    }
}
