//
//  SearchCitiesOperation.swift
//  BackbaseTask
//
//  Created by SAMEH on 09/06/2021.
//

import Foundation

final class SearchCitiesOperation: Operation {

    private let qurey: String
    var cities: [City]?
    var filterdCities: [City] = []
    
    init(qurey: String) {
        self.qurey = qurey
    }

    override func main() {
        guard let cities = cities else { return }
        print("SearchCitiesOperation Started \(Date())")
        filterdCities = binarySearch(index: 0, keyword: qurey.map { String($0) }, str: cities)
        print("SearchCitiesOperation Done \(Date())")
    }
    
    func lowerBinarySearch(index: Int, keyword: [String], str: [[String]], lower: Int? = nil, upper: Int? = nil) -> Int? {
        var lowerIndex = lower ?? 0
        var upperIndex = upper ?? str.count - 1

        while true {
            var currentIndex = (lowerIndex + upperIndex)/2
            
            if str[currentIndex].count <= index {
                return nil
            }
            
            if (str[currentIndex][index] == keyword[index]) {
                while currentIndex >= 0 && (str[currentIndex][index] == keyword[index]) {
                    currentIndex = currentIndex - 1
                }
                currentIndex = currentIndex + 1
                return currentIndex
            } else if (lowerIndex > upperIndex) {
                return nil
            } else {
                if (str[currentIndex][index] > keyword[index]) {
                    upperIndex = currentIndex - 1
                } else {
                    lowerIndex = currentIndex + 1
                }
            }
        }
    }

    func binarySearch(index: Int, keyword: [String], str: [City], lower: Int? = nil, upper: Int? = nil) -> [City] {
        
        if index == keyword.count {
            var array = [City]()
            for i in (lower ?? 0)...(upper ?? 0) {
                array.append(str[i])
            }
            return array
        }
        
        let citiesStr = str.map { $0.name.map { String($0) } }
        
        let upper_ = upperBinarySearch(index: index, keyword: keyword, str: citiesStr, lower: lower, upper: upper)
        let lower_ = lowerBinarySearch(index: index, keyword: keyword, str: citiesStr, lower: lower, upper: upper)
        
        return binarySearch(index: index + 1, keyword: keyword, str: str, lower: lower_, upper: upper_)
    }


    func upperBinarySearch(index: Int, keyword: [String], str: [[String]], lower: Int? = nil, upper: Int? = nil) -> Int? {
        
        var lowerIndex = lower ?? 0
        var upperIndex = upper ?? str.count - 1

        while true {
            var currentIndex = (lowerIndex + upperIndex)/2
            if str[currentIndex].count <= index {
                return nil
            }
            
            if (str[currentIndex][index] == keyword[index]) {
                while currentIndex < str.count && (str[currentIndex][index] == keyword[index]) {
                    currentIndex = currentIndex + 1
                }
                currentIndex = currentIndex - 1
                return currentIndex
            } else if (lowerIndex > upperIndex) {
                return nil
            } else {
                if (str[currentIndex][index] > keyword[index]) {
                    upperIndex = currentIndex - 1
                } else {
                    lowerIndex = currentIndex + 1
                }
            }
        }
    }
}
