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

    override func setUp() {
        super.setUp()
        let dataProvider = CitiesDataProviderMock()
        interactor = CitiesInteractor(dataProvider: dataProvider)
    }

    override func tearDown() {
        interactor = nil
    }
    
    func testSearchAllCitiesWithEmptyQuery() {
        let expectation = XCTestExpectation(description: "fetch did complete")
        
        var loadedCities: [City] = []
        interactor.loadAllCities { cities in
            self.interactor.buildTree(with: cities ?? [])
            self.interactor.searchAllCities(qurey: "") { citiesResults in
                loadedCities = citiesResults ?? []
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 2)
        
        XCTAssertEqual(loadedCities.count, 359)
        XCTAssertTrue(interactor.isSearchReady)
        XCTAssertEqual(loadedCities.first?.name, "Alfortville")
    }
    
    func testSearchAllCitiesWithSimpleQuery() {
        let expectation = XCTestExpectation(description: "fetch did complete")
        
        var loadedCities: [City] = []
        interactor.loadAllCities { cities in
            self.interactor.buildTree(with: cities ?? [])
            self.interactor.searchAllCities(qurey: "M") { citiesResults in
                loadedCities = citiesResults ?? []
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 2)
        
        XCTAssertEqual(loadedCities.count, 31)
        XCTAssertTrue(interactor.isSearchReady)
        XCTAssertEqual(loadedCities.first?.name, "Maesteg")
    }
    
    func testSearchAllCitiesWithQuery() {
        let expectation = XCTestExpectation(description: "fetch did complete")
        
        var loadedCities: [City] = []
        interactor.loadAllCities { cities in
            self.interactor.buildTree(with: cities ?? [])
            self.interactor.searchAllCities(qurey: "MAN") { citiesResults in
                loadedCities = citiesResults ?? []
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 2)
        
        XCTAssertEqual(loadedCities.count, 2)
        XCTAssertTrue(interactor.isSearchReady)
        XCTAssertEqual(loadedCities.first?.name, "Mangai")
    }
    
    
    func testSearchAllCitiesWithQueryEmptyResults() {
        let expectation = XCTestExpectation(description: "fetch did complete")
        
        var loadedCities: [City] = []
        interactor.loadAllCities { cities in
            self.interactor.buildTree(with: cities ?? [])
            self.interactor.searchAllCities(qurey: "fasdfdsafads") { citiesResults in
                loadedCities = citiesResults ?? []
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 2)
        
        XCTAssertEqual(loadedCities.count, 0)
        XCTAssertTrue(interactor.isSearchReady)
    }
    
    func testLoadAllCities() {

        var loadedCities: [City] = []
        let expectation = XCTestExpectation(description: "fetch did complete")
        interactor.loadAllCities { cities in
            loadedCities = cities ?? []
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
        
        XCTAssertEqual(loadedCities.count, 359)
        XCTAssertEqual(loadedCities.first?.name, "Alfortville")
    }
}
