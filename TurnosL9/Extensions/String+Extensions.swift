//
//  String+Extensions.swift
//  TurnosL9
//
//  Created by Jose Antonio Mendoza on 1/11/24.
//

import Foundation

extension String {
    var isNumeric: Bool {
        Double(self) != nil
    }
}
