//
//  CatInformationCell.swift
//  CatApp
//
//  Created by Valera on 9/16/20.
//  Copyright © 2020 Valera. All rights reserved.
//

import UIKit

class CatInformationCell: UITableViewCell {

    @IBOutlet var imageCat: UIImageView!
    @IBOutlet var infoCat: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
