//
//  FakeTranslateResponseData.swift
//  leBaluchonTests
//
//  Created by Christophe Expleo on 20/09/2021.
//

import Foundation

class FakeTranslateResponseData {
    // MARK: - Data
    static var TranslateCorrectData: Data? {
        let bundle = Bundle(for: FakeTranslateResponseData.self)
        let url = bundle.url(forResource: "Translation", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
    
    static let TranslateIncorrectData = "erreur".data(using: .utf8)!
    
    // MARK: - Response
    static let responseOK = HTTPURLResponse(
        url: URL(string: "https://translation.googleapis.com")!,
        statusCode: 200, httpVersion: nil, headerFields: [:])!
    
    static let responseKO = HTTPURLResponse(
        url: URL(string: "https://translation.googleapis.com")!,
        statusCode: 500, httpVersion: nil, headerFields: [:])!
    
    // MARK: - Error
    class TranslateError: Error {}
    static let error = TranslateError()
}
