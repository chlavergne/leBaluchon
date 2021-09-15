//
//  WeatherViewController.swift
//  leBaluchon
//
//  Created by Christophe Expleo on 14/09/2021.
//

import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet var weatherLogoNy: UIImageView!
    @IBOutlet var weatherLogoTo: UIImageView!
    @IBOutlet var temperatureNy: UILabel!
    @IBOutlet var temperatureTo: UILabel!
    @IBOutlet var weatherConditionNy: UILabel!
    @IBOutlet var weatherConditionTo: UILabel!
    @IBOutlet var date: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherTo(city: "Toulouse")
        weatherNy(city: "New York")
    }
    
    private func presentAlert(error: String) {
        let alert = UIAlertController(title: "Erreur", message: error, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    private func weatherTo(city: String) {
        WeatherService.shared.fetchJSON(city: city) {(success, weather) in
            if success {
                self.temperatureTo.text = "\(weather.temperatureString)°C"
                self.weatherLogoTo.image = UIImage(systemName: weather.conditionName)
                self.weatherConditionTo.text = weather.main
            } else {
                self.presentAlert(error: "Erreur de chargement")
            }
        }
    }
    
    private func weatherNy(city: String) {
        WeatherService.shared.fetchJSON(city: city) {(success, weather) in
            if success {
                self.temperatureNy.text = "\(weather.temperatureString)°C"
                self.weatherLogoNy.image = UIImage(systemName: weather.conditionName)
                self.weatherConditionNy.text = weather.main
                let dateInitial = Date(timeIntervalSince1970: TimeInterval(weather.date))
                self.date.text = "Mise à jour le \(dateInitial)"
            } else {
                self.presentAlert(error: "Erreur de chargement")
            }
        }
    }
}

