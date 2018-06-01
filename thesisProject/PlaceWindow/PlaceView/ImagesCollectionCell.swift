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
    let activityIndicator: UIActivityIndicatorView
   
    override init(frame: CGRect) {
        print(frame)
        self.imageView = UIImageView()
        self.activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clear
        self.imageView.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        self.imageView.clipsToBounds = true
        self.imageView.contentMode = .scaleAspectFill
        self.imageView.layer.cornerRadius = 2.0
        self.imageView.layer.borderColor = #colorLiteral(red: 0.6257788431, green: 0.6374320992, blue: 0.6723918676, alpha: 1)
        self.imageView.layer.borderWidth = 2.0
        self.addSubview(imageView)
        self.bringSubview(toFront: imageView)
        
        self.activityIndicator.frame = CGRect(x: self.imageView.bounds.midX - 20, y: self.imageView.bounds.midY - 20, width: 40, height: 40)
        self.activityIndicator.startAnimating()
        self.imageView.addSubview(self.activityIndicator)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
