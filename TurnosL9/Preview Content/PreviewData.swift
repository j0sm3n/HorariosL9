//
//  PreviewData.swift
//  TurnosL9
//
//  Created by Jose Antonio Mendoza on 30/10/24.
//

import Foundation

extension Shift {
    static var preview: Shift {
        [Shift].preview[0]
    }
    
    static var reserva: Shift {
        [Shift].preview[4]
    }
}

extension [Shift] {
    static var preview: [Shift] {
        let url = Bundle.main.url(forResource: "shifts", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let wrapper = try! JSONDecoder().decode(Shift.Wrapper.self, from: data)
        return wrapper.shifts
    }
}

extension Trip {
    static var preview: Trip {
        Shift.preview.trips[0]
    }
}
