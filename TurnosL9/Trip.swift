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
    
    var duration: Duration {
        arrival - departure
    }
    
    var isEven: Bool {
        guard train.isNumeric else { return false }
        return Int(train)!.isMultiple(of: 2)
    }
    
    private var currentTime: TimeInterval {
        let components = Calendar.current.dateComponents([.hour, .minute], from: .now)
        return TimeInterval(hour: components.hour!, minute: components.minute!)
    }
    
    var isRunning: Bool {
        return currentTime >= TimeInterval(duration: departure) && currentTime <= TimeInterval(duration: arrival)
    }
    
    var tripIndicatorPosition: Double {
        guard isRunning else { return 0.0 }
        let position = 60.0 * ((currentTime - TimeInterval(duration: departure)) / TimeInterval(duration: duration))
        return position
    }
}

extension Trip: Decodable {
    enum CodingKeys: String, CodingKey {
        case train, origin, destination, departure, stops
    }
}
