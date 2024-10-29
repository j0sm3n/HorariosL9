//
//  Trip.swift
//  TurnosL9
//
//  Created by Jose Antonio Mendoza on 29/10/24.
//

import Foundation

struct Trip {
    let train: String
    let origin: Location
    let destination: Location
    let departure: TimeInterval
    let stops: [Stop]
}
