//
//  Stop.swift
//  TurnosL9
//
//  Created by Jose Antonio Mendoza on 29/10/24.
//

import Foundation

struct Stop: Identifiable, Hashable {
    let id: UUID = .init()
    let location: Location
    let departure: DateComponents
}

extension Stop: Codable {
    enum CodingKeys: String, CodingKey {
        case location, departure
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.location = try container.decode(Location.self, forKey: .location)
        let stopDeparture = try container.decode(Time.self, forKey: .departure)
        self.departure = DateComponents(hour: stopDeparture.hour, minute: stopDeparture.minute)
    }
}
