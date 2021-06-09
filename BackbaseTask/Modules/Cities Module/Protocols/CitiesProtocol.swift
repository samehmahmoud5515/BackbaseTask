//
//  CitiesProtocol.swift
//  BackbaseTask
//
//  Created by SAMEH on 07/06/2021.
//

import Foundation

protocol CitiesViewControllerProtocol: class {
    func reloadData()
    func startLoadingIndicator()
    func stopLoadingIndicator()
}

protocol CitiesPresenterProtocol: CitiesPresenterDatasourceProtocol {
    //func setupCellUI(_ cell: HomePostsCellProtocol, index: Int)
    //func didTappedCell(at index: Int)
    func fetchCities()
    func searchCities(qurey: String)
}

protocol CitiesPresenterDatasourceProtocol {
    func getCity(for index: Int) -> City
    func getCitiesCount() -> Int
}

protocol CitiesRouterProtocol: AnyObject {
    //func go(to )
}

protocol CitiesInteractorProtocol: AnyObject {
    var isSearchReady: Bool { get }
    func loadAllCities(with completion: @escaping ([City]?) -> Void)
    func searchAllCities(qurey: String, completion: @escaping ([City]?) -> Void)
}
