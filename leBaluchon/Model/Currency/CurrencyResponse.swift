//
//  CurrencyResponse.swift
//  leBaluchon
//
//  Created by Christophe Expleo on 06/09/2021.
//

import Foundation

struct CurrencyResponse: Decodable {
    let rates: [String: Double]
    let timestamp: Double
}
