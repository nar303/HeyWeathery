//
//  String+Extensions.swift
//  Amore1
//
//  Created by Ashot on 27.10.22.
//

import Foundation

extension String {
    func hidden() -> String{
        if self.count > 2 {
            let prefix = self.prefix(2)
            let suffix = self.suffix(self.count - 2)
            let replacedSuffix = String(suffix.map { _ in "*" })
            let hiddenString = prefix + replacedSuffix
            return String(hiddenString)
        }
        return self
    }
    
    static func isNilOrEmpty(string: String?) -> Bool {
        guard let value = string else { return true }
        return value.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    static func isNotNilOrEmpty(string: String?) -> Bool {
        !isNilOrEmpty(string: string)
    }
}
