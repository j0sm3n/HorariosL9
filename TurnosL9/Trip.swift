//
//  Trip.swift
//  TurnosL9
//
//  Created by Jose Antonio Mendoza on 29/10/24.
//

import Foundation

struct Trip: Identifiable {
    let id: UUID = .init()
    let train: String
    let origin: String
    let destination: String
    let departure: Duration
    let stops: [Stop]
}

extension Trip {
    var arrival: Duration {
        departure + stops.last!.duration
    }
    
    var isEven: Bool {
        guard train.isNumeric else { return false }
        return Int(train)!.isMultiple(of: 2)
    }
}

extension Trip: Decodable {
    enum CodingKeys: String, CodingKey {
        case train, origin, destination, departure, stops
    }
}

extension Trip {
//    static var shift1trips: [Trip] = [
//        .init(train: "9003", origin: .benidorm, destination: .garganes, departure: .init(hour: 6), stops: Stop.train9003stops)
//    ]
}
