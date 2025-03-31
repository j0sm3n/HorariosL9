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
    
    func fetchShifts() {
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
