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
        guard let cities = cities else { return }
        print("SortCitiesOperation Started \(Date())")
        self.cities = cities.sorted()
        print("SortCitiesOperation Done \(Date())")
    }
}
