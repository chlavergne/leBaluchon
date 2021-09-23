//
//  FakeResponseData.swift
//  leBaluchonTests
//
//  Created by Christophe Expleo on 07/09/2021.
//

import Foundation

class FakeCurrencyResponseData {
    // MARK: - Data
    static var CurrencyCorrectData: Data? {
        let bundle = Bundle(for: FakeCurrencyResponseData.self)
        let url = bundle.url(forResource: "Devises", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        return data
    }
    
    static let CurrencyIncorrectData = "erreur".data(using: .utf8)!
    
    // MARK: - Response
    static let responseOK = HTTPURLResponse(
        url: URL(string: "https://fixer.io")!,
        statusCode: 200, httpVersion: nil, headerFields: [:])!
    
    static let responseKO = HTTPURLResponse(
        url: URL(string: "https://fixer.io")!,
        statusCode: 404, httpVersion: nil, headerFields: [:])!
    
    // MARK: - Error
    class DevisesError: Error {}
    static let error = DevisesError()
}

