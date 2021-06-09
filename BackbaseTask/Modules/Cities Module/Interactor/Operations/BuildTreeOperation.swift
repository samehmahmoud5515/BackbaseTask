//
//  BuildTreeOperation.swift
//  BackbaseTask
//
//  Created by SAMEH on 08/06/2021.
//

import Foundation

final class BuildTreeOperation: Operation {
    
    let response: CitiesResponse
    private(set) var tree: CitiesTree?
    
    init(response: CitiesResponse) {
        self.response = response
    }

    override func main() {
        // 2
        print("BuildTreeOperation Started \(Date())")
        buildCitiesTree(with: response)
        print("BuildTreeOperation Done \(Date())")
    }
    
    fileprivate func buildCitiesTree(with response: CitiesResponse) {
        let citiesTree = CitiesTree()
        response.forEach { city in
            citiesTree.append(city: city)
        }
        tree = citiesTree
    }
}
