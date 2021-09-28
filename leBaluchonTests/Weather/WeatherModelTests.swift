//
//  WeatherModelTests.swift
//  leBaluchonTests
//
//  Created by Christophe Expleo on 27/09/2021.
//

import XCTest
@testable import leBaluchon

class WeatherModelTests: XCTestCase {
    
    // MARK: - Propertie
    let testText = "Un texte pour les tests"
    
    func testWeatherModelconditionNameShouldreturnMultiplyCircle() {
        let weatherTest = Weather(id: 1, main: "clear")
        let mainTest = Main(temp: 1)
        let sysTest = Sys(sunrise: 1, sunset: 1)
        let test = WeatherResponse(weather: [weatherTest], main: mainTest, dt: 1, sys: sysTest)
        let weatherModelTest = WeatherModel(apiModel: test)
        
        XCTAssertEqual(weatherModelTest.conditionName, "multiply.circle")
    }
    
    func testWeatherModelconditionNameShouldreturnCloudBolt() {
        
        var weatherTest = Weather(id: 203, main: "clear")
        let mainTest = Main(temp: 1)
        let sysTest = Sys(sunrise: 1, sunset: 1)
        var test = WeatherResponse(weather: [weatherTest], main: mainTest, dt: 1, sys: sysTest)
        var weatherModelTest = WeatherModel(apiModel: test)
        
        XCTAssertEqual(weatherModelTest.conditionName, "cloud.bolt")
        weatherTest = Weather(id: 803, main: "clear")
        test = WeatherResponse(weather: [weatherTest], main: mainTest, dt: 1, sys: sysTest)
        weatherModelTest = WeatherModel(apiModel: test)
        XCTAssertEqual(weatherModelTest.conditionName, "cloud.bolt")
    }
    
    func testWeatherModelconditionNameShouldreturnCloudDrizzle() {
        
        let weatherTest = Weather(id: 310, main: "clear")
        let mainTest = Main(temp: 1)
        let sysTest = Sys(sunrise: 1, sunset: 1)
        let test = WeatherResponse(weather: [weatherTest], main: mainTest, dt: 1, sys: sysTest)
        let weatherModelTest = WeatherModel(apiModel: test)
        
        XCTAssertEqual(weatherModelTest.conditionName, "cloud.drizzle")
    }
    
    func testWeatherModelconditionNameShouldreturnCloudRain() {
        
        let weatherTest = Weather(id: 510, main: "clear")
        let mainTest = Main(temp: 1)
        let sysTest = Sys(sunrise: 1, sunset: 1)
        let test = WeatherResponse(weather: [weatherTest], main: mainTest, dt: 1, sys: sysTest)
        let weatherModelTest = WeatherModel(apiModel: test)
        
        XCTAssertEqual(weatherModelTest.conditionName, "cloud.rain")
    }
    
    func testWeatherModelconditionNameShouldreturnCloudSnow() {
        
        let weatherTest = Weather(id: 610, main: "clear")
        let mainTest = Main(temp: 1)
        let sysTest = Sys(sunrise: 1, sunset: 1)
        let test = WeatherResponse(weather: [weatherTest], main: mainTest, dt: 1, sys: sysTest)
        let weatherModelTest = WeatherModel(apiModel: test)
        
        XCTAssertEqual(weatherModelTest.conditionName, "cloud.snow")
    }
    
    func testWeatherModelconditionNameShouldreturnCloudFog() {
        
        let weatherTest = Weather(id: 710, main: "clear")
        let mainTest = Main(temp: 1)
        let sysTest = Sys(sunrise: 1, sunset: 1)
        let test = WeatherResponse(weather: [weatherTest], main: mainTest, dt: 1, sys: sysTest)
        let weatherModelTest = WeatherModel(apiModel: test)
        
        XCTAssertEqual(weatherModelTest.conditionName, "cloud.fog")
    }
    
    func testWeatherModelconditionNameShouldreturnMoonStars() {
        
        let weatherTest = Weather(id: 800, main: "clear")
        let mainTest = Main(temp: 1)
        let sysTest = Sys(sunrise: 2, sunset: 1)
        let test = WeatherResponse(weather: [weatherTest], main: mainTest, dt: 1, sys: sysTest)
        let weatherModelTest = WeatherModel(apiModel: test)
        
        XCTAssertEqual(weatherModelTest.conditionName, "moon.stars")
    }
    
    func testWeatherModelconditionNameShouldreturnCloudByDefault() {
        
        let weatherTest = Weather(id: 5, main: "clear")
        let mainTest = Main(temp: 1)
        let sysTest = Sys(sunrise: 1, sunset: 1)
        let test = WeatherResponse(weather: [weatherTest], main: mainTest, dt: 1, sys: sysTest)
        let weatherModelTest = WeatherModel(apiModel: test)
        
        XCTAssertEqual(weatherModelTest.conditionName, "cloud")
    }
    
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
    
    func testWeatherModeltemperatureStringShouldreturnOneDecimale() {
        // Given
        let WeatherService = WeatherService(
            session: URLSessionFake(data: FakeWeatherResponseData.WeatherCorrectData, response: FakeWeatherResponseData.responseOK, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        WeatherService.fetchJSON (city: testText) { error, weather in
            //Then
            XCTAssertEqual(weather?.temperatureString, "23.4")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}


