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
    var placeName: UITextField?
    var placeDescr: UITextView?
    
    
    init(frame: CGRect, with viewController: AddNewPlaceViewController) {
        super.init(frame: frame)
        
        self.viewController = viewController
        self.backgroundColor = #colorLiteral(red: 0.4078431373, green: 0.6941176471, blue: 0.09411764706, alpha: 1)
        
        let placeholderFont = UIFont(name: "OpenSans", size: 14.0)
        let textFieldFont = UIFont(name: "OpenSans", size: 18.0)
        let attributesDictionary: [NSAttributedStringKey: Any] = [
            NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue): #colorLiteral(red: 0.6257788431, green: 0.6374320992, blue: 0.6723918676, alpha: 1),
            NSAttributedStringKey(rawValue: NSAttributedStringKey.font.rawValue): placeholderFont!]
        
        let atributedPlaceholder = NSMutableAttributedString(string: "name of place")
        atributedPlaceholder.addAttributes(attributesDictionary, range: NSRange (location:0, length: atributedPlaceholder.length))
        
        let placeNameTextField = UITextField(frame: CGRect(x: 25, y: 15, width: frame.size.width - 50, height: 45))
        placeNameTextField.borderStyle = .roundedRect
        placeNameTextField.attributedPlaceholder = atributedPlaceholder
        self.addSubview(placeNameTextField)
        placeNameTextField.delegate = viewController
        self.placeName = placeNameTextField
        
        let addPhotoButton = UIButton(frame: CGRect(x: placeNameTextField.bounds.maxX - 45, y: 5, width: 45, height: 45)) // it should be 35 x 35, but I changed it to test without problems
        let clipIcon = UIImage(named: "clipIcon.png")
        addPhotoButton.setImage(clipIcon, for: UIControlState.normal)
        addPhotoButton.addTarget(viewController, action: #selector(AddNewPlaceViewController.addImage), for: .touchUpInside)
        placeNameTextField.addSubview(addPhotoButton)
        placeNameTextField.bringSubview(toFront: addPhotoButton)
        
        let placeInfoTextView = UITextView(frame: CGRect(x: 20, y: 75, width: frame.size.width - 40, height: 65))
        placeInfoTextView.font = textFieldFont!
        placeInfoTextView.isEditable = true
        placeInfoTextView.layer.cornerRadius = 4
        placeInfoTextView.delegate = viewController
        self.addSubview(placeInfoTextView)
        self.placeDescr = placeInfoTextView

        
        let placeHolderLabel = UILabel(frame: CGRect(x: 20, y: 85, width: frame.size.width - 30, height: 65))
        placeHolderLabel.backgroundColor = .clear
        atributedPlaceholder.mutableString.setString("Describe spot here")
        placeHolderLabel.attributedText = atributedPlaceholder
        self.addSubview(placeHolderLabel)
        
        for i in 0...3 {
            let imageMergin = 25
            let image = UIImageView(frame: CGRect(x: imageMergin + (i * (10 + 65)), y: 155, width: 65, height: 65))
            image.layer.cornerRadius = 5.0
            image.tag = i
            self.addSubview(image)
            self.photosCollection.append(image)
        }
        
        
            let savePlaceBarButton = UIBarButtonItem(title: "Save spot", style: .plain, target: viewController, action: #selector(AddNewPlaceViewController.savePlace))
            viewController.navigationItem.rightBarButtonItem = savePlaceBarButton
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



