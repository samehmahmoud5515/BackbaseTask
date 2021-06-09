//
//  CityTableViewCell.swift
//  BackbaseTask
//
//  Created by SAMEH on 07/06/2021.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var citiyNameLabel: UILabel!
}

// MARK: - Update UI
extension CityTableViewCell {
    func updateUI(with city: City) {
        let attributedText = NSMutableAttributedString()
        attributedText.append(NSAttributedString(string: city.name, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17, weight: .regular)]))
        attributedText.append(NSAttributedString(string: " (\(city.country))", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17, weight: .bold)]))
        citiyNameLabel.attributedText = attributedText
    }    
}
