//
//  CitiesDataProviderMock.swift
//  BackbaseTaskTests
//
//  Created by SAMEH on 10/06/2021.
//

import XCTest
@testable import BackbaseTask

class CitiesDataProviderMock: CitiesDataProvider {
    override var fileName: String {
        return "cities_mock"
    }
    
    override var bundle: Bundle {
        return Bundle.unitTest
    }
}
