//
//  UIImageView Extension.swift
//  CatApp
//
//  Created by Valera on 9/17/20.
//  Copyright © 2020 Valera. All rights reserved.
//

import Foundation
import UIKit
extension UIImageView {
    public func imageFromServerURL(urlString: String) {
        self.image = nil
        let urlStringNew = urlString.replacingOccurrences(of: " ", with: "%20")
        URLSession.shared.dataTask(with: NSURL(string: urlStringNew)! as URL, completionHandler: { (data, response, error) -> Void in
            guard let data = data else { return }
            if error != nil {
                print(error as Any)
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data)
                self.image = image
            })
            
        }).resume()
    }}
