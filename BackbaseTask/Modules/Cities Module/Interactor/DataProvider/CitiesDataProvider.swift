//
//  CitiesDataProvider.swift
//  BackbaseTask
//
//  Created by SAMEH on 10/06/2021.
//

import Foundation

class CitiesDataProvider: CitiesDataProviderProtocol {
    
    var fileName: String = ""
    
    func loadCities() -> Data? {
        do {
            guard let url = Bundle.main.url(forResource: fileName, withExtension: "json")
                else { return nil }
            return try Data(contentsOf: url, options: .uncached)
        } catch {
        }
        return nil
    }
    
}
