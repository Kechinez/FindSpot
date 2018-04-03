//
//  ImagePickerViewCell.swift
//  thesisProject
//
//  Created by Nikita Kechinov on 03.04.2018.
//  Copyright © 2018 Nikita Kechinov. All rights reserved.
//

import UIKit


class ImagePickerViewCell: UICollectionViewCell {
    let imageView: UIImageView
    
    override init(frame: CGRect) {
        print(frame)
        self.imageView = UIImageView()
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.imageView.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        self.imageView.image = UIImage(named: "uploadIcon.png")
        self.imageView.clipsToBounds = true
        self.imageView.contentMode = .scaleAspectFill
        self.imageView.layer.borderWidth = 1.0
        self.imageView.layer.borderColor = UIColor.black.cgColor
        self.addSubview(imageView)
        self.bringSubview(toFront: imageView)
    
    }
    
    
    
    
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
