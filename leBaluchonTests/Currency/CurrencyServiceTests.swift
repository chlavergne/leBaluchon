//
//  CurrencyServiceTests.swift
//  leBaluchonTests
//
//  Created by Christophe Expleo on 26/09/2021.
//

import XCTest
@testable import leBaluchon

class CurrencyServiceTests: XCTestCase {
    
    // MARK: - CurrencyService Tests
    func testCurrencyServicefetchJSONShouldPostFailedCallbackError() {
        // Given
        let currencyService = CurrencyService(
            session: URLSessionFake(data: nil, response: nil, error: FakeCurrencyResponseData.error))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        currencyService.fetchJSON { error, _ in
            // Then
            XCTAssertNotNil(error)
            XCTAssertNotNil(error?.localizedDescription)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testCurrencyServicefetchJSONShouldPostFailedCallbackIfNoData() {
        // Given
        let currencyService = CurrencyService(
            session: URLSessionFake(data: nil, response: nil, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        currencyService.fetchJSON { error, currency in
            // Then
            XCTAssertNil(error)
            XCTAssertNil(currency)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testCurrencyServicefetchJSONShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let currencyService = CurrencyService(
            session: URLSessionFake(data: FakeCurrencyResponseData.CurrencyIncorrectData,
                                    response: FakeCurrencyResponseData.responseOK, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        currencyService.fetchJSON { error, currency in
            // Then
            XCTAssertNotNil(error)
            XCTAssertNil(currency)
            XCTAssertEqual(error?.localizedDescription, "The data couldn’t be read because it isn’t in the correct format.")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testCurrencyServicefetchJSONShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        let currencyService = CurrencyService(
            session: URLSessionFake(data: FakeCurrencyResponseData.CurrencyCorrectData,
                                    response: FakeCurrencyResponseData.responseOK, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        currencyService.fetchJSON { error, currency in
            // Then
            XCTAssertNil(error)
            XCTAssertNotNil(currency)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
