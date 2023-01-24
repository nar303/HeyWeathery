//
//  Optional+Extensions.swift
//  Amore1
//
//  Created by Ashot on 13.12.22.
//

import Foundation

extension Optional where Wrapped == String {
    var isNilOrEmpty: Bool {
        self == nil || self == ""
    }
}
