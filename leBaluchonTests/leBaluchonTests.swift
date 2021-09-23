//
//  leBaluchonTests.swift
//  leBaluchonTests
//
//  Created by Christophe Expleo on 07/09/2021.
//

import XCTest
@testable import leBaluchon

class leBaluchonTests: XCTestCase {
    
    // MARK: - TranslateService Tests
    let testText = "Un texte pour les tests"
    
    func testTranslateServicefetchJSONShouldPostFailedCallbackError() {
        // Given
        
        let TranslateService = TranslateService(
            session: URLSessionFake(data: nil, response: nil, error: FakeTranslateResponseData.error))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        TranslateService.fetchJSON (text: testText) { success, translation in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(translation)
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
            XCTAssertNil(translation)
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
        CurrencyService.fetchJSON { success, currencyData, timestamp in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(currencyData)
            XCTAssertNil(timestamp)
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
        CurrencyService.fetchJSON { success, currencyData, timestamp in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(currencyData)
            XCTAssertNil(timestamp)
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
        CurrencyService.fetchJSON { success, currencyData, timestamp in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(currencyData)
            XCTAssertNil(timestamp)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testCurrencyServicefetchJSONShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        let CurrencyService = CurrencyService(
            session: URLSessionFake(data: FakeCurrencyResponseData.CurrencyCorrectData, response: FakeCurrencyResponseData.responseOK, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        CurrencyService.fetchJSON { success, currencyData, timestamp in
            //Then
            XCTAssertTrue(success)
            XCTAssertNotNil(currencyData)
            XCTAssertNotNil(timestamp)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }}
