//
//  CacheManager.swift
//  ios-weather-app
//
//  Created by Kelvin Fok on 26/7/20.
//  Copyright © 2020 Kelvin Fok. All rights reserved.
//

import Foundation

struct CacheManager {
    
    private let vault = UserDefaults.standard
    
    enum Key: String {
        case city
    }
    
    func cacheCity(cityName: String) {
        vault.set(cityName, forKey: Key.city.rawValue)
    }
    
    func getCachedCity() -> String? {
       return vault.value(forKey: Key.city.rawValue) as? String
    }
    
}
