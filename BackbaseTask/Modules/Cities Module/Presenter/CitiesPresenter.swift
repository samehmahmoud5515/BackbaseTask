//
//  CitiesPresenter.swift
//  BackbaseTask
//
//  Created by SAMEH on 07/06/2021.
//

import Foundation

class CitiesPresenter: CitiesPresenterProtocol {
        
    var cities: [City] = []
    
    private weak var view: CitiesViewControllerProtocol?
    private let interactor: CitiesInteractorProtocol
    private let router: CitiesRouterProtocol

    init(
        view: CitiesViewControllerProtocol,
        interactor: CitiesInteractorProtocol,
        wireframe: CitiesRouterProtocol
    ) {
        self.view = view
        self.interactor = interactor
        self.router = wireframe
    }
    
    // MARK: - Lifecycle
    func viewDidLoad() {
        view?.setupUI()
        fetchCities()
    }
    
    func viewWillAppear() {
        view?.setupNaviagtionController()
    }
}

extension CitiesPresenter {
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
    
    func searchTextChanged(wihtQurey qurey: String) {
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
}

extension CitiesPresenter {
    var citiesCount: Int {
        return cities.count
    }
    
    func configure(cityCell cell: CityCellViewProtocol, atIndexPath indexPath: IndexPath) {
        let city = cities[indexPath.row]
        cell.updateUI(with: city)
    }
}

// MARK: - Navigation
extension CitiesPresenter {
    func cityCell(selectedAt indexPath: IndexPath) {
        let city = cities[indexPath.row]
        router.goTo(route: .cityDetails(city: city))
    }
}
