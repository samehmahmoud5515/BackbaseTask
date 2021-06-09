//
//  CityDetailsRouter.swift
//  BackbaseTask
//
//  Created by SAMEH on 09/06/2021.
//

import UIKit

final class CityDetailsRouter {

    // MARK: - Module setup -
    let viewController: UIViewController

    init(city: City) {
        let view = CityDetailsViewController()
        viewController = view

        let interactor = CityDetailsInteractor()
        let presenter = CityDetailsPresenter(view: view,
                                             interactor: interactor,
                                             router: self,
                                             city: city)
        view.presenter = presenter
    }

}

// MARK: - Extensions -

extension CityDetailsRouter: CityDetailsRouterProtocol {
}
