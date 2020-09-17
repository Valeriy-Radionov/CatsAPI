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
    
    func updateInterface(catInfoArray: [CatsModel], indexPath: IndexPath) {
        self.convertImageData(catInfoArray: catInfoArray, indexPath: indexPath)
        infoCat.text = "\(catInfoArray[indexPath.row].width)"
    }
    
    private func convertImageData(catInfoArray: [CatsModel], indexPath: IndexPath) {
        guard let url = URL(string: catInfoArray[indexPath.row].url) else { return }
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    self.imageCat.image = UIImage(data: data)
                }
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
