//
//  Trip.swift
//  TurnosL9
//
//  Created by Jose Antonio Mendoza on 29/10/24.
//

import Foundation

struct Trip: Decodable {
    let train: String
    let origin: String
    let destination: String
    let departure: Duration
    let stops: [Stop]
}

extension Trip {
//    static var shift1trips: [Trip] = [
//        .init(train: "9003", origin: .benidorm, destination: .garganes, departure: .init(hour: 6), stops: Stop.train9003stops)
//    ]
}
