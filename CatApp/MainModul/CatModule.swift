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
    func reload()
    func append(idices: [IndexPath]) 
}

protocol CatPresenterProtocol {
    //output
    func cellsCount() -> Int
    func cellAt(index: Int) -> CatCellPresenter?

    //input
    func reload()
    func willDisplay(index: Int)
    func switchToSearch()
    func switchToNormal()
    func searchFor(text: String)
}

struct CatCellPresenter {
    let id: String
    let url: String
    let breeds: [BreedPresenter]
}

struct BreedPresenter {
    let weight: Float
    let name: String
    let wiki: String?
    let country: String
}
