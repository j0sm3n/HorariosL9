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
//    static var train9003stops: [Stop] = [
//        .init(location: .intermodal, duration: .init(minute: 2)),
//        .init(location: .camiCoves, duration: .init(minute: 4)),
//        .init(location: .alfaz, duration: .init(minute: 7)),
//        .init(location: .elAlbir, duration: .init(minute: 10)),
//        .init(location: .altea, duration: .init(minute: 15)),
//        .init(location: .garganes, duration: .init(minute: 18)),
//    ]
}
