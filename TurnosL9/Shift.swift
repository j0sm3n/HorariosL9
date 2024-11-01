//
//  Shift.swift
//  TurnosL9
//
//  Created by Jose Antonio Mendoza on 23/10/24.
//

import SwiftUI

struct Duration: Decodable {
    let hour: Int
    let minute: Int
}

extension Duration {
    var timeString: String {
        TimeInterval(duration: self).positionalTimeString
    }
    
    static func + (lhs: Duration, rhs: Duration) -> Duration {
        Duration(hour: lhs.hour + rhs.hour, minute: lhs.minute + rhs.minute)
    }
}

struct Shift: Identifiable {
    let id: UUID = .init()
    let name: String
    let startTime: Duration
    let duration: Duration
    var saturation: Double?
    let location: String
    let trips: [Trip]
    
    var shiftStart: TimeInterval {
        TimeInterval(duration: startTime)
    }
    
    var shiftEnd: TimeInterval {
        TimeInterval(duration: startTime) + TimeInterval(duration: duration)
    }
    
    var shiftDuration: TimeInterval {
        TimeInterval(duration: duration)
    }
    
    var imageName: String {
        location + "-" + name
    }
}

extension Shift {
    struct Wrapper: Decodable {
        let shifts: [Shift]
    }
}

extension Shift: Decodable {
    enum CodingKeys: String, CodingKey {
        case name, duration, saturation, location, trips
        case startTime = "start_time"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.duration = try container.decode(Duration.self, forKey: .duration)
        self.saturation = try container.decodeIfPresent(Double.self, forKey: .saturation)
        self.location = try container.decode(String.self, forKey: .location)
        self.trips = try container.decode([Trip].self, forKey: .trips)
        self.startTime = try container.decode(Duration.self, forKey: .startTime)
    }
}

extension Shift {
//    static let shifts: [Shift] = [
//        Shift(name: "1", startTime: TimeInterval(hour: 5, minute: 20), duration: TimeInterval(hour: 8, minute: 34), saturation: 41.87, location: .benidorm, trips: Trip.shift1trips),
//        Shift(name: "2", startTime: TimeInterval(hour: 6, minute: 20), duration: TimeInterval(hour: 8, minute: 34), saturation: 41.87, location: .benidorm, trips: []),
//        Shift(name: "3", startTime: TimeInterval(hour: 13, minute: 45), duration: TimeInterval(hour: 9, minute: 8), saturation: 44.02, location: .benidorm, trips: []),
//        Shift(name: "4", startTime: TimeInterval(hour: 14, minute: 45), duration: TimeInterval(hour: 8, minute: 31), saturation: 42.76, location: .benidorm, trips: []),
//        Shift(name: "8", startTime: TimeInterval(hour: 5, minute: 45), duration: TimeInterval(hour: 6, minute: 55), saturation: 40.90, location: .benidorm, trips: []),
//        Shift(name: "9", startTime: TimeInterval(hour: 13, minute: 35), duration: TimeInterval(hour: 6, minute: 55), saturation: 40.90, location: .benidorm, trips: []),
//        Shift(name: "21", startTime: TimeInterval(hour: 5, minute: 5), duration: TimeInterval(hour: 6, minute: 52), saturation: 64.03, location: .denia, trips: []),
//        Shift(name: "22", startTime: TimeInterval(hour: 5, minute: 20), duration: TimeInterval(hour: 7, minute: 37), saturation: 66.26, location: .denia, trips: []),
//        Shift(name: "23", startTime: TimeInterval(hour: 8, minute: 35), duration: TimeInterval(hour: 7, minute: 22), saturation: 66.26, location: .denia, trips: []),
//        Shift(name: "24", startTime: TimeInterval(hour: 12, minute: 35), duration: TimeInterval(hour: 7, minute: 22), saturation: 66.26, location: .denia, trips: []),
//        Shift(name: "25", startTime: TimeInterval(hour: 15, minute: 35), duration: TimeInterval(hour: 7, minute: 22), saturation: 66.26, location: .denia, trips: []),
//        Shift(name: "26", startTime: TimeInterval(hour: 16, minute: 35), duration: TimeInterval(hour: 6, minute: 36), saturation: 63.93, location: .denia, trips: []),
//        Shift(name: "27", startTime: TimeInterval(hour: 5, minute: 5), duration: TimeInterval(hour: 8, minute: 30), saturation: 65.50, location: .denia, trips: []),
//        Shift(name: "28", startTime: TimeInterval(hour: 13, minute: 30), duration: TimeInterval(hour: 8, minute: 30), saturation: 65.50, location: .denia, trips: [])
//    ]
}
