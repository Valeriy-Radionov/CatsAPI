//
//  NetworkService.swift
//  CatApp
//
//  Created by Valera on 9/16/20.
//  Copyright © 2020 Valera. All rights reserved.
//

import Foundation

class NetworkService: NetworkServiceProtocol {
    
    func getDataJSON(page: Int, limit: Int, completion: @escaping (Result<[CatsModel], Error>) -> ()) {
        guard let url = URL(string: "https://api.thecatapi.com/v1/images/search?limit=\(limit)&\(page)") else {
            completion(.failure(NetworkServiceError.invaliURL))
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error == nil {
                do {
                    guard let data = data else {
                        completion(.failure(NetworkServiceError.incorrectDataJSON))
                        return
                    }
                    let infoCatArray = try JSONDecoder().decode([CatsModel].self, from: data)
                    completion(.success(infoCatArray))
                } catch {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(NetworkServiceError.failedDecodeJSON))
            }
        }.resume()
    } 
}
