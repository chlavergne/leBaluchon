//
//  FakeResponseData.swift
//  leBaluchonTests
//
//  Created by Christophe Expleo on 07/09/2021.
//

import Foundation

class FakeResponseData {
    // MARK: - Data
    static var DevisesCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Devises", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        return data
    }
    
    static let DevisesIncorrectData = "erreur".data(using: .utf8)!
    
    // MARK: - Response
    static let responseOK = HTTPURLResponse(
        url: URL(string: "https://fixer.io")!,
        statusCode: 200, httpVersion: nil, headerFields: [:])!
    
    static let responseKO = HTTPURLResponse(
        url: URL(string: "https://fixer.io")!,
        statusCode: 500, httpVersion: nil, headerFields: [:])!
    
    // MARK: - Error
    class DevisesError: Error {}
    static let error = DevisesError()
}
