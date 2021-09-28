//
//  WeatherService.swift
//  leBaluchon
//
//  Created by Christophe Expleo on 14/09/2021.
//

import Foundation

class WeatherService {
    
    // MARK: - Properties
    private var session = URLSession(configuration: .default)

    init(session: URLSession) {
        self.session  = session
    }
    
    // MARK: - Methods
    func fetchJSON(city: String, callback: @escaping (Error?, WeatherModel?) -> Void) {
        let request = createWeatherRequest(city: city)
        let task = session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(error, nil)
                    return
                }
                do {
                    let responseJSON = try JSONDecoder().decode(WeatherResponse.self, from: data)
                    let weather = WeatherModel(apiModel: responseJSON)
                    callback(nil, weather)
                } catch  {
                    callback(error, nil)
                    return
                }
            }
        }
        task.resume()
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
