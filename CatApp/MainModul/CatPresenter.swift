//
//  CatPresenter.swift
//  CatApp
//
//  Created by Valera on 10/1/20.
//  Copyright © 2020 Valera. All rights reserved.
//

import Foundation

class CatPresenter: CatPresenterProtocol {
    
    var catArray: [CatsModel]
    var defaultCatsCount = 15
    var filteredCats: [CatsModel]
    weak var view: CatViewProtocol?
    let networkService: NetworkServiceProtocol!
    
    required init(view: CatViewProtocol, networkService: NetworkServiceProtocol, catArray: [CatsModel], filteredCats: [CatsModel]) {
        self.view = view
        self.networkService = networkService
        self.catArray = catArray
        self.filteredCats = filteredCats
        getCat()
    }
    
    func getCat(page: Int = 1) {
        networkService.getDataJSON(page: page, limit: defaultCatsCount) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {  [weak self] in
                switch result {
                case .success(let cats):
                    self?.catArray.append(contentsOf: cats)
                    self?.view?.reloadData()
                case .failure(let error):
                    print("error: \(error)")
                }
            }
        }
    }
    
    func refreshTable() {
        catArray.removeAll()
        getCat(page: 1)
        view?.refreshTable()
        view?.reloadData()
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredCats = catArray.filter({ (cats: CatsModel) -> Bool in
            return cats.id.lowercased().contains(searchText.lowercased())
        })
        view?.reloadData()
    }
}

