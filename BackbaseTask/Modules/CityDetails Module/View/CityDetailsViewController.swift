//
//  CityDetailsViewController.swift
//  BackbaseTask
//
//  Created by SAMEH on 09/06/2021.
//

import UIKit
import MapKit

final class CityDetailsViewController: UIViewController {

    // MARK: - Public properties -
    @IBOutlet weak var mapView: MKMapView!
    
    var presenter: CityDetailsPresenterProtocol!

    // MARK: - Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }

}

extension CityDetailsViewController: CityDetailsViewControllerProtocol {
}

// MARK: - UI Setup
extension CityDetailsViewController {
    func setupUI() {
        setupMapViewWithCityCoordinate()
        setupNavigationItemTileWithCityTitle()
    }
    
    private func setupMapViewWithCityCoordinate() {
        let coordinate = presenter.getCityCoordinate().toCLLocationCoordinate2D
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
        mapView.setCenter(coordinate, animated: false)
    }
    
    private func setupNavigationItemTileWithCityTitle() {
        navigationItem.title = presenter.getCityTitle()
    }
}
