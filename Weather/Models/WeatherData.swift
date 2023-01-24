//
//  WeatherData.swift
//  Weather
//
//  Created by Narek Ghukasyan on 22.09.22.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    
    var model: WeatherModel {
        return WeatherModel(countryName: name,
                            temp: main.temp.toInt(),
                            conditionId: weather.first?.id ?? 0,
                            conditionDescription: weather.first?.description ?? "")
    }
}

struct Main: Codable {
    let temp: Double
//    let feels_like: Double
//    let temp_min: Double
//    let temp_max: Double
//    let pressure: Double
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
}


struct WeatherModel {
    
    let countryName: String
    let temp: Int
    let conditionId: Int
    let conditionDescription: String
    
    var conditionImage: String {
        switch conditionId {
        case 200...299:
            return "imThunderstorm"
        case 300...399:
            return "imDrizzle"
        case 500...599:
            return "imRain"
        case 600...699:
            return "imSnow"
        case 700...799:
            return "imAtmosphere"
        case 800:
            return "imClear"
        default:
            return "imClouds"
        }
    }
    
}
