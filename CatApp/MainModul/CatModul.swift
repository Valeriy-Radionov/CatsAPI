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
    var catArray: [CatsModel] { get set }
    var filteredCats: [CatsModel] { get set }
    init(view: CatViewProtocol, networkService: NetworkServiceProtocol, catArray: [CatsModel], filteredCats: [CatsModel])
    func getCat(page: Int)
    func refreshTable()
    func filterContentForSearchText(_ searchText: String)
}

struct CatCell {
    let id: String
    let url: String
    let breeds: [BreedCell]
}

struct BreedCell {
    let weight: Float
    let name: String
    let wiki: String?
    let country: String
}
