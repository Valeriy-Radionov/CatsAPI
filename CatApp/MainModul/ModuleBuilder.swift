//
//  ModulBuilder.swift
//  CatApp
//
//  Created by Valera on 10/1/20.
//  Copyright © 2020 Valera. All rights reserved.
//

import UIKit

protocol ModulBuilderProtocol {
    static func createMainModule() -> UIViewController
}

class ModulBuilder: ModulBuilderProtocol {
    static func createMainModule() -> UIViewController {
        let view = CatsViewController()
        let networkService = NetworkService()
        let presenter = CatPresenter(view: view, networkService: networkService)
        view.presenter = presenter
        return view
    }
}
