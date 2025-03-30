//
//  Train.swift
//  TurnosL9
//
//  Created by Jose Antonio Mendoza on 29/10/24.
//

import SwiftUI

struct Train: Identifiable {
    let id: UUID = .init()
    let number: Int
    let origin: Location
    let destination: Location
    let departure: TimeInterval
    let stops: [Stop]
}

extension Train {
    var arrival: TimeInterval {
        stops.last!.departure
    }
    
    var duration: TimeInterval {
        arrival - departure
    }
    
    private var isEven: Bool { number.isMultiple(of: 2) }
    
    var color: Color {
        Color.gray.opacity(self.isEven ? 0.5 : 0.2)
    }
    
    var currentTime: TimeInterval {
        let components = Calendar.current.dateComponents([.hour, .minute], from: .now)
        return TimeInterval(hour: components.hour!, minute: components.minute!)
    }
    
    var isRunning: Bool {
        return currentTime >= departure && currentTime <= arrival
    }
    
    var indicatorPosition: Double {
        guard isRunning else { return 0.0 }
        let position = 60.0 * ((currentTime - departure) / duration)
        return position
    }
    
    var currentStop: Stop? {
        guard isRunning else { return nil }
        
        return stops
            .sorted { $0.departure > $1.departure } // sort in descending order
            .first(where: { $0.departure <= departure })
    }
    
    var currentStopString: String {
        currentStop?.location.monogram ?? "No current stop"
    }
    
    var currentStopArrival: TimeInterval {
        departureTime(currentStop)
    }
    
    var nextStop: Stop? {
        guard let currentStop else { return stops.first }
        let sortedStops = stops.sorted { $0.departure < $1.departure }
        guard sortedStops.last != currentStop else { return nil }
        let currentStopIndex = sortedStops.firstIndex(of: currentStop)!
        return sortedStops[currentStopIndex + 1]
    }
    
    var nextStopString: String {
        nextStop?.location.monogram ?? "No next stop"
    }
    
    var nextStopArrival: TimeInterval {
        departureTime(nextStop)
    }
    
    private func departureTime(_ stop: Stop?) -> TimeInterval {
        guard let stop else { return 0.0 }
        return stop.departure
    }
}

extension Train: Codable {
    enum CodingKeys: String, CodingKey {
        case number, origin, destination, departure, stops
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.number = try container.decode(Int.self, forKey: .number)
        self.origin = try container.decode(Location.self, forKey: .origin)
        self.destination = try container.decode(Location.self, forKey: .destination)
        self.stops = try container.decode([Stop].self, forKey: .stops)
        
        let trainDeparture = try container.decode(Time.self, forKey: .departure)
        self.departure = TimeInterval(duration: trainDeparture)
    }
}

extension Train: Equatable, Hashable {
    public static func == (lhs: Train, rhs: Train) -> Bool {
        return lhs.number == rhs.number
    }
}
