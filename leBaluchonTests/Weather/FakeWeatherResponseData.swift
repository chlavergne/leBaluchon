//
//  FakeWeatherResponseData.swift
//  leBaluchonTests
//
//  Created by Christophe Expleo on 23/09/2021.
//

import Foundation

class FakeWeatherResponseData {
    // MARK: - Data
    static var WeatherCorrectData: Data? {
        let bundle = Bundle(for: FakeWeatherResponseData.self)
        let url = bundle.url(forResource: "Weather", withExtension: "json")!
        return try! Data(contentsOf: url)
    }

    static let WeatherIncorrectData = "erreur".data(using: .utf8)!

    // MARK: - Response
    static let responseOK = HTTPURLResponse(
        url: URL(string: "https://api.openweathermap.org")!,
        statusCode: 200, httpVersion: nil, headerFields: [:])!

    static let responseKO = HTTPURLResponse(
        url: URL(string: "https://api.openweathermap.org")!,
        statusCode: 500, httpVersion: nil, headerFields: [:])!

    // MARK: - Error
    class WeatherError: Error {}
    static let error = WeatherError()
}
