//
//  CitiesInteractorMock.swift
//  BackbaseTaskTests
//
//  Created by SAMEH on 10/06/2021.
//

import XCTest
@testable import BackbaseTask

class CitiesInteractorMock: CitiesInteractorProtocol {
    var isSearchReady: Bool = true
    
    func loadAllCities(with completion: @escaping ([City]?) -> Void) {
        var cities = [City]()
        cities.append(City(country: "UK", name: "London", id: 123, coord: City.Coordinate(lon: 0.0, lat: 0.0)))
        cities.append(City(country: "EG", name: "Cairo", id: 1234, coord: City.Coordinate(lon: 0.0, lat: 0.0)))
        completion(cities)
    }
    
    func searchAllCities(qurey: String, completion: @escaping ([City]?) -> Void) {
        var cities = [City]()
        cities.append(City(country: "EG", name: "Cairo", id: 1234, coord: City.Coordinate(lon: 0.0, lat: 0.0)))
        completion(cities)
    }
}
