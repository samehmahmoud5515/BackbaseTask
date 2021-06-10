//
//  CitiesInteractor.swift
//  BackbaseTask
//
//  Created by SAMEH on 08/06/2021.
//

import Foundation

class CitiesInteractor: CitiesInteractorProtocol {
    
    var tree: CitiesTree?
    var isSearchReady: Bool {
        return tree != nil
    }
    
    lazy var loadCitiesQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.qualityOfService = .userInitiated
        return queue
    }()
    
    lazy var searchQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.qualityOfService = .userInitiated
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
    
    lazy var buildTreeQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.qualityOfService = .userInitiated
        return queue
    }()
    
    func loadAllCities(with completion: @escaping ([City]?) -> Void) {
        
        let loadCitiesOperation = LoadCitiesOperation()
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
            self.buildTree(with: cities)
            completion(cities)
        }

        // Adding all the operation to the Queue
        loadCitiesQueue.addOperations([loadCitiesOperation, sortCitiesOperation, sortLoadAdapterOperation], waitUntilFinished: false)
    }
    
    func buildTree(with cities: [City]) {
        let buildTreeOperation = BuildTreeOperation(response: cities)
        buildTreeOperation.completionBlock = { [weak self] in
            guard let self = self,
                  let tree = buildTreeOperation.tree
                else { return }
            self.tree = tree
        }
        buildTreeQueue.addOperation(buildTreeOperation)
    }
    
    func searchAllCities(qurey: String, completion: @escaping ([City]?) -> Void) {
        
        // Cancel Search Operation if another search is Done
        searchQueue.cancelAllOperations()
        
        let searchOperation = SearchCitiesOperation(tree: tree, qurey: qurey)
        
        // If the build tree operation is not finished yet we wait unit it finishes then add search operation
        if let buildTreeOperation = buildTreeQueue.operations.first as? BuildTreeOperation, !buildTreeOperation.isFinished {
            // update completion block for build tree operation
            buildTreeOperation.completionBlock = { [weak self] in
                guard let self = self
                    else { return }
                self.tree = buildTreeOperation.tree
                searchOperation.tree = buildTreeOperation.tree
                self.searchQueue.addOperation(searchOperation)
            }
        } else {
            if qurey.isEmpty {
                searchOperation.searchCitiesLimit = .custom(count: 1000)
                searchQueue.addOperation(searchOperation)
                getAllCities(completion: completion)
            } else {
                searchOperation.searchCitiesLimit = .all
                searchQueue.addOperation(searchOperation)
            }
        }
        
        searchOperation.completionBlock = {
            completion(searchOperation.cities)
        }
    }
    
    private func getAllCities(completion: @escaping ([City]?) -> Void) {
        guard let tree = tree else { return }
        let searchOperation = SearchCitiesOperation(tree: tree, qurey: "")
        searchOperation.searchCitiesLimit = .all
        searchOperation.completionBlock = {
            completion(searchOperation.cities)
        }
        searchQueue.addOperation(searchOperation)
    }

}
