//
//  WeatherManager.swift
//  Weather
//
//  Created by Narek Ghukasyan on 22.09.22.
//

import Foundation
import Alamofire

enum WeatherError: Error, LocalizedError {
    case invalidCity
    case unknown
    case custom(description: String)
    
    var errorDescription: String? {
        switch self {
        case .invalidCity:
            return "This is an invalid city. Please try again."
        case .unknown:
            return "Hey, this is an unknown error!"
        case .custom(let description):
            return description
        }
    }
    
}

struct WeatherManager {
    private let API_KEY = "12d27386e5aee5307dd683ade183e4a6"
    private let cacheManager = CacheManager()
    
    func fetchWeather(byCity cityName: String, completion: @escaping (Result<WeatherModel, Error>) -> Void) {
        let query = cityName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? cityName
        let path = "https://api.openweathermap.org/data/2.5/weather?q=%@&appid=%@&units=metric"
        let urlString = String(format: path, query, API_KEY)
        handleRequest(urlString: urlString, completion: completion)
        
    }
    
    func fetchWeather(lat: Double, lon: Double, completion: @escaping (Result<WeatherModel, Error>) -> Void) {
        let path = "https://api.openweathermap.org/data/2.5/weather?appid=%@&units=metric&lat=%f&lon=%f"
        let urlString = String(format: path, API_KEY, lat, lon)
        handleRequest(urlString: urlString, completion: completion)
    }
    
    private func handleRequest(urlString: String, completion: @escaping (Result<WeatherModel, Error>) -> Void) {
        AF
            .request(urlString)
            .validate() // what is this?
            .responseDecodable(of: WeatherData.self, queue: .main, decoder: JSONDecoder()) { (response) in
            switch response.result {
            case .success(let weatherData):
                let model = weatherData.model
                self.cacheManager.cacheCity(cityName: model.countryName)
                completion(.success(model))
            case .failure(let error):
                if let err = getWeatherError(error: error, data: response.data) {
                    completion(.failure(err))
                } else {
                    completion(.failure(error))
                }
            }
        }
    }
    
    private func getWeatherError(error: AFError, data: Data?) -> Error? {
        if error.responseCode == 404,
            let data = data,
            let failure = try? JSONDecoder().decode(WeatherDataFailure.self, from: data) {
            let message = failure.message
            return WeatherError.custom(description: message)
        } else {
            return nil
        }
    }
}
