//
//  CityDetailsPresenter.swift
//  BackbaseTask
//
//  Created by SAMEH on 09/06/2021.
//

import Foundation

final class CityDetailsPresenter {

    private weak var view: CityDetailsViewControllerProtocol?
    private let interactor: CityDetailsInteractorProtocol
    private let router: CityDetailsRouterProtocol
    let city: City

    init(
        view: CityDetailsViewControllerProtocol,
        interactor: CityDetailsInteractorProtocol,
        router: CityDetailsRouterProtocol,
        city: City
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.city = city
    }
}

// MARK: - Extensions -
extension CityDetailsPresenter: CityDetailsPresenterProtocol {
    func getCityCoordinate() -> City.Coordinate {
        return city.coord
    }
    
    func getCityTitle() -> String {
        return "\(city.name) (\(city.country))"
    }
}
