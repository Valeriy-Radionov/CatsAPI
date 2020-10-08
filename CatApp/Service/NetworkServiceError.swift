//
//  NetworkServiceError.swift
//  CatApp
//
//  Created by Valera on 9/18/20.
//  Copyright © 2020 Valera. All rights reserved.
//

import Foundation

enum NetworkServiceError: Error {
    case invaliURL
    case incorrectDataJSON
    case failedDecodeJSON
}
