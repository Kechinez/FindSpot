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
        self.backgroundColor = #colorLiteral(red: 0.3647058824, green: 0.6549019608, blue: 0.04705882353, alpha: 1)
        
        let placeNameTextField = UITextField(frame: CGRect(x: 15, y: 20, width: frame.size.width - 30, height: 45))
        placeNameTextField.borderStyle = .roundedRect
        placeNameTextField.placeholder = "name of place"
        placeNameTextField.font = UIFont.systemFont(ofSize: 18)
        self.addSubview(placeNameTextField)
        
        let placeInfoTextView = UITextView(frame: CGRect(x: 15, y: 85, width: frame.size.width - 30, height: 65))
        placeInfoTextView.font = UIFont.systemFont(ofSize: 18)
        placeInfoTextView.isEditable = true
        placeInfoTextView.layer.cornerRadius = 4
        self.addSubview(placeInfoTextView)
        
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
        layout.minimumInteritemSpacing = 30
        layout.minimumLineSpacing = 30
        layout.itemSize = CGSize(width: 180, height: 180)
        
        let photosPicker = UICollectionView(frame: CGRect(x: 60, y: 170, width: frame.size.width - 120, height: frame.size.height - 200), collectionViewLayout: layout)
        self.photosPicker = photosPicker
        
        
        
        
        self.photosPicker!.delegate = viewController
        self.photosPicker!.dataSource = viewController
        self.photosPicker!.register(ImagePickerViewCell.self, forCellWithReuseIdentifier: "MyCell")
        self.photosPicker!.backgroundColor = #colorLiteral(red: 0.8949046532, green: 0.9000587331, blue: 0.8950674136, alpha: 1)
        self.photosPicker!.layer.cornerRadius = 20
        self.addSubview(photosPicker)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



