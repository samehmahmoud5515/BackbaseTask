//
//  CitiesPresenter.swift
//  BackbaseTask
//
//  Created by SAMEH on 07/06/2021.
//

import Foundation

class CitiesPresenter {
        
    var cities: [City] = []
    
    private weak var view: CitiesViewControllerProtocol?
    private let interactor: CitiesInteractorProtocol
    private let router: CitiesRouterProtocol

    // MARK: - Lifecycle -

    init(
        view: CitiesViewControllerProtocol,
        interactor: CitiesInteractorProtocol,
        wireframe: CitiesRouterProtocol
    ) {
        self.view = view
        self.interactor = interactor
        self.router = wireframe
    }
}

extension CitiesPresenter: CitiesPresenterProtocol {
    
    func fetchCities() {
        view?.startLoadingIndicator()
        interactor.loadAllCities { [weak self] cities in
            guard let cities = cities
                else { return }
            self?.cities = cities
            
            // Reload Data in MainThread
            DispatchQueue.main.async {
                self?.view?.stopLoadingIndicator()
                self?.view?.reloadData()
            }
        }
    }
    
    func searchCities(qurey: String) {
        if !interactor.isSearchReady {
            view?.startLoadingIndicator()
        }
        interactor.searchAllCities(qurey: qurey) { cities in
            guard let cities = cities
                else { return }
            self.cities = cities
            DispatchQueue.main.async {
                self.view?.reloadData()
                self.view?.stopLoadingIndicator()
            }
        }
    }    
    
    func getCity(for index: Int) -> City {
        return cities[index]
    }
    
    func getCitiesCount() -> Int {
        return cities.count
    }
}

// MARK: - Navigation
extension CitiesPresenter {
    func navigateToCityDetails(with index: Int) {
        let city = cities[index]
        router.goTo(route: .cityDetails(city: city))
    }
}
