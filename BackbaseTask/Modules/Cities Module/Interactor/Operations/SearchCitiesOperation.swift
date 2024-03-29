//
//  SearchCitiesOperation.swift
//  BackbaseTask
//
//  Created by SAMEH on 09/06/2021.
//

import Foundation

final class SearchCitiesOperation: Operation {

    var tree: CitiesTree?
    private let qurey: String
    var cities: [City]?
    var searchCitiesLimit: SearchCitiesLimit = .all
    
    init(tree: CitiesTree?, qurey: String) {
        self.tree = tree
        self.qurey = qurey
    }

    override func main() {
        guard !isCancelled else { return }
        guard let tree = tree else { return }
        switch (qurey.isEmpty, searchCitiesLimit) {
        case (true, .all):
            cities = tree.getAllCities()
        case (true, .custom(let count)):
            cities = tree.getFirstCities(count: count)
        case (false, _):
            cities = tree.getCities(withPrefix: qurey)
        }
    }
}

enum SearchCitiesLimit {
    case all
    case custom(count: Int)
}
