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
    func fetchCities()
    func searchCities(qurey: String)
    func navigateToCityDetails(with index: Int)
}

protocol CitiesPresenterDatasourceProtocol {
    func getCity(for index: Int) -> City
    func getCitiesCount() -> Int
}

protocol CitiesRouterProtocol: AnyObject {
    func goTo(route: CitiesRouter.CitiesRoute)
}

protocol CitiesInteractorProtocol: AnyObject {
    var isSearchReady: Bool { get }
    func loadAllCities(with completion: @escaping ([City]?) -> Void)
    func searchAllCities(qurey: String, completion: @escaping ([City]?) -> Void)
}
