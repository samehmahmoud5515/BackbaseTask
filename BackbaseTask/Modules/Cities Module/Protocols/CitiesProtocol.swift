//
//  CitiesProtocol.swift
//  BackbaseTask
//
//  Created by SAMEH on 07/06/2021.
//

import Foundation

protocol CitiesViewControllerProtocol: class {
    
}

protocol CitiesPresenterProtocol: CitiesPresenterDatasourceProtocol {
    //func setupCellUI(_ cell: HomePostsCellProtocol, index: Int)
    //func didTappedCell(at index: Int)
    func fetchCities()
}

protocol CitiesPresenterDatasourceProtocol {
    func getCities()
    func getCitiesCount() -> Int
}
