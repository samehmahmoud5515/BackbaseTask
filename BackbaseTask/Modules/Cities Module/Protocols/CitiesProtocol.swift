//
//  CitiesProtocol.swift
//  BackbaseTask
//
//  Created by SAMEH on 07/06/2021.
//

import Foundation

protocol CitiesViewControllerProtocol: AnyObject {
    func setupUI()
    func setupNaviagtionController()
    func reloadData()
    func startLoadingIndicator()
    func stopLoadingIndicator()
}

protocol CitiesPresenterProtocol: CitiesPresenterDatasourceProtocol {
    func viewDidLoad()
    func viewWillAppear()
    func searchTextChanged(wihtQurey qurey: String)
    func searchDidCanceled()
    
    func cityCell(selectedAt indexPath: IndexPath)
}

protocol CitiesPresenterDatasourceProtocol {
    var citiesCount: Int { get }
    func configure(cityCell cell: CityCellViewProtocol , atIndexPath indexPath: IndexPath)
}

protocol CitiesRouterProtocol: AnyObject {
    func goTo(route: CitiesRouter.CitiesRoute)
}

protocol CitiesInteractorProtocol: AnyObject {
    func loadAllCities(with completion: @escaping ([City]?) -> Void)
    func searchAllCities(qurey: String, completion: @escaping ([City]?) -> Void)
}

protocol CityCellViewProtocol {
    func updateUI(with city: City)
}

protocol CitiesDataProviderProtocol {
    func loadCities() -> Data?
}
