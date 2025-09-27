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
}
