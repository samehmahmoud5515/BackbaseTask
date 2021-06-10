//
//  CitiesDataProvider.swift
//  BackbaseTask
//
//  Created by SAMEH on 10/06/2021.
//

import Foundation

class CitiesDataProvider: CitiesDataProviderProtocol {
    
    var fileName: String {
        return "cities"
    }
    
    var bundle: Bundle {
        return Bundle.main
    }
    
    func loadCities() -> Data? {
        do {
            let path = getPath()
            guard let url = URL(string: path)
                else { return nil }
            return try Data(contentsOf: url, options: .uncached)
        } catch {
        }
        return nil
    }
    
    private func getPath() -> String {
        return bundle.url(
            forResource: fileName,
            withExtension: "json")?.absoluteString ?? ""
    }
}
