//
//  DateComponents+Extensions.swift
//  Horarios L9
//
//  Created by Jose Antonio Mendoza on 30/3/25.
//

import Foundation

extension DateComponents {
    static var currentTime: DateComponents {
        return Calendar.current.dateComponents([.hour, .minute], from: .now)
    }
    
    var inSeconds: Double {
        guard let hour, let minute else { return 0 }
        return (Double(hour) * 3600.0) + (Double(minute) * 60.0)
    }
    
    var formattedTime: String {
        return String(format: "%02d:%02d", hour ?? 0, minute ?? 0)
    }
    
    func isEarlier(than other: DateComponents) -> Bool {
        return Calendar.current.date(from: self)! < Calendar.current.date(from: other)!
    }
    
    func isEarlierOrEqual(to other: DateComponents) -> Bool {
        return Calendar.current.date(from: self)! <= Calendar.current.date(from: other)!
    }
    
    func minutesBetween(to other: DateComponents) -> Int {
        let date1 = Calendar.current.date(from: self)!
        let date2 = Calendar.current.date(from: other)!
        let components = Calendar.current.dateComponents([.minute], from: date1, to: date2)
        return components.minute ?? 0
    }
    
    func minus(_ quantity: Int, component: Calendar.Component) -> DateComponents {
        let calendar = Calendar.current
        guard let baseDate = calendar.date(from: self) else { return self }
        guard let newDate = calendar.date(byAdding: component, value: -quantity, to: baseDate) else { return self }
        print("Fecha original: \(baseDate)")
        print("5 minutos antes: \(newDate)")
        return calendar.dateComponents([.year, .month, .day, .hour, .minute], from: newDate)
    }
}
