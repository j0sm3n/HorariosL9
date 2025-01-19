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
    let timeFromOrigin: Int
}

extension Stop: Decodable {
    enum CodingKeys: String, CodingKey {
        case location
        case timeFromOrigin = "time_from_origin"
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.location = try container.decode(Location.self, forKey: .location)
        self.timeFromOrigin = try container.decode(Int.self, forKey: .timeFromOrigin)
    }
}

extension Stop {
    var stopDuration: TimeInterval {
        TimeInterval(minute: timeFromOrigin)
    }
}
