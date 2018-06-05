//
//  ImagePickerViewCell.swift
//  thesisProject
//
//  Created by Nikita Kechinov on 03.04.2018.
//  Copyright © 2018 Nikita Kechinov. All rights reserved.
//

import UIKit


class UserImagesCell: UICollectionViewCell {
    let imageView: UIImageView
    var gestureRecognizer: UILongPressGestureRecognizer?
    
    override init(frame: CGRect) {
        self.imageView = UIImageView()
        super.init(frame: frame)
        self.tag = tag
        self.backgroundColor = .clear
        self.imageView.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        //self.imageView.isUserInteractionEnabled = false
        //self.ges
        //self.imageView.isUserInteractionEnabled = false
        self.addSubview(imageView)
        self.bringSubview(toFront: imageView)
    
        
        
    }
    
    
    func addGestureRecognizer(to viewController: AddNewPlaceViewController) {
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: viewController, action: #selector(AddNewPlaceViewController.removeImage(sender:)))
        longPressGestureRecognizer.minimumPressDuration = 1.0
        self.addGestureRecognizer(longPressGestureRecognizer)
        self.gestureRecognizer = longPressGestureRecognizer
    }
    
    
    func deleteGestureRecognizer() {
        self.removeGestureRecognizer(self.gestureRecognizer!)
    }
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
