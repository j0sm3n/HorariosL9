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
        if lhs.minute + rhs.minute >= 60 {
            let hour = lhs.hour + rhs.hour + 1
            return Duration(hour: hour, minute: lhs.minute + rhs.minute - 60)
        } else {
            return Duration(hour: lhs.hour + rhs.hour, minute: lhs.minute + rhs.minute)
        }
    }
    
    static func - (lhs: Duration, rhs: Duration) -> Duration {
        if lhs.minute - rhs.minute < 0 {
            let hour = lhs.hour - rhs.hour - 1
            return Duration(hour: hour, minute: lhs.minute - rhs.minute + 60)
        } else {
            return Duration(hour: lhs.hour - rhs.hour, minute: lhs.minute - rhs.minute)
        }
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
