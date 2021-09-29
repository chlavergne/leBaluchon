//
//  CurrencyModel.swift
//  leBaluchon
//
//  Created by Christophe Expleo on 23/09/2021.
//

import Foundation

struct CurrencyModel {
    let currencyData: [String: Double]
    let timestamp: Double

    init(apiModel: CurrencyResponse) {
        currencyData = apiModel.rates
        timestamp = apiModel.timestamp
    }
}
