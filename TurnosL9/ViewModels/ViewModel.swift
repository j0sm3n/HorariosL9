//
//  ViewModel.swift
//  TurnosL9
//
//  Created by Jose Antonio Mendoza on 2/11/24.
//

import Foundation

@Observable
final class ViewModel {
    var shifts: [Shift] = []
    
    private let defaults = UserDefaults.standard
    private let selectedShiftsLocationKey = "selectedShiftsLocationKey"
    
    var selectedShiftsLocation: Location {
        get {
            access(keyPath: \.selectedShiftsLocation)
            guard let locationString = defaults.string(forKey: selectedShiftsLocationKey),
                  let location = Location(rawValue: locationString) else {
                return .benidorm
            }
            return location
        }
        
        set {
            withMutation(keyPath: \.selectedShiftsLocation) {
                defaults.set(newValue.rawValue, forKey: selectedShiftsLocationKey)
            }
        }
    }
    
    var selectedShifts: [Shift] {
        shifts.filter { $0.location == selectedShiftsLocation }
    }
    
    init() {
        self.fetchShifts()
    }
    
    private func fetchShifts() {
        do {
            guard let url = Bundle.main.url(forResource: "shifts", withExtension: "json") else {
                throw DecodingError.fileNotFound
            }
            guard let data = try? Data(contentsOf: url) else {
                throw DecodingError.invalidData
            }
            guard let wrapper = try? JSONDecoder().decode(Shift.Wrapper.self, from: data) else {
                throw DecodingError.invalidJSON
            }
            shifts = wrapper.shifts
        } catch {
            print("❌ Error: \(error.localizedDescription)")
        }
    }
}

extension ViewModel {
    enum DecodingError: Error {
        case fileNotFound
        case invalidData
        case invalidJSON
    }
}
