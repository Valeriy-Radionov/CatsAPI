//
//  NetworkServiceProtocol.swift
//  CatApp
//
//  Created by Valera on 10/1/20.
//  Copyright © 2020 Valera. All rights reserved.
//

import Foundation

protocol NetworkServiceProtocol {
    func getDataJSON(page: Int, limit: Int,completion: @escaping (Result<[CatsModel], Error>) -> ())
}

