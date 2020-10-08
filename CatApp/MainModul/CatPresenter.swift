//
//  CatPresenter.swift
//  CatApp
//
//  Created by Valera on 10/1/20.
//  Copyright © 2020 Valera. All rights reserved.
//

import Foundation

class CatPresenter: CatPresenterProtocol {
    
    var catArray: [CatCellPresenter]
    var defaultCatsCount = 15
    var filteredCats: [CatCellPresenter]
    weak var view: CatViewProtocol?
    let networkService: NetworkServiceProtocol!
    
    required init(view: CatViewProtocol, networkService: NetworkServiceProtocol, catArray: [CatCellPresenter], filteredCats: [CatCellPresenter]) {
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
                    var breedArray: [BreedCell] = []
                    for cat in cats {
                        for breed in cat.breeds {
                            let breed = BreedCell(weight: breed.weight.metric, name: breed.name, wiki: breed.wikipediaURL, country: breed.countryCode)
                            breedArray.append(breed)
                            let cat = CatCellPresenter(id: cat.id, url: cat.url, breeds: breedArray)
                            self?.catArray.append(cat)
                            print("\(self!.catArray)")
                        }
                    }
                case .failure(let error):
                    print("error: \(error)")
                }
                self?.view?.reloadData()
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
        filteredCats = catArray.filter({ (cats: CatCellPresenter) -> Bool in
            return cats.id.lowercased().contains(searchText.lowercased())
        })
        view?.reloadData()
    }
}

