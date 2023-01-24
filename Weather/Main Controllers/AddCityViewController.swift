//
//  AddCityViewController.swift
//  Weather
//
//  Created by Narek Ghukasyan on 23.09.22.
//

import UIKit

class AddCityViewController: UIViewController {
    static let id = "AddCityViewController"
    
    private class Constants {
        static let searchError = "City cannot be empty. Please try again!"
        static let searchSuccess = "Success!"
    }
    
    private let weatherManager = WeatherManager()
    weak var delegate: WeatherViewControllerDelegate?

    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupGestures()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // why
        cityTextField.becomeFirstResponder() // why here?
    }
    
    func setupView() {
        view.backgroundColor = UIColor(white: 0.3, alpha: 0.4)
        statusLabel.isHidden = true
    }
    
    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissVC))
        tapGesture.delegate = self
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        guard let query = cityTextField.text, !query.isEmpty else {
            showSearchError(text: Constants.searchError)
            return
        }
        
        handleSearch(query: query)
    }
    
    private func handleSearch(query: String) {
        view.endEditing(true)
        self.activityIndicatorView.startAnimating()
        weatherManager.fetchWeather(byCity: query) { (result) in
            self.activityIndicatorView.stopAnimating()
            switch result {
            case .success(let model):
                self.handleSearchSuccess(model: model)
            case .failure(let error):
                self.showSearchError(text: error.localizedDescription)
            }
        }
    }
    
    private func handleSearchSuccess(model: WeatherModel) {
        statusLabel.isHidden = false
        statusLabel.textColor = .green
        statusLabel.text = Constants.searchSuccess
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.delegate?.didUpdateWeatherFromSearch(model: model)
        }
    }
    
    private func showSearchError(text: String) {
        self.statusLabel.textColor = .red
        self.statusLabel.text = text
        self.statusLabel.isHidden = false
    }
    
}

extension AddCityViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        touch.view == self.view
    }
}
