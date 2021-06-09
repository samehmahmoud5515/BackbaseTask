//
//  CitiesTree.swift
//  BackbaseTask
//
//  Created by SAMEH on 08/06/2021.
//

import Foundation

class CityTreeNode {
    var key: String = ""
    var city: [City] = [City]()
    var children: [CityTreeNode] = [CityTreeNode]()
}

class CitiesTree {
    //
    var root = CityTreeNode()
    
    func append(city: City) {
        addCity(city: city, parent: root)
    }
    
    fileprivate func addCity(keyIndex: Int = 0, city: City, parent: CityTreeNode) {
        
        // base condition
        if keyIndex - 1 == city.name.count {
            parent.city.append(city)
            return
        }
        
        // if have a child so go to next
        if let cityChild = parent.children.first(where: { city.name.lowercased()[keyIndex] == $0.key.lowercased() }) {
            addCity(keyIndex: keyIndex + 1, city: city, parent: cityChild)
        } else {
           
            // doesn't have a child, so add child with the key then go to next
            let cityNode = CityTreeNode()
            cityNode.key = city.name.lowercased()[keyIndex]
            
            parent.children.append(cityNode)
            addCity(keyIndex: keyIndex + 1, city: city, parent: cityNode)
        }
    }
    
    func getCities(withPrefix prefix: String) -> [City] {
        return getCities(prefix: prefix.lowercased(), parent: root)
    }
    
    fileprivate func getCities(for node: CityTreeNode) -> [City] {
        var cities = [City]()
       
        cities.append(contentsOf: node.city)
      
        for child in node.children {
            cities.append(contentsOf: getCities(for: child))
        }
        
        return cities
    }
    
    func getAllCities() -> [City] {
        var cities = [City]()
       
        cities.append(contentsOf: root.city)
      
        for child in root.children {
            cities.append(contentsOf: getCities(for: child))
        }
        
        return cities
    }
    
    func getFirstCities(count: Int) -> [City] {
        var cities = [City]()
       
        cities.append(contentsOf: root.city)
      
        var counter = root.city.count
        for child in root.children {
            let children = getCities(for: child)
            cities.append(contentsOf: children)
            counter += children.count

            if counter >= count {
                break
            }
        }
        
        return cities
    }
    
    fileprivate func getCities(keyIndex: Int = 0, prefix: String, parent: CityTreeNode) -> [City] {
        if prefix.count == keyIndex {
            return getCities(for: parent)
        }
        
        if let child = parent.children.first(where: { prefix[keyIndex] == $0.key }) {
            return getCities(keyIndex: keyIndex + 1, prefix: prefix, parent: child)
        } else {
            return []
        }
    }
}
