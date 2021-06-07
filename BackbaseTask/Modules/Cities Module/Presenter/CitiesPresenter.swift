//
//  CitiesPresenter.swift
//  BackbaseTask
//
//  Created by SAMEH on 07/06/2021.
//

import Foundation

class CitiesPresenter {
    
    weak var view: CitiesViewControllerProtocol?
    
    init(view: CitiesViewControllerProtocol) {
        self.view = view
    }
}

extension CitiesPresenter: CitiesPresenterProtocol {
    func fetchCities() {
        
    }
    
    func getCities() {
        
    }
    
    func getCitiesCount() -> Int {
        return 10
    }
}
