//
//  CitiesRouter.swift
//  BackbaseTask
//
//  Created by SAMEH on 08/06/2021.
//

import UIKit

class CitiesRouter {
    
    let viewController: UIViewController

    init() {
        let view = CitiesViewController()
        viewController = view

        let interactor = CitiesInteractor()
        let presenter = CitiesPresenter(view: view, interactor: interactor, wireframe: self)
        view.presenter = presenter
    }

}

extension CitiesRouter: CitiesRouterProtocol {
    
}
