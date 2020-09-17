//
//  NetworkService.swift
//  CatApp
//
//  Created by Valera on 9/16/20.
//  Copyright © 2020 Valera. All rights reserved.
//

import Foundation
//guard let url = URL(string: "https://api.thecatapi.com/v1/images/search?limit=15") else { return }

class NetworkService {
    
    let apiKey = "008bce0b-6725-4af1-9ad9-8de595375520"
    
    func getDataJSON(completion: @escaping ([CatsModel]) -> ()) {
        guard let url  = URL(string: "https://api.thecatapi.com/v1/images/search?limit=15") else { return print("Некорректный URL")}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error == nil {
                do {
                    guard let data = data else {return print("Некорректные данные")}
                    let infoCatArray = try JSONDecoder().decode([CatsModel].self, from: data)
                        completion(infoCatArray)
                } catch {
                    
                }
            }
        }.resume()
    } 
}





