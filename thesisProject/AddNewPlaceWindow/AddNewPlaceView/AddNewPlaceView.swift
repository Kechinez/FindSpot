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
    var photosCollection: [UIImageView] = []
    
    init(frame: CGRect, with viewController: AddNewPlaceViewController) {
        super.init(frame: frame)
        
        self.viewController = viewController
        self.backgroundColor = #colorLiteral(red: 0.3647058824, green: 0.6549019608, blue: 0.04705882353, alpha: 1)
        
        let placeNameTextField = UITextField(frame: CGRect(x: 25, y: 15, width: frame.size.width - 50, height: 45))
        placeNameTextField.borderStyle = .roundedRect
        placeNameTextField.placeholder = "name of place"
        placeNameTextField.font = UIFont.systemFont(ofSize: 18)
        self.addSubview(placeNameTextField)
        
        let addPhotoButton = UIButton(frame: CGRect(x: placeNameTextField.bounds.maxX - 45, y: 5, width: 35, height: 35))
        let clipIcon = UIImage(named: "clipIcon.png")
        addPhotoButton.setImage(clipIcon, for: UIControlState.normal)
        addPhotoButton.addTarget(viewController, action: #selector(AddNewPlaceViewController.addImage), for: .touchUpInside)
        placeNameTextField.addSubview(addPhotoButton)
        placeNameTextField.bringSubview(toFront: addPhotoButton)
        
        let placeInfoTextView = UITextView(frame: CGRect(x: 20, y: 75, width: frame.size.width - 40, height: 65))
        placeInfoTextView.font = UIFont.systemFont(ofSize: 18)
        placeInfoTextView.isEditable = true
        placeInfoTextView.layer.cornerRadius = 4
        self.addSubview(placeInfoTextView)
        
        let placeHolderLabel = UILabel(frame: CGRect(x: 20, y: 85, width: frame.size.width - 30, height: 65))
        placeHolderLabel.backgroundColor = .clear
        placeHolderLabel.font = UIFont(name: "Helvetica", size: 13)
        placeHolderLabel.textColor = UIColor.gray
        placeHolderLabel.text = "Describe spot here"
        self.addSubview(placeHolderLabel)
        
        for i in 0...3 {
            let imageMergin = 25
            let image = UIImageView(frame: CGRect(x: imageMergin + (i * (10 + 65)), y: 155, width: 65, height: 65))
            image.layer.cornerRadius = 5.0
            image.tag = i
            self.addSubview(image)
            self.photosCollection.append(image)
        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



