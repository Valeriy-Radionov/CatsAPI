//
//  CatsViewController.swift
//  CatApp
//
//  Created by Valera on 9/16/20.
//  Copyright © 2020 Valera. All rights reserved.
//

import UIKit

class CatsViewController: UIViewController {
    
    var presenter: CatPresenterProtocol!
    private let cellIdentifier = String.init(describing: CatInformationCell.self)
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
            settingsSearchController()
            presenter.getCat(page: 1)
            refreshTableCats()
        }
        
        private func cellRegistration(nameCell: String, nibName: String) {
            let nibName = UINib(nibName: nibName, bundle: nil)
            self.catsTableView.register(nibName, forCellReuseIdentifier: nameCell)
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
            return isFiltering ? presenter.filteredCats.count : presenter.catArray.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = catsTableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CatInformationCell else { return UITableViewCell() }
            
            cell.modelCat = isFiltering ? presenter.filteredCats[indexPath.row] : presenter.catArray[indexPath.row]
            
            return cell
        }
    }

    // MARK: UITableViewDelegate
    extension CatsViewController: UITableViewDelegate {
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 100
        }
        
        func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            if indexPath.row == presenter.catArray.count - 1 {
                let page = presenter.catArray.count / defaultCatsCount
                print(page)
                presenter.getCat(page: page)
            }
        }
    }

    // MARK: CatViewProtocol
    extension CatsViewController: CatViewProtocol {
        func reloadData() {
            self.catsTableView.reloadData()
        }
        
        func refreshTable() {
            self.refreshControl.endRefreshing()
        }
    }

    // MARK: Refresh
    extension CatsViewController {
        func refreshTableCats() {
            self.refreshControl.attributedTitle = NSAttributedString(string: "Update")
            self.refreshControl.addTarget(self, action: #selector(self.update), for: .valueChanged )
            self.catsTableView.refreshControl = self.refreshControl
        }
        
        @objc func update() {
            presenter.refreshTable()
        }
    }

    // MARK: UISearchResultsUpdating
    extension CatsViewController: UISearchResultsUpdating {
        func updateSearchResults(for searchController: UISearchController) {
            presenter.filterContentForSearchText(searchController.searchBar.text!)
        }
    }
