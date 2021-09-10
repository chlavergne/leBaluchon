//
//  CurrencyService.swift
//  leBaluchon
//
//  Created by Christophe Expleo on 09/09/2021.
//

import Foundation

class CurrencyService {
    
    static var shared = CurrencyService()
    
    private static let exchangeUrl = URL(string: "http://data.fixer.io/api/latest")!
    private var task: URLSessionDataTask?
    
    func fetchJSON(callback: @escaping ([String: Double]?) -> Void) {
        let request = createCurrencyRequest()
        let session = URLSession(configuration: .default)
        task?.cancel()
        task = session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {callback(nil)
                    return}
                guard let responseJSON = try? JSONDecoder().decode(ExchangeRates.self, from: data)  else {
                    callback(nil)
                    return
                }
                let currencyData = responseJSON.rates
                callback(currencyData)
            }
        }
        task?.resume()
    }
    
    private func createCurrencyRequest() -> URLRequest {
        var urlConponents = URLComponents(string: "http://data.fixer.io/api/latest")!
        urlConponents.queryItems = [URLQueryItem(name: "access_key", value: "fbaa144280f40b3d007443ebae931f68")]
        var request = URLRequest(url: urlConponents.url!)
        request.httpMethod = "GET"
        return request
    }
    
}
