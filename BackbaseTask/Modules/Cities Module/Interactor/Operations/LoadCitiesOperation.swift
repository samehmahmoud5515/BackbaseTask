//
//  LoadCitiesOperation.swift
//  BackbaseTask
//
//  Created by SAMEH on 08/06/2021.
//

import Foundation

final class LoadCitiesOperation: Operation {
    
    var response: CitiesResponse?
    var dataProvider: CitiesDataProviderProtocol
    
    init(dataProvider: CitiesDataProviderProtocol) {
        self.dataProvider = dataProvider
    }

    override func main() {
        print("LoadCitiesOperation Started \(Date())")
        guard !isCancelled else { return }

        guard let citiesData = dataProvider.loadCities(),
              let citiesResponse = decodeJson(data: citiesData)
            else { return }
        response = citiesResponse
        print("LoadCitiesOperation Done \(Date())")
    }
    
    private func decodeJson(data: Data) -> CitiesResponse? {
        do {
            return try JSONDecoder().decode(CitiesResponse.self, from: data)
        } catch {
        }
        return nil
    }
}

