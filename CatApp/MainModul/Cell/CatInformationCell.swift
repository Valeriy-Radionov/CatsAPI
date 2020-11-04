//
//  CatInformationCell.swift
//  CatApp
//
//  Created by Valera on 9/16/20.
//  Copyright © 2020 Valera. All rights reserved.
//

import UIKit
import Kingfisher

class CatInformationCell: UITableViewCell {
    
    @IBOutlet var imageCat: UIImageView!
    @IBOutlet var name: UILabel!
    
    @IBOutlet var heightConstraint: NSLayoutConstraint!
    
    var presenter: CatCellPresenter? {
        didSet {
            self.name.text = self.presenter?.breeds.first?.name
            let downloader = ImageDownloader.default
            guard let urlString = self.presenter?.url else { return }
            guard let url = URL(string: urlString) else { return }
            downloader.downloadImage(with: url) { result in
                switch result {
                case .success(let value):
                    let image = value.image
                    let hRatio = image.size.height / image.size.width
                    let newImageHeight = hRatio * UIScreen.main.bounds.width
                    print(UIScreen.main.bounds.width)
                    self.heightConstraint.constant = newImageHeight
                    self.imageCat.image = image
                    self.imageCat.layoutIfNeeded()
                    print(self.heightConstraint.constant)
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    
    //    func configure(image:UIImage) {
    //    let hRatio = image.size.height / image.size.width
    //    let newImageHeight = hRatio * UIScreen.main.bounds.width
    //    heightConstraint.constant = newImageHeight
    //    imageCat.image = image
    //    imageCat.layoutIfNeeded()
    //    }
}

//class ScaledHeightImageView: UIImageView {
//
//override var intrinsicContentSize: CGSize {
//
//    if let myImage = self.image {
//        let myImageWidth = myImage.size.width
//        let myImageHeight = myImage.size.height
//        let myViewWidth = self.frame.size.width
//
//        let ratio = myViewWidth/myImageWidth
//        let scaledHeight = myImageHeight * ratio
//
//        return CGSize(width: myViewWidth, height: scaledHeight)
//    }
//
//    return CGSize(width: -1.0, height: -1.0)
//}}

