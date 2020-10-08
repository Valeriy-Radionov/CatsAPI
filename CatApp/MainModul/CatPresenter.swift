//
//  CatPresenter.swift
//  CatApp
//
//  Created by Valera on 10/1/20.
//  Copyright © 2020 Valera. All rights reserved.
//

import Foundation

class CatPresenter: CatPresenterProtocol {
    private enum Constants {
        static let defaultCatsCount = 15
    }

    weak var view: CatViewProtocol?
    private let networkService: NetworkServiceProtocol!

    private var cats: [CatCellPresenter] = []
    private var filteredCats: [CatCellPresenter] = []
    private var isFiltering = false

    init(view: CatViewProtocol,
         networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
    }

    func cellsCount() -> Int {
        return isFiltering ? filteredCats.count : cats.count
    }

    func cellAt(index: Int) -> CatCellPresenter? {
        let source = isFiltering ? filteredCats : cats
        guard source.count > index else { return nil }
        return source[index]
    }

    func reload() {
        cats = []
        getCats(page: 1) { [weak self] result in
            switch result {
            case .success(let cats):
                self?.cats = cats
                self?.view?.reload()
            case .failure(let error):
                print(error)
                //self.view.showAlert or so
            }
        }
    }

    func willDisplay(index: Int) {
        guard !isFiltering else { return }

        if index == cats.count - 1 {
            let page = cats.count / Constants.defaultCatsCount
            print(page)
            getCats(page: page) { [weak self] result in
                let existCatsCount = self?.cats.count ?? 0
                switch result {
                case .success(let cats):
                    let indices = cats.enumerated()
                        .map { IndexPath(row: $0.offset + existCatsCount, section: 0) }
                    self?.cats.append(contentsOf: cats)
                    self?.view?.append(idices: indices)
                case .failure(let error):
                    print(error)
                    //self.view.showAlert or so
                }
            }
        }
    }

    func switchToSearch() {
        isFiltering = true
    }

    func switchToNormal() {
        isFiltering = false
        filteredCats = cats
    }

    func searchFor(text: String) {
        filteredCats = cats.filter { $0.id.lowercased().contains(text.lowercased()) }
    }
}

private extension CatPresenter {
    func getCats(page: Int = 1, completion: @escaping (Result<[CatCellPresenter], Error>) -> ()) {
        networkService.getDataJSON(page: page, limit: Constants.defaultCatsCount) { result in
            let transformed = result.map { models -> [CatCellPresenter] in
                models.map(CatCellPresenter.init(model:))
            }

            DispatchQueue.main.async {
                completion(transformed)
            }
        }
    }
}

private extension CatCellPresenter {
    init(model: CatModel) {
        id = model.id
        url = model.url
        breeds = []//model.breeds
    }
}
