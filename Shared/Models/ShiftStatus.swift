//
//  ShiftStatus.swift
//  TurnosL9
//
//  Created by Jose Antonio Mendoza on 20/5/25.
//

import Foundation

enum ShiftStatus: Codable {
    case waiting
    case working
    case finished
}

extension ShiftStatus {
    var description: String {
        switch self {
            case .waiting:
                return "Descansando"
            case .working:
                return "Circulando"
            case .finished:
                return "Terminando"
            }
    }
    
    var systemImageName: String {
        switch self {
            case .waiting:
                return "cup.and.saucer.fill"
            case .working:
                return "tram"
            case .finished:
                return "checkmark.circle.fill"
        }
    }
}
