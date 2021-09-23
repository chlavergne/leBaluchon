//
//  leBaluchonTests.swift
//  leBaluchonTests
//
//  Created by Christophe Expleo on 07/09/2021.
//

import XCTest
@testable import leBaluchon

class leBaluchonTests: XCTestCase {

    // MARK: - Propertie
    let testText = "Un texte pour les tests"
    
    // MARK: - TranslateService Tests
    func testTranslateServicefetchJSONShouldPostFailedCallbackError() {
        // Given
        let TranslateService = TranslateService(
            session: URLSessionFake(data: nil, response: nil, error: FakeTranslateResponseData.error))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        TranslateService.fetchJSON (text: testText) { success, translation in
            //Then
            XCTAssertFalse(success)
            XCTAssertEqual(translation, "Error")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testTranslateServicefetchJSONShouldPostFailedCallbackIfNoData() {
        // Given
        let TranslateService = TranslateService(
            session: URLSessionFake(data: nil, response: nil, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        TranslateService.fetchJSON (text: testText) { success, translation in
            //Then
            XCTAssertFalse(success)
            XCTAssertEqual(translation, "Error")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testTranslateServicefetchJSONShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let TranslateService = TranslateService(
            session: URLSessionFake(data: FakeTranslateResponseData.TranslateIncorrectData, response: FakeTranslateResponseData.responseOK, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        TranslateService.fetchJSON (text: testText) { success, translation in
            //Then
            XCTAssertFalse(success)
            XCTAssertEqual(translation, "Error")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testTranslateServicefetchJSONShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        let TranslateService = TranslateService(
            session: URLSessionFake(data: FakeTranslateResponseData.TranslateCorrectData, response: FakeTranslateResponseData.responseOK, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        TranslateService.fetchJSON (text: testText) { success, translation in
            //Then
            XCTAssertTrue(success)
            XCTAssertNotNil(translation)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    // MARK: - CurrencyService Tests
    func testCurrencyServicefetchJSONShouldPostFailedCallbackError() {
        // Given
        let CurrencyService = CurrencyService(
            session: URLSessionFake(data: nil, response: nil, error: FakeCurrencyResponseData.error))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        CurrencyService.fetchJSON { success, currency in
            //Then
            XCTAssertFalse(success)
            XCTAssertEqual(currency.currencyData, ["Error": 0.0])
            XCTAssertEqual(currency.timestamp, 0)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testCurrencyServicefetchJSONShouldPostFailedCallbackIfNoData() {
        // Given
        let CurrencyService = CurrencyService(
            session: URLSessionFake(data: nil, response: nil, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        CurrencyService.fetchJSON { success, currency in
            //Then
            XCTAssertFalse(success)
            XCTAssertEqual(currency.currencyData, ["Error": 0.0])
            XCTAssertEqual(currency.timestamp, 0)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testCurrencyServicefetchJSONShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let CurrencyService = CurrencyService(
            session: URLSessionFake(data: FakeCurrencyResponseData.CurrencyIncorrectData, response: FakeCurrencyResponseData.responseOK, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        CurrencyService.fetchJSON { success, currency in
            //Then
            XCTAssertFalse(success)
            XCTAssertEqual(currency.currencyData, ["Error": 0.0])
            XCTAssertEqual(currency.timestamp, 0)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testCurrencyServicefetchJSONShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        let CurrencyService = CurrencyService(
            session: URLSessionFake(data: FakeCurrencyResponseData.CurrencyCorrectData, response: FakeCurrencyResponseData.responseOK, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        CurrencyService.fetchJSON { success, currency in
            //Then
            XCTAssertTrue(success)
            XCTAssertNotNil(currency)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // MARK: - WeatherService Tests
    func testWeatherServicefetchJSONShouldPostFailedCallbackError() {
        // Given
        let WeatherService = WeatherService(
            session: URLSessionFake(data: nil, response: nil, error: FakeWeatherResponseData.error))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        WeatherService.fetchJSON (city: testText) { success, weather in
            //Then
            XCTAssertFalse(success)
            XCTAssertEqual(weather.main, "Error")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testWeatherServicefetchJSONShouldPostFailedCallbackIfNoData() {
        // Given
        let WeatherService = WeatherService(
            session: URLSessionFake(data: nil, response: nil, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        WeatherService.fetchJSON (city: testText) { success, weather in
            //Then
            XCTAssertFalse(success)
            XCTAssertEqual(weather.main, "Error")
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
        WeatherService.fetchJSON (city: testText) { success, weather in
            //Then
            XCTAssertFalse(success)
            XCTAssertEqual(weather.main, "Error")
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
        WeatherService.fetchJSON (city: testText) { success, weather in
            //Then
            XCTAssertTrue(success)
            XCTAssertNotNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
