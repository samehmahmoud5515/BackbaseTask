//
//  CitiesInteractorTests.swift
//  BackbaseTaskTests
//
//  Created by SAMEH on 10/06/2021.
//

import XCTest
@testable import BackbaseTask

class CitiesInteractorTests: XCTestCase {

    var interactor: CitiesInteractor!
    var cities: [City]?

    override func setUp() {
        super.setUp()
        interactor = CitiesInteractor()
    }

    override func tearDown() {
        interactor = nil
    }
    
    func testSearchAllCitiesWithEmptyQuery() {
        appendCities()
        guard var cities = cities else { return }
        cities.sort()
        var loadedCities: [City]? = []
        let expectation = XCTestExpectation(description: "fetch did complete")
        interactor.buildTree(with: cities)
        interactor.searchAllCities(qurey: "") { citiesResults in
            loadedCities = citiesResults
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
        
        XCTAssertEqual(loadedCities?.count, 4)
        XCTAssertTrue(interactor.isSearchReady)
        XCTAssertEqual(loadedCities?.first?.name, "Amsterdam")
    }
    
    func testSearchAllCitiesWithQuery() {
        appendCities()
        guard var cities = cities else { return }
        cities.sort()
        var loadedCities: [City]? = []
        let expectation = XCTestExpectation(description: "fetch did complete")
        interactor.buildTree(with: cities)
        interactor.searchAllCities(qurey: "Cairo") { citiesResults in
            loadedCities = citiesResults
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
        
        XCTAssertEqual(loadedCities?.count, 1)
        XCTAssertTrue(interactor.isSearchReady)
        XCTAssertEqual(loadedCities?.first?.name, "Cairo")
    }

}

extension CitiesInteractorTests {
    func appendCities() {
        var cities: [City] = []
        cities.append(City(country: "UK", name: "London", id: 123, coord: City.Coordinate(lon: 0.0, lat: 0.0)))
        cities.append(City(country: "EG", name: "Cairo", id: 1234, coord: City.Coordinate(lon: 0.0, lat: 0.0)))
        cities.append(City(country: "US", name: "Dallas", id: 1234, coord: City.Coordinate(lon: 0.0, lat: 0.0)))
        cities.append(City(country: "NL", name: "Amsterdam", id: 1234, coord: City.Coordinate(lon: 0.0, lat: 0.0)))
        self.cities = cities
    }
}
