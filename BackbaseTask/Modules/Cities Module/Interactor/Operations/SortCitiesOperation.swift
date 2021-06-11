//
//  SortCitiesOperation.swift
//  BackbaseTask
//
//  Created by SAMEH on 08/06/2021.
//

import Foundation

final class SortCitiesOperation: Operation {

    var cities: CitiesResponse?

    override func main() {
        guard !isCancelled else { return }
        guard let cities = cities else { return }
        self.cities = cities.sorted()
    }
}
