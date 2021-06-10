//
//  CitiesPresenter.swift
//  BackbaseTask
//
//  Created by SAMEH on 07/06/2021.
//

import Foundation

class CitiesPresenter: CitiesPresenterProtocol {
        
    var cities: [City] = []
    
    weak var view: CitiesViewControllerProtocol?
    let interactor: CitiesInteractorProtocol
    let router: CitiesRouterProtocol

    init(
        view: CitiesViewControllerProtocol,
        interactor: CitiesInteractorProtocol,
        router: CitiesRouterProtocol
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
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
    
    func searchDidCanceled() {
        interactor.searchAllCities(qurey: "") { cities in
            guard let cities = cities
                else { return }
            self.cities = cities
            DispatchQueue.main.async {
                self.view?.reloadData()
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
