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
    @IBOutlet  var name: UILabel!
    
    var presenter: CatCellPresenter? {
        didSet {
            name.text = presenter?.breeds.first?.name
//            imageCat.imageFromServerURL(urlString: presenter!.url)
//            guard let string = modelCat?.width else { return }
//            infoCat.text = "\(string)"
        }
    }
    
}
