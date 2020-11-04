//
//  Extension+UIImageView.swift
//  CatApp
//
//  Created by Valera on 10/21/20.
//  Copyright © 2020 Valera. All rights reserved.
//

import Foundation
import UIKit
extension UIImageView {
    open override var intrinsicContentSize: CGSize {
        if let myImage = self.image {
            let myImageWidth = myImage.size.width
            let myImageHeight = myImage.size.height
            let myViewWidth = self.frame.size.width
            
            let ratio = myViewWidth/myImageWidth
            let scaledHeight = myImageHeight * ratio
            
            return CGSize(width: myViewWidth, height: scaledHeight)
        }
        return CGSize(width: -1.0, height: -1.0)
    }
}
