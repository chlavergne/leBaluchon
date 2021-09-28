//
//  TranslateServiceTests.swift
//  leBaluchonTests
//
//  Created by Christophe Expleo on 07/09/2021.
//

import XCTest
@testable import leBaluchon

class TranslateServiceTests: XCTestCase {

    // MARK: - Propertie
    let testText = "Un texte pour les tests"
    
    // MARK: - TranslateService Tests
    func testTranslateServicefetchJSONShouldPostFailedCallbackError() {
        // Given
        let TranslateService = TranslateService(
            session: URLSessionFake(data: nil, response: nil, error: FakeTranslateResponseData.error))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        TranslateService.fetchJSON (text: testText) { error, translation in
            //Then
            XCTAssertNotNil(error)
            XCTAssertNotNil(error?.localizedDescription)
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
        TranslateService.fetchJSON (text: testText) { error, translation in
            //Then
            XCTAssertNil(error)
            XCTAssertNil(translation)
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
        TranslateService.fetchJSON (text: testText) { error, translation in
            //Then
            XCTAssertNotNil(error)
            XCTAssertNil(translation)
            XCTAssertEqual(error?.localizedDescription, "The data couldn’t be read because it isn’t in the correct format.")
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
        TranslateService.fetchJSON (text: testText) { error, translation in
            //Then
            XCTAssertNil(error)
            XCTAssertNotNil(translation)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
