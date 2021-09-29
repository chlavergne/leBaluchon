//
//  TranslateResponse.swift
//  leBaluchon
//
//  Created by Christophe Expleo on 16/09/2021.
//

import Foundation

struct TranslateResponse: Decodable {
    let data: Data
}

struct Data: Decodable {
    let translations: [Translation]
}

struct Translation: Decodable {
    let translatedText: String
}
