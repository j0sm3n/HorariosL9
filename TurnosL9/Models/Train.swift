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
    let departure: DateComponents
    let stops: [Stop]
}

extension Train {
    var arrival: DateComponents {
        stops.last!.departure
    }
    
    var duration: TimeInterval {
        let arrivalDate = Calendar.current.date(from: arrival)!
        let departureDate = Calendar.current.date(from: departure)!
        return arrivalDate.timeIntervalSince(departureDate)
    }
    
    private var isEven: Bool { number.isMultiple(of: 2) }
    
    var color: Color {
        Color.gray.opacity(self.isEven ? 0.5 : 0.2)
    }
    
    var currentTime: DateComponents {
        return Calendar.current.dateComponents([.hour, .minute], from: .now)
    }
    
    var isRunning: Bool {
        return departure.isEarlierOrEqual(to: currentTime) && currentTime.isEarlierOrEqual(to: arrival)
    }
    
    var currentStop: Stop? {
        guard isRunning else { return nil }
        
        return stops
            .sorted { $1.departure.isEarlier(than: $0.departure) } // sort in descending order
            .first(where: { $0.departure.isEarlierOrEqual(to: currentTime) })
    }
    
    var currentStopString: String {
        currentStop?.location.monogram ?? ""
    }
    
    var currentStopArrival: DateComponents? {
        departureTime(currentStop)
    }
    
    var currentStopIndex: Int {
        stops.firstIndex(of: currentStop!) ?? 0
    }
    
    var nextStop: Stop? {
        guard let currentStop else { return stops.first }
        let sortedStops = stops.sorted { $0.departure.isEarlier(than: $1.departure) }
        guard sortedStops.last != currentStop else { return nil }
        let currentStopIndex = sortedStops.firstIndex(of: currentStop)!
        return sortedStops[currentStopIndex + 1]
    }
    
    var nextStopString: String {
        nextStop?.location.monogram ?? "No next stop"
    }
    
    var nextStopArrival: DateComponents? {
        departureTime(nextStop)
    }
    
    private func departureTime(_ stop: Stop?) -> DateComponents? {
        guard let stop else { return nil }
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
        self.departure = DateComponents(hour: trainDeparture.hour, minute: trainDeparture.minute)
    }
}

extension Train: Equatable, Hashable {
    public static func == (lhs: Train, rhs: Train) -> Bool {
        return lhs.number == rhs.number
    }
}
