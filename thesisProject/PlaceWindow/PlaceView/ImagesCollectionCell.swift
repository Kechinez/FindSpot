//
//  ImagesCollectionCell.swift
//  thesisProject
//
//  Created by Nikita Kechinov on 07.04.2018.
//  Copyright © 2018 Nikita Kechinov. All rights reserved.
//

import UIKit

class ImagesCollectionCell: UICollectionViewCell {
    let imageView: UIImageView
    
    override init(frame: CGRect) {
        print(frame)
        self.imageView = UIImageView()
        super.init(frame: frame)
        
        self.backgroundColor =  #colorLiteral(red: 0.3647058824, green: 0.6549019608, blue: 0.04705882353, alpha: 1)
        self.imageView.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        self.imageView.clipsToBounds = true
        self.imageView.contentMode = .scaleAspectFill
        self.imageView.layer.cornerRadius = 3.0
        self.addSubview(imageView)
        self.bringSubview(toFront: imageView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
