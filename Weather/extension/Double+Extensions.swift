//
//  Double+Extensions.swift
//  Weather
//
//  Created by Narek Ghukasyan on 23.09.22.
//

import Foundation

extension Double {
    func toString() -> String { String(format: "%.1f" ,self) }
    func toInt() -> Int { Int(self) }
}
