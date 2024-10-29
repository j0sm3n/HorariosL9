//
//  Shift.swift
//  TurnosL9
//
//  Created by Jose Antonio Mendoza on 23/10/24.
//

import SwiftUI

struct Shift: Identifiable {
    let id: UUID = .init()
    let name: String
    let startTime: TimeInterval
    let duration: TimeInterval
    var saturation: Double?
    let location: Location
    let trips: [Trip]
    
    
    var endTime: TimeInterval {
        startTime + duration
    }
    
    var imageName: String {
        location.rawValue + "-" + name
    }
}

extension Shift {
    static let shifts: [Shift] = [
        Shift(name: "1", startTime: TimeInterval(hour: 5, minute: 20), duration: TimeInterval(hour: 8, minute: 34), saturation: 41.87, location: .benidorm, trips: []),
        Shift(name: "2", startTime: TimeInterval(hour: 6, minute: 20), duration: TimeInterval(hour: 8, minute: 34), saturation: 41.87, location: .benidorm, trips: []),
        Shift(name: "3", startTime: TimeInterval(hour: 13, minute: 45), duration: TimeInterval(hour: 9, minute: 8), saturation: 44.02, location: .benidorm, trips: []),
        Shift(name: "4", startTime: TimeInterval(hour: 14, minute: 45), duration: TimeInterval(hour: 8, minute: 31), saturation: 42.76, location: .benidorm, trips: []),
        Shift(name: "8", startTime: TimeInterval(hour: 5, minute: 45), duration: TimeInterval(hour: 6, minute: 55), saturation: 40.90, location: .benidorm, trips: []),
        Shift(name: "9", startTime: TimeInterval(hour: 13, minute: 35), duration: TimeInterval(hour: 6, minute: 55), saturation: 40.90, location: .benidorm, trips: []),
        Shift(name: "21", startTime: TimeInterval(hour: 5, minute: 5), duration: TimeInterval(hour: 6, minute: 52), saturation: 64.03, location: .denia, trips: []),
        Shift(name: "22", startTime: TimeInterval(hour: 5, minute: 20), duration: TimeInterval(hour: 7, minute: 37), saturation: 66.26, location: .denia, trips: []),
        Shift(name: "23", startTime: TimeInterval(hour: 8, minute: 35), duration: TimeInterval(hour: 7, minute: 22), saturation: 66.26, location: .denia, trips: []),
        Shift(name: "24", startTime: TimeInterval(hour: 12, minute: 35), duration: TimeInterval(hour: 7, minute: 22), saturation: 66.26, location: .denia, trips: []),
        Shift(name: "25", startTime: TimeInterval(hour: 15, minute: 35), duration: TimeInterval(hour: 7, minute: 22), saturation: 66.26, location: .denia, trips: []),
        Shift(name: "26", startTime: TimeInterval(hour: 16, minute: 35), duration: TimeInterval(hour: 6, minute: 36), saturation: 63.93, location: .denia, trips: []),
        Shift(name: "27", startTime: TimeInterval(hour: 5, minute: 5), duration: TimeInterval(hour: 8, minute: 30), saturation: 65.50, location: .denia, trips: []),
        Shift(name: "28", startTime: TimeInterval(hour: 13, minute: 30), duration: TimeInterval(hour: 8, minute: 30), saturation: 65.50, location: .denia, trips: [])
    ]
}
