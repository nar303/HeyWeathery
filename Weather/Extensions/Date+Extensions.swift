//
//  Date+Extensions.swift
//  Amore1
//
//  Created by Ashot on 22.11.22.
//

import Foundation

extension Date {
    static func currentTimeString() -> String {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        
        let currentTime = "\(hour):\(minutes)"
        return currentTime
    }
}
