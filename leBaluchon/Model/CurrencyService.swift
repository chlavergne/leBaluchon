//
//  CurrencyService.swift
//  leBaluchon
//
//  Created by Christophe Expleo on 09/09/2021.
//

import Foundation

class CurrencyService {
    
    // MARK: - Properties
    static var shared = CurrencyService()
    private init() {}
    
    private var task: URLSessionDataTask?
    private var session = URLSession(configuration: .default)
    
    init(session: URLSession) {
        self.session  = session
    }
    
    // MARK: - Methods
    func fetchJSON(callback: @escaping (Bool, [String: Double]?, Double?) -> Void) {
        let request = createCurrencyRequest()
        task?.cancel()
        task = session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {callback(false, nil, nil)
                    return}
                guard let responseJSON = try? JSONDecoder().decode(CurrencyResponse.self, from: data)  else {
                    callback(false, nil, nil)
                    return
                }
                let currencyData = responseJSON.rates
                let timestamp = responseJSON.timestamp
                callback(true, currencyData, timestamp)
            }
        }
        task?.resume()
    }
    
    private func createCurrencyRequest() -> URLRequest {
        var urlConponents = URLComponents(string: "http://data.fixer.io/api/latest")!
        urlConponents.queryItems = [URLQueryItem(name: "access_key", value: "ab5d919e80c01ffa58db756efb99fe9f"),
                                    URLQueryItem(name: "symbols", value: "AED, ARS, BOB, BRL, CHE, ZAR, USD, MXN, QAR")]
        var request = URLRequest(url: urlConponents.url!)
        request.httpMethod = "GET"
        return request
    }
    
}
