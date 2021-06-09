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
    
    init(tree: CitiesTree?, qurey: String) {
        self.tree = tree
        self.qurey = qurey
    }

    override func main() {
        guard let tree = tree else { return }
        cities = qurey.isEmpty ? tree.getAllCities() : tree.getCities(withPrefix: qurey)
    }
}
