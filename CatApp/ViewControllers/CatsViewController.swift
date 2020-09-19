//
//  CatsViewController.swift
//  CatApp
//
//  Created by Valera on 9/16/20.
//  Copyright © 2020 Valera. All rights reserved.
//

import UIKit

class CatsViewController: UIViewController {
    
    private let cellIdentifier = String.init(describing: CatInformationCell.self)
    private let networkService = NetworkService()
    var catsArray = [CatsModel]()
    private var filteredCats = [CatsModel]()
    private let defaultCatsCount = 15
    private let refreshControl = UIRefreshControl()
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    // search query activation
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    private let searchController = UISearchController(searchResultsController: nil )
    @IBOutlet var catsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cellRegistration(nameCell: cellIdentifier, nibName: cellIdentifier)
        getDataCats()
        settingsSearchController()
    }
    
    private func getDataCats(page: Int = 1) {
        networkService.getDataJSON(page: page, limit: defaultCatsCount) { result in
            DispatchQueue.main.async {  [weak self] in
                switch result {
                case let .success(cats):
                    guard let self = self else { return }
                    self.catsArray.append(contentsOf: cats)
                    self.refreshTable()
                    self.catsTableView.reloadData()
                case .failure(let error):
                    print("error:\(error)")
                }
            }
        }
    }
    
    private func cellRegistration(nameCell: String, nibName: String) {
        let nibName = UINib(nibName: nibName, bundle: nil)
        catsTableView.register(nibName, forCellReuseIdentifier: nameCell)
    }
    
    private func settingsSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search cat"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}

// MARK: UITableViewDataSource 
extension CatsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredCats.count
        }
        return catsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = catsTableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CatInformationCell else { return UITableViewCell() }
        
        var arrayInfoCats: CatsModel
        
        if isFiltering {
            arrayInfoCats = filteredCats[indexPath.row]
        } else {
            arrayInfoCats = catsArray[indexPath.row]
        }
        
        cell.modelCat = arrayInfoCats
        
        return cell
    }
}

// MARK: UITableViewDelegate
extension CatsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == catsArray.count - 1 {
            let page = catsArray.count / defaultCatsCount
            print(page)
            getDataCats(page: page)
        }
    }
}

// MARK: Refresh
extension CatsViewController {
    func refreshTable() {
        self.refreshControl.attributedTitle = NSAttributedString(string: "Update")
        self.refreshControl.addTarget(self, action: #selector(self.updateTable), for: .valueChanged )
        self.catsTableView.refreshControl = self.refreshControl
    }
    @objc func updateTable() {
        self.catsArray.removeAll()
        getDataCats()
        self.catsTableView.reloadData()
        self.refreshControl.endRefreshing()
    }
}

// MARK:
extension CatsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filteredCats = catsArray.filter({ (cats: CatsModel) -> Bool in
            return cats.id.lowercased().contains(searchText.lowercased())
        })
        catsTableView.reloadData()
    }
}
