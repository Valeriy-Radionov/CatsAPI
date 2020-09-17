//
//  CatsModel.swift
//  CatApp
//
//  Created by Valera on 9/16/20.
//  Copyright © 2020 Valera. All rights reserved.
//

import Foundation

struct CatsModel: Codable {
    let breeds: [Breed]
    let id: String
    let url: String
    let width: Int
    let height: Int
    let categories: [Category]?
}







