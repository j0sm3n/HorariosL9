//
//  PreviewData.swift
//  TurnosL9
//
//  Created by Jose Antonio Mendoza on 30/10/24.
//

import Foundation

extension Shift {
    static var preview: Shift {
        [Shift].preview[10]
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

extension Train {
    static var preview: Train {
        Shift.preview.trains[0]
    }
    
    static var previewNextTrain: Train {
        Shift.preview.trains[1]
    }
}

extension Stop {
    static var previewActualStop: Stop {
        Train.preview.stops[2]
    }
    
    static var previewNextStop: Stop {
        Train.preview.stops[3]
    }
}
