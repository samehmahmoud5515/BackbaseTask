//
//  CitiesViewController.swift
//  BackbaseTask
//
//  Created by SAMEH on 07/06/2021.
//

import UIKit

class CitiesViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Attribuites
    var presenter: CitiesPresenterProtocol!

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.fetchCities()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
}

extension CitiesViewController {
    
    func setupUI() {
        setupNaviagtionBarUI()
        addSearchBarToNaviagtionBar()
        registerTableViewCell()
        addTableViewFooterView()
    }
    
    private func setupNaviagtionBarUI() {
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = CitiesLocalizer.title.rawValue
    }
    
    private func addSearchBarToNaviagtionBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.showsCancelButton = false
        searchController.searchBar.placeholder = CitiesLocalizer.search.rawValue
        searchController.searchBar.delegate = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
    }
    
    private func registerTableViewCell() {
        let nib = UINib(nibName: "\(CityTableViewCell.self)", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "\(CityTableViewCell.self)")
    }
    
    private func addTableViewFooterView() {
        tableView.tableFooterView = UIView()
    }
}

extension CitiesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.searchCities(qurey: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        presenter.searchCities(qurey: "")
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }
}

extension CitiesViewController: CitiesViewControllerProtocol {
    func reloadData() {
        tableView.reloadData()
    }
    
    func startLoadingIndicator() {
        activityIndicator.startAnimating()
    }
    
    func stopLoadingIndicator() {
        activityIndicator.stopAnimating()
    }
}

extension CitiesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getCitiesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(CityTableViewCell.self)", for: indexPath) as? CityTableViewCell ?? CityTableViewCell()
        cell.updateUI(with: presenter.getCity(for: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.navigateToCityDetails(with: indexPath.row)
    }
}
