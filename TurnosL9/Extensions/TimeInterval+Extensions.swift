//
//  TimeInterval+Extensions.swift
//  Ccoonecta
//
//  Created by Jose Antonio Mendoza on 1/4/24.
//

import Foundation

extension TimeInterval {
    init(hour: Int, minute: Int = 0) {
        self = TimeInterval((hour * 3600) + (minute * 60))
    }
    
    init(minute: Int) {
        self = TimeInterval(minute * 60)
    }
    
    init(duration: Time) {
        self = TimeInterval(hour: duration.hour, minute: duration.minute)
    }
    
    var positionalTimeString: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: self) ?? ""
    }
}
