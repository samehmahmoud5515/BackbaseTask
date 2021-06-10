//
//  CitiesPresenterTest.swift
//  BackbaseTaskTests
//
//  Created by SAMEH on 10/06/2021.
//

import XCTest
@testable import BackbaseTask

class CitiesPresenterTest: XCTestCase {

    var presenter: CitiesPresenter!

    override func setUp() {
        super.setUp()
        let router = CitiesRouter()
        let view = CitiesViewController()
        let interactor = CitiesInteractorMock()
        presenter = CitiesPresenter(view: view, interactor: interactor, router: router)
    }

    override func tearDown() {
        presenter = nil
    }
    
    func testFetchCities() {
        presenter.fetchCities()
        XCTAssertEqual(presenter.cities.count, 2)
        XCTAssertEqual(presenter.citiesCount, 2)
    }
    
    func testSearchTextChanged() {
        presenter.searchTextChanged(wihtQurey: "Cairo")
        XCTAssertEqual(presenter.cities.count, 1)
    }
}

