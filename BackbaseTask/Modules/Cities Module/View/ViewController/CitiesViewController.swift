//
//  CitiesViewController.swift
//  BackbaseTask
//
//  Created by SAMEH on 07/06/2021.
//

import UIKit

class CitiesViewController: UIViewController {
    
    // MARK:- Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK:- Attribuites
    private var presnter: CitiesPresenterProtocol!
    
    init() {
        super.init(nibName: "\(CitiesViewController.self)", bundle: nil)
        presnter = CitiesPresenter(view: self)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

}

extension CitiesViewController {
    
    func setupUI() {
        setupNaviagtionBarUI()
        addSearchBarToNaviagtionBar()
        registerTableViewCell()
    }
    
    private func setupNaviagtionBarUI() {
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func addSearchBarToNaviagtionBar() {
        let searchBar = UISearchBar()
        searchBar.barTintColor = .black
        searchBar.tintColor = .black
        navigationItem.titleView = searchBar
    }
    
    private func registerTableViewCell() {
        let nib = UINib(nibName: "\(CityTableViewCell.self)", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "\(CityTableViewCell.self)")
    }
}

extension CitiesViewController: CitiesViewControllerProtocol {
    
}

extension CitiesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presnter.getCitiesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(CityTableViewCell.self)", for: indexPath)
        
        return cell
    }
}
