//
//  CitiesViewControllerTests.swift
//  BackbaseTaskTests
//
//  Created by SAMEH on 05/06/2021.
//

import XCTest
@testable import BackbaseTask

class CitiesViewControllerTests: XCTestCase {

    var viewController: CitiesViewController!

    override func setUp() {
        super.setUp()
        viewController = CitiesViewController()
        let interactor = CitiesInteractorMock()
        let router = CitiesRouter()
        let presenter =
            CitiesPresenter(view: viewController, interactor: interactor, router: router)
        viewController.presenter = presenter
        viewController.loadViewIfNeeded()
    }

    override func tearDown() {
        viewController = nil
    }
    
    func testViewDidLoad() {
        viewController.viewDidLoad()
        XCTAssertEqual(viewController.navigationItem.title, "Cities")
    }

    func testTableViewCellForRowAt() {
        viewController.viewDidLoad()
        let cell = viewController.tableView(viewController.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? CityTableViewCell
        XCTAssertEqual(cell?.cityTitleLabel.text, "London (UK)")
    }
    
    func testTableViewNumberOfRowsInSection() {
        viewController.viewDidLoad()
        let numberOfItems = viewController.tableView(viewController.tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(numberOfItems, 2)
    }
}
