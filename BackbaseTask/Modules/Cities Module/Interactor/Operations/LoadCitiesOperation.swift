//
//  LoadCitiesOperation.swift
//  BackbaseTask
//
//  Created by SAMEH on 08/06/2021.
//

import Foundation

final class LoadCitiesOperation: Operation {
    
    var response: CitiesResponse?

    override func main() {
        print("LoadCitiesOperation Started \(Date())")
        guard !isCancelled else { return }

        guard let citiesData = loadJson(),
              let citiesResponse = decodeJson(data: citiesData)
            else { return }
        response = citiesResponse
        print("LoadCitiesOperation Done \(Date())")
    }
    
    private func loadJson() -> Data? {
        do {
            guard let url = Bundle.main.url(forResource: "cities", withExtension: "json")
                else { return nil }
            return try Data(contentsOf: url, options: .uncached)
        } catch {
        }
        return nil
    }
    
    private func decodeJson(data: Data) -> CitiesResponse? {
        do {
            return try JSONDecoder().decode(CitiesResponse.self, from: data)
        } catch {
        }
        return nil
    }
}

