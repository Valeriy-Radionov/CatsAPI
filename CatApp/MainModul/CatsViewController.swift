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
    private let cellIdentifier = String(describing: CatInformationCell.self)
    private var cells: [CatCellPresenter] = []
    private let refreshControl = UIRefreshControl()
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    private let searchController = UISearchController(searchResultsController: nil)
    @IBOutlet private var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshTableCats()
        configureTable()
        configureSearchController()
        presenter.reload()
    }
}

private extension CatsViewController {
    func configureTable() {
        let nibName = UINib(nibName: cellIdentifier, bundle: nil)
        table.register(nibName, forCellReuseIdentifier: cellIdentifier)
        table.tableFooterView = UIView()
    }
    
    private func configureSearchController() {
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
        return presenter.cellsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = table.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CatInformationCell else { return UITableViewCell() }
        cell.presenter = presenter.cellAt(index: indexPath.row)
        return cell
    }
}

// MARK: UITableViewDelegate
extension CatsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView,
                   willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
        presenter.willDisplay(index: indexPath.row)
    }
}

// MARK: CatViewProtocol
extension CatsViewController: CatViewProtocol {
    func errorAlert() {
        let alert = UIAlertController(title: "Error", message: "data not loaded", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
    func reload() {
        table.reloadData()
    }
    
    func append(idices: [IndexPath]) {
        table.beginUpdates()
        table.insertRows(at: idices, with: .automatic)
        table.endUpdates()
    }
}

// MARK: Refresh
extension CatsViewController {
    func refreshTableCats() {
        refreshControl.attributedTitle = NSAttributedString(string: "Update")
        refreshControl.addTarget(self, action: #selector(update), for: .valueChanged)
        table.refreshControl = refreshControl
    }
    
    @objc func update() {
        presenter.reload()
        refreshControl.endRefreshing()
    }
}

// MARK: UISearchResultsUpdating
extension CatsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if !searchBarIsEmpty {
            presenter.switchToSearch()
            presenter.searchFor(text: searchController.searchBar.text!)
        } else {
            presenter.switchToNormal()
        }
    }
}
