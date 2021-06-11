//
//  CitiesInteractor.swift
//  BackbaseTask
//
//  Created by SAMEH on 08/06/2021.
//

import Foundation

class CitiesInteractor: CitiesInteractorProtocol {
    
    var cities: [City] = []
    var dataProvider: CitiesDataProviderProtocol
    
    init(dataProvider: CitiesDataProviderProtocol = CitiesDataProvider()) {
        self.dataProvider = dataProvider
    }
    
    private lazy var loadCitiesQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.qualityOfService = .userInitiated
        return queue
    }()
    
    private lazy var searchQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.qualityOfService = .userInitiated
        queue.maxConcurrentOperationCount = 1
        return queue
    }()

    
    func loadAllCities(with completion: @escaping ([City]?) -> Void) {
        
        let loadCitiesOperation = LoadCitiesOperation(dataProvider: dataProvider)
        let sortCitiesOperation = SortCitiesOperation()
        let sortLoadAdapterOperation = BlockOperation() { [unowned sortCitiesOperation, unowned loadCitiesOperation] in
            sortCitiesOperation.cities = loadCitiesOperation.response
        }
        
        // Adding operation dependencies
        sortLoadAdapterOperation.addDependency(loadCitiesOperation)
        sortCitiesOperation.addDependency(sortLoadAdapterOperation)
        
        sortCitiesOperation.completionBlock = { [weak self] in
            guard let self = self,
                  let cities = sortCitiesOperation.cities
                else { return }
            self.cities = cities
            completion(cities)
        }

        // Adding all the operation to the Queue
        loadCitiesQueue.addOperations([loadCitiesOperation, sortCitiesOperation, sortLoadAdapterOperation], waitUntilFinished: false)
    }
    
    func searchAllCities(qurey: String, completion: @escaping ([City]?) -> Void) {
        
        // Cancel Search Operation if another search is Done
        searchQueue.cancelAllOperations()
                
        let searchOperation = SearchCitiesOperation(qurey: qurey)
        searchOperation.cities = cities
        searchQueue.addOperation(searchOperation)
        
        searchOperation.completionBlock = {
            completion(searchOperation.filterdCities)
        }
    }

}
