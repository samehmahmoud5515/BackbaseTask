//
//  City.swift
//  BackbaseTask
//
//  Created by SAMEH on 08/06/2021.
//

import MapKit.MKFoundation

class City: Decodable {
    var country, name: String
    var id: Int
    var coord: Coordinate

    enum CodingKeys: String, CodingKey {
        case country, name
        case id = "_id"
        case coord
    }
    
    // MARK: - Coord
    struct Coordinate: Decodable, Hashable {
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

extension City.Coordinate {
    var toCLLocationCoordinate2D: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: lat, longitude: lon)
    }
}
