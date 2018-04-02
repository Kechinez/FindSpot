//
//  AddNewPlaceView.swift
//  thesisProject
//
//  Created by Nikita Kechinov on 02.04.2018.
//  Copyright © 2018 Nikita Kechinov. All rights reserved.
//

import UIKit

class AddNewPlaceView: UIView {
    var viewController: AddNewPlaceViewController?
    var photosPicker: UICollectionView?
    
    init(frame: CGRect, with viewController: AddNewPlaceViewController) {
        super.init(frame: frame)
        
        self.viewController = viewController
        
        let placeNameTextField = UITextField(frame: CGRect(x: 10, y: 15, width: frame.size.width - 20, height: 50))
        placeNameTextField.borderStyle = .roundedRect
        placeNameTextField.placeholder = "name of place"
        placeNameTextField.font = UIFont.systemFont(ofSize: 18)
        self.addSubview(placeNameTextField)
        
        let placeInfoTextView = UITextView(frame: CGRect(x: 10, y: 75, width: frame.size.width - 20, height: 50))//UITextField(frame: CGRect(x: 10, y: 75, width: frame.size.width - 20, height: 45))
        placeInfoTextView.font = UIFont.systemFont(ofSize: 18)
        placeInfoTextView.isEditable = true
        placeInfoTextView.layer.cornerRadius = 10
        self.addSubview(placeInfoTextView)
        
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 60, height: 60)
        
        let photosPicker = UICollectionView(frame: CGRect(x: 10, y: 180, width: frame.size.width - 20, height: frame.size.height - 180), collectionViewLayout: layout)
        self.photosPicker = photosPicker
        
        self.photosPicker!.delegate = viewController
        self.photosPicker!.dataSource = viewController
        self.photosPicker!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
        self.photosPicker!.backgroundColor = .green
        self.addSubview(photosPicker)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

/*
 let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
 layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
 layout.itemSize = CGSize(width: 60, height: 60)
 
 let myCollectionView:UICollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
 myCollectionView.dataSource = self
 myCollectionView.delegate = self
 myCollectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
 myCollectionView.backgroundColor = UIColor.whiteColor()
 self.view.addSubview(myCollectionView)
 
 */









