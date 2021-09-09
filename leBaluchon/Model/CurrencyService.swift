//
//  CurrencyService.swift
//  leBaluchon
//
//  Created by Christophe Expleo on 09/09/2021.
//

import Foundation

class CurrencyService {
    
    static var shared = CurrencyService()
    var currencyCode: [String] = []
    var values: [Double] = []
    
    private init() {}
    
    func fetchJSON(callback: @escaping ([String]?, [Double]?) -> Void) {
        guard let url = URL(string: "http://data.fixer.io/api/latest?access_key=fbaa144280f40b3d007443ebae931f68&base=EUR&symbols=USD,CAD,CHF,CNY,BRL,GBP,RUB,AUD,DKK,HKD,IDR") else {return}
        URLSession.shared.dataTask(with: url) { data, response, error in
            // handle any errors if there any
            if error != nil {
                print(error!)
            }
            // safely unwrap the data
            guard let safeData = data else {return}
            // decode the JSON
            do {
                let results = try JSONDecoder().decode(ExchangeRates.self, from: safeData)
                self.currencyCode.append(contentsOf: results.rates.keys)
                self.values.append(contentsOf: results.rates.values)
                DispatchQueue.main.async {
                    callback(self.currencyCode, self.values)
//                    self.pickerView.reloadAllComponents()
                }
            } catch {
                print(error)
            }
        }.resume()
    }
    
}
