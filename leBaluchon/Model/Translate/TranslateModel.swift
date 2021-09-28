//
//  TranslateModel.swift
//  leBaluchon
//
//  Created by Christophe Expleo on 26/09/2021.
//

import Foundation

struct TranslateModel {
    let translatedText: String
    
    init(apiModel: TranslateResponse) {
        translatedText = apiModel.data.translations[0].translatedText
    }
}
