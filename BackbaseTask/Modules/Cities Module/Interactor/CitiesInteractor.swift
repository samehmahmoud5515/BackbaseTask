//
//  CitiesInteractor.swift
//  BackbaseTask
//
//  Created by SAMEH on 08/06/2021.
//

import Foundation

class CitiesInteractor: CitiesInteractorProtocol {
    
    var tree: CitiesTree?
    
    lazy var loadDataQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "Load Json Queue"
        queue.qualityOfService = .userInitiated
        return queue
    }()
    
    lazy var searchQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "Download queue"
        queue.qualityOfService = .userInitiated
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
    
    lazy var buildTreeQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "Build tree queue"
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
        
        sortCitiesOperation.completionBlock = {
            guard let cities = sortCitiesOperation.cities else { return }
            self.buildTree(with: cities)
            completion(cities)
        }

        // Adding all the operation to the Queue
        loadDataQueue.addOperations([loadCitiesOperation, sortCitiesOperation, sortLoadAdapterOperation], waitUntilFinished: false)
    }
    
    func buildTree(with cities: [City]) {
        let buildTreeOperation = BuildTreeOperation(response: cities)
        buildTreeOperation.completionBlock = {
            guard let tree = buildTreeOperation.tree else { return }
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
            
            buildTreeOperation.completionBlock = {
                self.tree = buildTreeOperation.tree
                searchOperation.tree = buildTreeOperation.tree
                self.searchQueue.addOperation(searchOperation)
            }
        } else {
            searchQueue.addOperation(searchOperation)
        }
        
        searchOperation.completionBlock = {
            completion(searchOperation.cities)
        }
    }

}

extension CitiesInteractor {
    var isSearchReady: Bool {
        return tree != nil
    }
}
