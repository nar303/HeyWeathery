//
//  ViewController.swift
//  Weather
//
//  Created by Narek Ghukasyan on 22.09.22.
//

import UIKit
import SkeletonView
import CoreLocation
import Loaf

protocol WeatherViewControllerDelegate: AnyObject {
    func didUpdateWeatherFromSearch(model: WeatherModel)
}

class WeatherViewController: UIViewController {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    
    private let defaultCity = "berlin"
    private let weatherManager = WeatherManager()
    private let cacheManager = CacheManager()
    
    
    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.delegate = self
        return manager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let city = cacheManager.getCachedCity() ?? defaultCity
        fetchWeather(byCity: city)
    }
    
    @IBAction func addLocationButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: AddCityViewController.id) as! AddCityViewController
        vc.delegate = self
        self.present(vc, animated: true)
    }
    
    @IBAction func locationButtonTapped(_ sender: Any) {
        // CLLocationManager.authorizationStatus() 'authorizationStatus()' was deprecated in iOS 14.0
        switch locationManager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.requestLocation()
//            locationManager.startUpdatingLocation()
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            locationManager.requestLocation()
//            locationManager.startUpdatingLocation()
        default:
            promtForLocationPermission()
        }
    }
    
    func promtForLocationPermission() {
        let alertController = UIAlertController(title: "Requires Location Permission", message: "Would you like to enable location permission in Settings?", preferredStyle: .alert)
        let enableAction = UIAlertAction(title: "Go to Settings", style: .default) { _ in
            guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else {return}
            UIApplication.shared.open(settingsURL)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(enableAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true)
    }
    
    
    
    func updateView(with data: WeatherModel) {
        hideAnimation()
        temperatureLabel.text = data.temp.toString().appending("°C")
//        data.main.temp.toString().appending("°C")
        conditionLabel.text = data.conditionDescription
        conditionImageView.image = UIImage(named: data.conditionImage)
//        data.weather.first?.description
        navigationItem.title = data.countryName
        
    }
    
    func hideAnimation() {
        conditionImageView.hideSkeleton()
        temperatureLabel.hideSkeleton()
        conditionLabel.hideSkeleton()
    }
    
    func showAnimation() {
        conditionImageView.showAnimatedGradientSkeleton()
        temperatureLabel.showAnimatedGradientSkeleton()
        conditionLabel.showAnimatedGradientSkeleton()
    }
}

extension WeatherViewController: WeatherViewControllerDelegate {
    func didUpdateWeatherFromSearch(model: WeatherModel) {
        presentedViewController?.dismiss(animated: true, completion: {
            self.updateView(with: model)
        })
    }
    
    
}

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            manager.stopUpdatingLocation()
            fetchWeather(byLocation: location)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        handleError(error)
    }
}


//MARK: Networking
extension WeatherViewController {
    func fetchWeather(byCity: String) {
        showAnimation()
        weatherManager.fetchWeather(byCity: byCity) { [weak self] (result) in
            guard let this = self else {return}
            this.handleResult(result)
        }
    }
    
    func fetchWeather(byLocation location: CLLocation) {
        let lat = location.coordinate.latitude
        let lon = location.coordinate.longitude
        print("LAT:LON - (\(lat):\(lon))")
        weatherManager.fetchWeather(lat: lat, lon: lon) { [weak self] (result) in
            guard let this = self else {return}
            this.handleResult(result)
        }
    }
    
    private func handleResult(_ result: Result<WeatherModel, Error>) {
        switch result {
        case .success(let model):
            DispatchQueue.main.async {
                self.updateView(with: model)
            }
        case .failure(let err):
            DispatchQueue.main.async {
                self.handleError(err)
            }
        }
    }
    
    private func handleError(_ error: Error) {
        hideAnimation()
        conditionImageView.image = UIImage(named: "imSad")
        navigationItem.title = ""
        temperatureLabel.text = "Oops!"
        conditionLabel.text = "Something went wrong. Please try again later."
        Loaf(error.localizedDescription, state: .error, location: .bottom, sender: self).show()
    }
}
