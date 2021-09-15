//
//  WeatherService.swift
//  leBaluchon
//
//  Created by Christophe Expleo on 14/09/2021.
//

import Foundation

class WeatherService {
    
    var errorWeather = WeatherModel(conditionId: 1, date: 0, temperature: 0, main: "Error")
    
    static var shared = WeatherService()
    
    private var task: URLSessionDataTask?
    
    func fetchJSON(city: String, callback: @escaping (Bool, WeatherModel) -> Void) {
        let request = createWeatherRequest(city: city)
        let session = URLSession(configuration: .default)
        task = session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, self.errorWeather)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {callback(false, self.errorWeather)
                    return}
                guard let responseJSON = try? JSONDecoder().decode(WeatherResponse.self, from: data)  else {
                    callback(false, self.errorWeather)
                    return
                }
                let id = responseJSON.weather[0].id
                let temp = responseJSON.main.temp
                let date = responseJSON.dt
                let main = responseJSON.weather[0].main
                
                let weather = WeatherModel(conditionId: id, date: date, temperature: temp, main: main)
                callback(true, weather)
            }
        }
        task?.resume()
    }
    
    private func createWeatherRequest(city: String) -> URLRequest {
        var urlConponents = URLComponents(string: "http://api.openweathermap.org/data/2.5/weather")!
        urlConponents.queryItems = [URLQueryItem(name: "appid", value: "0c6065a96d5662ac8c7cf2b25a72acff"),
                                    URLQueryItem(name: "q", value: city), URLQueryItem(name: "units", value: "metric")]
        var request = URLRequest(url: urlConponents.url!)
        request.httpMethod = "GET"
        return request
    }
}
