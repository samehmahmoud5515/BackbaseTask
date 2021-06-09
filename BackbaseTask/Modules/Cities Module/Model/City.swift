//
//  City.swift
//  BackbaseTask
//
//  Created by SAMEH on 08/06/2021.
//

import Foundation

class City: Decodable {
    var country, name: String
    var id: Int
    var coord: Coord

    enum CodingKeys: String, CodingKey {
        case country, name
        case id = "_id"
        case coord
    }
    
    // MARK: - Coord
    struct Coord: Decodable, Hashable {
        var lon, lat: Double
    }
}

extension City: Comparable {
    static func < (lhs: City, rhs: City) -> Bool {
        return lhs.name < rhs.name
    }
    
    static func == (lhs: City, rhs: City) -> Bool {
        return lhs.id == rhs.id &&
            lhs.name == rhs.name
    }
}

typealias CitiesResponse = [City]
