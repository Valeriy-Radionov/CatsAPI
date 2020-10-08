//
//  CatModul.swift
//  CatApp
//
//  Created by Valera on 10/1/20.
//  Copyright © 2020 Valera. All rights reserved.
//

import Foundation
import UIKit

protocol CatViewProtocol: class {
    func reloadData()
    func refreshTable()
}

protocol CatPresenterProtocol: class {
    var catArray: [CatCellPresenter] { get set }
    var filteredCats: [CatCellPresenter] { get set }
    init(view: CatViewProtocol, networkService: NetworkServiceProtocol, catArray: [CatCellPresenter], filteredCats: [CatCellPresenter])
    func getCat(page: Int)
    func refreshTable()
    func filterContentForSearchText(_ searchText: String)
}

struct CatCellPresenter {
    let id: String
    let url: String
    let breeds: [BreedCell]
}

struct BreedCell {
    let weight: String
    let name: String
    let wiki: String?
    let country: String
}
