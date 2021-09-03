//
//  ViewController.swift
//  StarWarsInfo
//
//  Created by Miguel Cuellar on 02/09/21.
//

import UIKit
import BobaFetch

enum Category: Int, CaseIterable {
    case People
    case Planets
    case Films
}

class ViewController: UIViewController {
    
    private let searchController = UISearchController(searchResultsController: nil)
    @IBOutlet weak var categoriesSegmentedControl: UISegmentedControl!
    @IBOutlet weak var recordsTableView: UITableView!
    var activityIndicator = UIActivityIndicatorView(style: .large)

    var data =  [Category.People: [PresentationRecord](),
                 Category.Planets: [PresentationRecord](),
                 Category.Films: [PresentationRecord]()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        getData()
    }
    
    func setupViews() {
        title = "Star Wars records"
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        recordsTableView.delegate = self
        recordsTableView.dataSource = self
        let nib = UINib(nibName: "RecordTableViewCell", bundle: nil)
        recordsTableView.register(nib, forCellReuseIdentifier: "RecordCell")

        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    @IBAction func categoryChanged(_ sender: UISegmentedControl) {
        getData()
    }
    
    func getData(searchText: String? = nil) {
        activityIndicator.startAnimating()
        guard let category = Category(rawValue: categoriesSegmentedControl.selectedSegmentIndex) else { return }
        switch category {
        case .People:
            BobbaFetcher.getEyeColors(search: searchText) { [weak self] eyesRequest in
                self?.stopIndicator()
                switch eyesRequest {
                case .success(let eyes):
                    self?.data[.People] = eyes.compactMap { $0.mapToPresentation() }
                    self?.recordsTableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        case .Films:
            BobbaFetcher.getFilms(search: searchText) { [weak self] filmsRequest in
                self?.stopIndicator()
                switch filmsRequest {
                case .success(let films):
                    self?.data[.Films] = films.compactMap { $0.mapToPresentation() }
                    self?.recordsTableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        case .Planets:
            BobbaFetcher.getPlanets(search: searchText) { [weak self] planetsRequest in
                self?.stopIndicator()
                switch planetsRequest {
                case .success(let planets):
                    self?.data[.Planets] = planets.compactMap { $0.mapToPresentation() }
                    self?.recordsTableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    private func stopIndicator() {
        activityIndicator.stopAnimating()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let segment = Category.init(rawValue: categoriesSegmentedControl.selectedSegmentIndex) else { return 0 }
        return data[segment]?.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recordsTableView.dequeueReusableCell(withIdentifier: "RecordCell") as! RecordTableViewCell
        guard let record = data[Category(rawValue: categoriesSegmentedControl.selectedSegmentIndex) ?? .Films]?[indexPath.row] else {
            return cell
        }
        cell.setupCell(record: record)
        return cell
    }
}

extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.isActive {
            let searchBar = searchController.searchBar
            if searchBar.text?.count ?? 0 > 3 {
                getData(searchText: searchBar.text)
            } else if searchBar.text?.count == 0 {
                getData()
            }
        } else {
            getData()
        }
    }
}
