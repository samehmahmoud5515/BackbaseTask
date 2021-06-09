//
//  CityTableViewCell.swift
//  BackbaseTask
//
//  Created by SAMEH on 07/06/2021.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var cityTitleLabel: UILabel!
    @IBOutlet weak var coordinateLabel: UILabel!
}

// MARK: - Update UI
extension CityTableViewCell {
    func updateUI(with city: City) {
        updateCityTitleLabel(cityName: city.name, countryName: city.country)
        updateCoordinateLabel(coordinate: city.coord)
    }
    
    private func updateCityTitleLabel(cityName: String, countryName: String) {
        let attributedText = NSMutableAttributedString()
        attributedText.append(NSAttributedString(string: cityName, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17, weight: .regular)]))
        attributedText.append(NSAttributedString(string: " (\(countryName))", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17, weight: .bold)]))
        cityTitleLabel.attributedText = attributedText
    }
    
    private func updateCoordinateLabel(coordinate: City.Coordinate) {
        let coordinateTitle = CitiesLocalizer.coordinates.rawValue
        let latitudeTitle = CitiesLocalizer.latitude.rawValue + " \(coordinate.lat)"
        let longitudeTitle = CitiesLocalizer.longitude.rawValue + " \(coordinate.lon)"
        let text = "\(coordinateTitle): \n\(latitudeTitle) \n\(longitudeTitle)"
        coordinateLabel.text = text
    }
}
