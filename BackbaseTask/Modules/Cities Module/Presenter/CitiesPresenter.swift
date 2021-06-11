//
//  CitiesPresenter.swift
//  BackbaseTask
//
//  Created by SAMEH on 07/06/2021.
//

import Foundation

class CitiesPresenter: CitiesPresenterProtocol {
        
    var filtedCities: [City] = []
    
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
            self?.filtedCities = cities
            // Reload Data in MainThread
            DispatchQueue.main.async {
                self?.view?.stopLoadingIndicator()
                self?.view?.reloadData()
            }
        }
    }
    
    func searchTextChanged(wihtQurey qurey: String) {
        interactor.searchAllCities(qurey: qurey) { cities in
            guard let cities = cities
                else { return }
            self.filtedCities = cities
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
            self.filtedCities = cities
            DispatchQueue.main.async {
                self.view?.reloadData()
            }
        }
    }
}

extension CitiesPresenter {
    var citiesCount: Int {
        return filtedCities.count
    }
    
    func configure(cityCell cell: CityCellViewProtocol, atIndexPath indexPath: IndexPath) {
        let city = filtedCities[indexPath.row]
        cell.updateUI(with: city)
    }
}

// MARK: - Navigation
extension CitiesPresenter {
    func cityCell(selectedAt indexPath: IndexPath) {
        let city = filtedCities[indexPath.row]
        router.goTo(route: .cityDetails(city: city))
    }
}
