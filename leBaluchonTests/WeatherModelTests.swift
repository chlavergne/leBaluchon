//
//  WeatherModelTests.swift
//  leBaluchonTests
//
//  Created by Christophe Expleo on 27/09/2021.
//

import XCTest
@testable import leBaluchon

class WeatherModel: XCTestCase {
    
    // MARK: - Propertie
    let testText = "Un texte pour les tests"

    
    func testWeatherModelconditionNameShouldreturnsunMax() {
        // Given
        let WeatherService = WeatherService(
            session: URLSessionFake(data: FakeWeatherResponseData.WeatherCorrectData, response: FakeWeatherResponseData.responseOK, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        WeatherService.fetchJSON (city: testText) { error, weather in
            //Then
            XCTAssertEqual(weather?.conditionName, "sun.max")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
