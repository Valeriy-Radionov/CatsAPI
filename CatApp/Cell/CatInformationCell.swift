//
//  CatInformationCell.swift
//  CatApp
//
//  Created by Valera on 9/16/20.
//  Copyright © 2020 Valera. All rights reserved.
//

import UIKit

class CatInformationCell: UITableViewCell {

    @IBOutlet private var imageCat: UIImageView!
    @IBOutlet private var infoCat: UILabel!

    var model: CatsModel? {
        didSet {
            infoCat.text = model?.id

        }
    }
    
//    func updateInterface(catInfoArray: [CatsModel], indexPath: IndexPath) {
//        self.convertImageData(catInfoArray: catInfoArray, indexPath: indexPath)
//
//    }
//
//    private func convertImageData(catInfoArray: [CatsModel], indexPath: IndexPath) {
//        guard let url = URL(string: catInfoArray[indexPath.row].url) else { return }
//        DispatchQueue.global().async {
//            if let data = try? Data(contentsOf: url) {
//                DispatchQueue.main.async {
//                    self.imageCat.image = UIImage(data: data)
//                }
//            }
//        }
//    }
}
