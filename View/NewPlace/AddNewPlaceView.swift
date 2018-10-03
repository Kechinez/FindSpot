//
//  AddNewPlaceView.swift
//  thesisProject
//
//  Created by Nikita Kechinov on 02.04.2018.
//  Copyright © 2018 Nikita Kechinov. All rights reserved.
//

import UIKit
import GoogleMaps

class AddNewPlaceView: UIScrollView {
    
    public let mapView: GMSMapView = {
        let map = GMSMapView()
        map.layer.borderColor = #colorLiteral(red: 0.6257788431, green: 0.6374320992, blue: 0.6723918676, alpha: 1)
        map.layer.borderWidth = 1.0
        map.alpha = 0.2
        return map
    }()
    public let backgroundView: UIImageView = {
        let backgroundView = UIImageView(image: UIImage(named: "Leaves.png"))
        backgroundView.alpha = 0.45
        return backgroundView
    }()
    public let greyView: UIView = {
        let greyView = UIView()
        greyView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return greyView
    }()
    public let switchLabel: UILabel = {
        let switchLabel = UILabel()
        let font = UIFont(name: "OpenSans", size: 18.0)
        switchLabel.font = font!
        switchLabel.textColor = .white
        switchLabel.text = "find a location manually "
        return switchLabel
    }()
    public let locationSwitch: UISwitch = {
        let locationSwitch = UISwitch()
        locationSwitch.onTintColor = #colorLiteral(red: 0.8701816307, green: 0.8701816307, blue: 0.8701816307, alpha: 1)
        return locationSwitch
    }()
    public let placeNameTextField: UITextField = {
        let placeNameTextField = UITextField()
        placeNameTextField.borderStyle = .roundedRect
        placeNameTextField.setTextAndFont(.PlaceNameTextField)
        placeNameTextField.setKeyboardSettings(.PlaceNameTextField)
        return placeNameTextField
    }()
    public let addPhotoButton: UIButton = {
        let addPhotoButton = UIButton()
        let clipIcon = UIImage(named: "clipIcon.png")
        addPhotoButton.setImage(clipIcon, for: UIControlState.normal)
        return addPhotoButton
    }()
    public let placeInfoTextView: UITextView = {
        let placeInfoTextView = UITextView()
        let font = UIFont(name: "OpenSans", size: 18.0)
        placeInfoTextView.font = font!
        placeInfoTextView.isEditable = true
        placeInfoTextView.layer.cornerRadius = 4
        return placeInfoTextView
    }()
    public let placeHolderLabel: UILabel = {
        let placeHolderLabel = UILabel()
        placeHolderLabel.backgroundColor = .clear
        let placeholderFont = UIFont(name: "OpenSans", size: 14.0)
        let attributesDictionary: [NSAttributedStringKey: Any] = [
            NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue): #colorLiteral(red: 0.6257788431, green: 0.6374320992, blue: 0.6723918676, alpha: 1),
            NSAttributedStringKey(rawValue: NSAttributedStringKey.font.rawValue): placeholderFont!]
        let atributedPlaceholder = NSMutableAttributedString(string: "Describe spot here")
        atributedPlaceholder.addAttributes(attributesDictionary, range: NSRange (location:0, length: atributedPlaceholder.length))
        placeHolderLabel.attributedText = atributedPlaceholder
        return placeHolderLabel
    }()
    public let imagesCollectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 1.0, height: 1.0)
        let imagesCollection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        imagesCollection.backgroundColor = UIColor.clear
        imagesCollection.isScrollEnabled = false
        return imagesCollection
    }()
    public let contentView: UIView = {
        return UIView(frame: CGRect.zero)
    }()

    private var isCollectionViewConstraintsActivated = false
    private var descrLabelBottomConstraint: NSLayoutConstraint?
    private var imagesCollectionViewTopConstraint: NSLayoutConstraint?
    private var imagesCollectionViewHeightConstraint: NSLayoutConstraint?
    private var imagesCollectionViewBottomConstraint: NSLayoutConstraint?
    private var contentViewBottomConstraint: NSLayoutConstraint?
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = #colorLiteral(red: 0.4078431373, green: 0.6941176471, blue: 0.09411764706, alpha: 1)
        self.addSubview(self.contentView)
        self.contentView.addSubview(self.backgroundView)
        self.contentView.addSubview(self.greyView)
        self.contentView.addSubview(self.mapView)
        self.contentView.addSubview(self.switchLabel)
        self.contentView.addSubview(self.locationSwitch)
        self.contentView.addSubview(self.placeNameTextField)
        self.contentView.addSubview(self.placeInfoTextView)
        self.contentView.addSubview(self.placeHolderLabel)
        self.contentView.addSubview(self.imagesCollectionView)
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        
        for subview in self.contentView.subviews {
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
        
        self.placeNameTextField.addSubview(self.addPhotoButton)
        self.placeNameTextField.bringSubview(toFront: self.addPhotoButton)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        self.imagesCollectionView.backgroundColor = UIColor.clear
        self.imagesCollectionView.register(UserImagesCell.self, forCellWithReuseIdentifier: "NewPlaceViewCell")
    
        self.setUpConstraints()
    }
    
    
    func setDelegateOfTextFields(using viewController: AddNewPlaceViewController) {
        self.placeNameTextField.delegate = viewController
        self.placeInfoTextView.delegate = viewController
    }
    
    
    func setActionMethods(linkedWith viewController: AddNewPlaceViewController) {
        self.locationSwitch.addTarget(viewController, action: #selector(AddNewPlaceViewController.switchSourceOfLocation), for: .allEvents)
        self.addPhotoButton.addTarget(viewController, action: #selector(AddNewPlaceViewController.addImage), for: .touchUpInside)
    }
    
    
    func setBarButtonItems(linkedWith viewController: AddNewPlaceViewController) {
        let savePlaceBarButton = UIBarButtonItem(title: "Save spot", style: .plain, target: viewController, action: #selector(AddNewPlaceViewController.savePlace))
            viewController.navigationItem.rightBarButtonItem = savePlaceBarButton
    }
    
    
    private func setUpConstraints() {

        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.contentViewBottomConstraint = self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        self.contentViewBottomConstraint!.isActive = true
        self.contentView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        
        self.backgroundView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        self.backgroundView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor).isActive = true
        self.backgroundView.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.5).isActive = true
        
        self.greyView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20).isActive = true
        self.greyView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20).isActive = true
        self.greyView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20).isActive = true
        self.greyView.heightAnchor.constraint(equalTo: self.contentView.widthAnchor).isActive = true
        
        self.mapView.topAnchor.constraint(equalTo: self.greyView.topAnchor).isActive = true
        self.mapView.leadingAnchor.constraint(equalTo: self.greyView.leadingAnchor).isActive = true
        self.mapView.trailingAnchor.constraint(equalTo: self.greyView.trailingAnchor).isActive = true
        self.mapView.heightAnchor.constraint(equalTo: self.greyView.heightAnchor).isActive = true
        
        self.switchLabel.topAnchor.constraint(equalTo: self.greyView.bottomAnchor, constant: 20).isActive = true
        self.switchLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20).isActive = true
        self.switchLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.locationSwitch.topAnchor.constraint(equalTo: self.greyView.bottomAnchor, constant: 20).isActive = true
        self.locationSwitch.leadingAnchor.constraint(equalTo: self.switchLabel.trailingAnchor).isActive = true
        self.locationSwitch.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.locationSwitch.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20).isActive = true
        
        self.placeNameTextField.topAnchor.constraint(equalTo: self.switchLabel.bottomAnchor, constant: 20).isActive = true
        self.placeNameTextField.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20).isActive = true
        self.placeNameTextField.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20).isActive = true
        self.placeNameTextField.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        self.addPhotoButton.translatesAutoresizingMaskIntoConstraints = false
        self.addPhotoButton.widthAnchor.constraint(equalToConstant: 45).isActive = true
        self.addPhotoButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        self.addPhotoButton.topAnchor.constraint(equalTo: self.placeNameTextField.topAnchor).isActive = true
        self.addPhotoButton.leadingAnchor.constraint(equalTo: self.placeNameTextField.trailingAnchor, constant: -45).isActive = true
        
        self.placeInfoTextView.topAnchor.constraint(equalTo: self.placeNameTextField.bottomAnchor, constant: 20).isActive = true
        self.placeInfoTextView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20).isActive = true
        self.placeInfoTextView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20).isActive = true
        self.placeInfoTextView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        self.descrLabelBottomConstraint = self.placeInfoTextView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -20)
        self.descrLabelBottomConstraint!.isActive = true
        
        self.placeHolderLabel.translatesAutoresizingMaskIntoConstraints = false
        self.placeHolderLabel.topAnchor.constraint(equalTo: self.placeInfoTextView.topAnchor, constant: 3).isActive = true
        self.placeHolderLabel.leadingAnchor.constraint(equalTo: self.placeInfoTextView.leadingAnchor, constant: 4).isActive = true
        self.placeHolderLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.imagesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        self.imagesCollectionViewTopConstraint = self.imagesCollectionView.topAnchor.constraint(equalTo: self.placeInfoTextView.bottomAnchor, constant: 20)
        self.imagesCollectionViewBottomConstraint = self.imagesCollectionView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -20)
        self.imagesCollectionView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20).isActive = true
        self.imagesCollectionView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20).isActive = true
        
    }
    
    
    
    func isPlaceholderLabelHidden(bool: Bool) {
        if bool {
            self.placeHolderLabel.alpha = 0.0
        } else {
            self.placeHolderLabel.alpha = 1.0
        }
    }
    
    
    
    
    //MARK: - Map interaction methods
    
    
    func setMarkerOnTheMap(with coordinates: CLLocationCoordinate2D) {
        self.mapView.alpha = 1.0
        let placeMarker = GMSMarker(position: coordinates)
        placeMarker.map = self.mapView
    }
    
    
    func setCameraOnTheMap(with coordinates: CLLocationCoordinate2D) {
        self.mapView.alpha = 1.0
        let camera = GMSCameraPosition.camera(withLatitude: coordinates.latitude, longitude: coordinates.longitude, zoom: 15.0)
        self.mapView.animate(to: camera)
    }
    
    
    
    
    //MARK: - Keyboard methods updating autolayout
    
    func increaseContentHeightWhileShowingKeyboard(with keyboardRect: CGRect, currentImageTag: Int) {
        var frameOfCurrentFirstResponder = CGRect.zero
        if self.placeNameTextField.isFirstResponder {
            frameOfCurrentFirstResponder = self.placeNameTextField.frame
        } else {
            frameOfCurrentFirstResponder = self.placeInfoTextView.frame
        }
        var constraintHeight: CGFloat = 0.0
        
        switch currentImageTag {
        case 0:
            let deltaHeight = self.placeInfoTextView.frame.maxY - keyboardRect.height
            constraintHeight = frameOfCurrentFirstResponder.maxY - deltaHeight  + 6
            self.descrLabelBottomConstraint!.isActive = false
            self.descrLabelBottomConstraint = self.placeInfoTextView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -constraintHeight)
            self.descrLabelBottomConstraint!.isActive = true
        case 1...2:
            let deltaHeight = imagesCollectionView.frame.maxY - keyboardRect.height
            constraintHeight = frameOfCurrentFirstResponder.maxY - deltaHeight + 6
            self.imagesCollectionViewBottomConstraint!.isActive = false
            self.imagesCollectionViewBottomConstraint = self.imagesCollectionView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -constraintHeight)
            self.imagesCollectionViewBottomConstraint!.isActive = true
        case 3...4:
            let deltaHeight = self.imagesCollectionView.frame.maxY - keyboardRect.height
            constraintHeight = deltaHeight - frameOfCurrentFirstResponder.maxY - 6
            self.imagesCollectionViewBottomConstraint!.isActive = false
            self.imagesCollectionViewBottomConstraint = self.imagesCollectionView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: constraintHeight)
            self.imagesCollectionViewBottomConstraint!.isActive = true
        default: break
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            self.layoutIfNeeded()
        })
        
        let keyboardOriginY = self.bounds.height - keyboardRect.height
        let deltaHeight = frameOfCurrentFirstResponder.maxY + 6 - keyboardOriginY
        let pointOffSet = CGPoint(x: 0, y: deltaHeight)
        self.setContentOffset(pointOffSet, animated: true)
    }
    
    
    func decreaseContentHeightWhileShowingKeyboard(with currentImageTag: Int) {
        
        switch currentImageTag {
        case 0:
            self.descrLabelBottomConstraint!.isActive = false
            self.descrLabelBottomConstraint = self.placeInfoTextView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -20)
            self.descrLabelBottomConstraint!.isActive = true
        case 1...4:
            self.imagesCollectionViewBottomConstraint!.isActive = false
            self.imagesCollectionViewBottomConstraint = self.imagesCollectionView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -20)
            self.imagesCollectionViewBottomConstraint!.isActive = true
        default: break
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            self.layoutIfNeeded()
        })
    }
    
    
    
    
    //MARK: - Methods updating image collectionView height while adding new user photos
    
    func increaseHeightOfImageCollectionXTimesBigger(x: Int) {
        let imageSide = (self.bounds.width - 40) / 2 - 10
        
        switch x {
        case 1:
            self.descrLabelBottomConstraint!.isActive = false
            self.imagesCollectionViewTopConstraint!.isActive = true
            self.imagesCollectionViewBottomConstraint!.isActive = true
            self.imagesCollectionViewHeightConstraint = self.imagesCollectionView.heightAnchor.constraint(equalToConstant: imageSide)
            self.imagesCollectionViewHeightConstraint!.isActive = true
            self.isCollectionViewConstraintsActivated = true
        case 3:
            self.imagesCollectionViewHeightConstraint!.isActive = false
            self.imagesCollectionViewHeightConstraint = self.imagesCollectionView.heightAnchor.constraint(equalToConstant: imageSide * 2)
            self.imagesCollectionViewHeightConstraint!.isActive = true
            self.imagesCollectionViewBottomConstraint!.isActive = false
            self.imagesCollectionViewBottomConstraint = self.imagesCollectionView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -20)
            self.imagesCollectionViewBottomConstraint!.isActive = true
        default: break
        }
        
        UIView.animate(withDuration: 0.3){
            self.layoutIfNeeded()
        }
    }
    
    
    func decreaseHeightOfImageCollectionXTimesFewer(x: Int) {
        let imageSide = (self.bounds.width - 40) / 2 - 10
        
        switch x {
        case 1:
            self.descrLabelBottomConstraint = self.placeInfoTextView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -20)
            self.descrLabelBottomConstraint!.isActive = true
            self.imagesCollectionViewTopConstraint!.isActive = false
            self.imagesCollectionViewBottomConstraint!.isActive = false
            self.imagesCollectionViewHeightConstraint!.isActive = false
            self.isCollectionViewConstraintsActivated = false
        case 3:
            self.imagesCollectionViewHeightConstraint!.isActive = false
            self.imagesCollectionViewHeightConstraint = self.imagesCollectionView.heightAnchor.constraint(equalToConstant: imageSide)
            self.imagesCollectionViewHeightConstraint!.isActive = true
            self.imagesCollectionViewBottomConstraint!.isActive = false
            self.imagesCollectionViewBottomConstraint = self.imagesCollectionView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -20)
            self.imagesCollectionViewBottomConstraint!.isActive = true
        default: break
        }
        
        UIView.animate(withDuration: 0.3){
            self.layoutIfNeeded()
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    
    
}



