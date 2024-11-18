//
//  Stop.swift
//  TurnosL9
//
//  Created by Jose Antonio Mendoza on 29/10/24.
//

import Foundation

struct Stop: Identifiable {
    let id: UUID = .init()
    let location: Location
    let duration: Duration
}

extension Stop: Decodable {
    enum CodingKeys: CodingKey {
        case location, duration
    }
}

extension Stop {
    var stopDuration: TimeInterval {
        TimeInterval(duration: duration)
    }
}
