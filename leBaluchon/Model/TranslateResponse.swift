//
//  TranslateResponse.swift
//  leBaluchon
//
//  Created by Christophe Expleo on 16/09/2021.
//

import Foundation

struct TranslateResponse: Codable {
    let data: Data
}


struct Data: Codable {
    let translations: [Translation]
}

struct Translation: Codable {
    let translatedText: String
}
