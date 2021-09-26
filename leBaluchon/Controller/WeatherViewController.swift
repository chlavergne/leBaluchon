//
//  WeatherViewController.swift
//  leBaluchon
//
//  Created by Christophe Expleo on 14/09/2021.
//

import UIKit

class WeatherViewController: UIViewController {
    
    // MARK: -IBOutlets
    @IBOutlet var weatherLogoNy: UIImageView!
    @IBOutlet var weatherLogoTo: UIImageView!
    @IBOutlet var temperatureNy: UILabel!
    @IBOutlet var temperatureTo: UILabel!
    @IBOutlet var weatherConditionNy: UILabel!
    @IBOutlet var weatherConditionTo: UILabel!
    @IBOutlet var date: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weather(city: "Toulouse")
        weather(city: "New York")
    }
    
    //MARK: -Methods
    private func weather(city: String) {
        WeatherService.shared.fetchJSON(city: city) {(error, weather) in
            if let weather = weather {
                self.updateUI(city: city, weather: weather)
            } else {
                self.presentAlert(error: error?.localizedDescription ?? "Erreur de chargement")
            }
        }
    }
    
    private func updateUI(city: String, weather: WeatherModel) {
        if city == "Toulouse" {
            self.temperatureTo.text = "\(weather.temperatureString)°C"
            self.weatherLogoTo.image = UIImage(systemName: weather.conditionName)
            self.weatherConditionTo.text = weather.main
        } else if city == "New York" {
            self.temperatureNy.text = "\(weather.temperatureString)°C"
            self.weatherLogoNy.image = UIImage(systemName: weather.conditionName)
            self.weatherConditionNy.text = weather.main
        }
        let dateInitial = Date(timeIntervalSince1970: TimeInterval(weather.date))
        self.date.text = "Mise à jour le \(dateInitial)"
    }
}

