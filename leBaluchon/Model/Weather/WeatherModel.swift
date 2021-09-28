//
//  WeatherModel.swift
//  leBaluchon
//
//  Created by Christophe Expleo on 14/09/2021.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let date: Double
    let temperature: Double
    let main: String
    let sunrise: Double
    let sunset: Double
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    var conditionName: String {
        switch conditionId {
        case 1:
            return "multiply.circle"
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return  "cloud.rain"
        case 600...622:
            return  "cloud.snow"
        case 701...781:
            return  "cloud.fog"
        case 800:
            if date < sunrise || date > sunset {
                return "moon.stars"
            } else {
                return  "sun.max"}
        case 801...804:
            return  "cloud.bolt"
        default:
            return "cloud"
        }
    }
    
    init(apiModel: WeatherResponse) {
        conditionId = apiModel.weather[0].id
        temperature = apiModel.main.temp
        date = apiModel.dt
        main = apiModel.weather[0].main
        sunrise = apiModel.sys.sunrise
        sunset = apiModel.sys.sunset
    }
}
