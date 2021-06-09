//
//  CityDetailsProtocols.swift
//  BackbaseTask
//
//  Created by SAMEH on 09/06/2021.
//

import UIKit

protocol CityDetailsRouterProtocol {
}

protocol CityDetailsViewControllerProtocol: AnyObject {
    func setupUI()
}

protocol CityDetailsPresenterProtocol {
    func viewDidLoad()
    func getCityCoordinate() -> City.Coordinate
    func getCityTitle() -> String
}

protocol CityDetailsInteractorProtocol {
}
