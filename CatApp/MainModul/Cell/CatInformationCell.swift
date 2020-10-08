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
    var modelCat: CatCellPresenter? {
        didSet {
            infoCat.text = modelCat?.id
            imageCat.imageFromServerURL(urlString: modelCat!.url)
//            guard let string = modelCat?.width else { return }
//            infoCat.text = "\(string)"
        }
    }
}
