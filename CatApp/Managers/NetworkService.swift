//
//  NetworkService.swift
//  CatApp
//
//  Created by Valera on 9/16/20.
//  Copyright © 2020 Valera. All rights reserved.
//

import Foundation
//guard let url = URL(string: "https://api.thecatapi.com/v1/images/search?limit=15") else { return }

enum NetworkServiceError: Error {
    case invalidURL
}

class NetworkService {
    private let apiKey = "008bce0b-6725-4af1-9ad9-8de595375520"
    
    func getDataJSON(page: Int = 0, limit: Int = 15, completion: @escaping (Result<[CatsModel], Error>) -> ()) {
        guard let url = URL(string: "https://api.thecatapi.com/v1/images/search?limit=\(limit)&page=\(page)") else {
            completion(.failure(NetworkServiceError.invalidURL))
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error == nil {
                do {
                    guard let data = data else {return print("Некорректные данные")}
                    let infoCatArray = try JSONDecoder().decode([CatsModel].self, from: data)
                    print(infoCatArray)
                    completion(.success(infoCatArray))
                } catch {
                    completion(.failure(error))
                    print(error)
                }
            } else {
                completion(.failure(error!))
            }
        }.resume()
    } 
}
