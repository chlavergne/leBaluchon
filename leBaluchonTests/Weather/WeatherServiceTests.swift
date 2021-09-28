//
//  WeatherServiceTests.swift
//  leBaluchonTests
//
//  Created by Christophe Expleo on 26/09/2021.
//

import XCTest
@testable import leBaluchon

class WeatherServiceTests: XCTestCase {
    
    // MARK: - Propertie
    let testText = "Un texte pour les tests"

    // MARK: - WeatherService Tests
    func testWeatherServicefetchJSONShouldPostFailedCallbackError() {
        // Given
        let WeatherService = WeatherService(
            session: URLSessionFake(data: nil, response: nil, error: FakeWeatherResponseData.error))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        WeatherService.fetchJSON (city: testText) { error, weather in
            //Then
            XCTAssertNotNil(error)
            XCTAssertNotNil(error?.localizedDescription)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
//
    func testWeatherServicefetchJSONShouldPostFailedCallbackIfNoData() {
        // Given
        let WeatherService = WeatherService(
            session: URLSessionFake(data: nil, response: nil, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        WeatherService.fetchJSON (city: testText) { error, weather in
            //Then
            XCTAssertNil(error)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testWeatherServicefetchJSONShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let WeatherService = WeatherService(
            session: URLSessionFake(data: FakeWeatherResponseData.WeatherIncorrectData, response: FakeWeatherResponseData.responseOK, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        WeatherService.fetchJSON (city: testText) { error, weather in
            //Then
            XCTAssertNotNil(error)
            XCTAssertNil(weather)
            XCTAssertEqual(error?.localizedDescription, "The data couldn’t be read because it isn’t in the correct format.")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testWeatherServicefetchJSONShouldPostFailedCallbackIfCorrectData() {
        // Given
        let WeatherService = WeatherService(
            session: URLSessionFake(data: FakeWeatherResponseData.WeatherCorrectData, response: FakeWeatherResponseData.responseOK, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        WeatherService.fetchJSON (city: testText) { error, weather in
            //Then
            XCTAssertNil(error)
            XCTAssertNotNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
