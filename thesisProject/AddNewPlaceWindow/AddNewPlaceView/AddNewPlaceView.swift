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
    var mapView: GMSMapView?
    let viewController: AddNewPlaceViewController
    var placeName: UITextField?
    var placeDescr: UITextView?
    var imagesCollectionView: UICollectionView?
    let contentView: UIView
    private var placeholderLabel: UILabel?
    private var backgroundView: UIView?
    private var greyView: UIView?
    private var locationSwitch: UISwitch?
    private var switchLabel: UILabel?
    private var addPhotoButton: UIButton?
    private var isCollectionViewConstraintsActivated = false
    private var descrLabelBottomConstraint: NSLayoutConstraint?
    private var imagesCollectionViewTopConstraint: NSLayoutConstraint?
    private var imagesCollectionViewHeightConstraint: NSLayoutConstraint?
    private var imagesCollectionViewBottomConstraint: NSLayoutConstraint?
    private var contentViewBottomConstraint: NSLayoutConstraint?
    
    
    
    init(frame: CGRect, with viewController: AddNewPlaceViewController) {
        self.contentView = UIView(frame: CGRect.zero)
        self.viewController = viewController
        super.init(frame: frame)
        
        viewController.view.addSubview(self)
        self.addSubview(self.contentView)
        let placeholderFont = UIFont(name: "OpenSans", size: 14.0)
        let textFieldFont = UIFont(name: "OpenSans", size: 18.0)
        self.backgroundColor = #colorLiteral(red: 0.4078431373, green: 0.6941176471, blue: 0.09411764706, alpha: 1)
        
        let leavesImage = UIImage(named: "Leaves.png")
        let backgroundView = UIImageView()
        backgroundView.image = leavesImage
        backgroundView.alpha = 0.45
        self.contentView.addSubview(backgroundView)
        self.backgroundView = backgroundView
        
        let greyView = UIView()
        greyView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.contentView.addSubview(greyView)
        self.greyView = greyView
        
        let map = GMSMapView()
        map.layer.borderColor = #colorLiteral(red: 0.6257788431, green: 0.6374320992, blue: 0.6723918676, alpha: 1)
        map.layer.borderWidth = 1.0
        map.alpha = 0.2
        greyView.addSubview(map)
        self.mapView = map
        self.contentView.addSubview(self.mapView!)
        self.mapView!.delegate = viewController
        
        let switchLabel = UILabel()
        switchLabel.font = textFieldFont!
        switchLabel.textColor = .white
        switchLabel.text = "find a location manually "
        self.contentView.addSubview(switchLabel)
        self.switchLabel = switchLabel
        
        let locationSwitch = UISwitch()
        locationSwitch.addTarget(viewController, action: #selector(AddNewPlaceViewController.switchSourceOfLocation), for: .allEvents)
        locationSwitch.onTintColor = #colorLiteral(red: 0.8701816307, green: 0.8701816307, blue: 0.8701816307, alpha: 1)
        self.contentView.addSubview(locationSwitch)
        self.locationSwitch = locationSwitch
        
        let attributesDictionary: [NSAttributedStringKey: Any] = [
            NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue): #colorLiteral(red: 0.6257788431, green: 0.6374320992, blue: 0.6723918676, alpha: 1),
            NSAttributedStringKey(rawValue: NSAttributedStringKey.font.rawValue): placeholderFont!]
        
        let atributedPlaceholder = NSMutableAttributedString(string: "name of place")
        atributedPlaceholder.addAttributes(attributesDictionary, range: NSRange (location:0, length: atributedPlaceholder.length))
        
        let placeNameTextField = UITextField()
        placeNameTextField.borderStyle = .roundedRect
        placeNameTextField.attributedPlaceholder = atributedPlaceholder
        self.contentView.addSubview(placeNameTextField)
        placeNameTextField.delegate = viewController
        self.placeName = placeNameTextField
        
        
        let addPhotoButton = UIButton()
        let clipIcon = UIImage(named: "clipIcon.png")
        addPhotoButton.setImage(clipIcon, for: UIControlState.normal)
        addPhotoButton.addTarget(viewController, action: #selector(AddNewPlaceViewController.addImage), for: .touchUpInside)
        placeNameTextField.addSubview(addPhotoButton)
        placeNameTextField.bringSubview(toFront: addPhotoButton)
        self.addPhotoButton = addPhotoButton
        
        let placeInfoTextView = UITextView()
        placeInfoTextView.font = textFieldFont!
        placeInfoTextView.isEditable = true
        placeInfoTextView.layer.cornerRadius = 4
        placeInfoTextView.delegate = viewController
        self.contentView.addSubview(placeInfoTextView)
        self.placeDescr = placeInfoTextView
        
        let placeHolderLabel = UILabel()
        placeHolderLabel.backgroundColor = .clear
        atributedPlaceholder.mutableString.setString("Describe spot here")
        placeHolderLabel.attributedText = atributedPlaceholder
        self.contentView.addSubview(placeHolderLabel)
        self.placeholderLabel = placeHolderLabel
        
        let imageSide = (self.bounds.width - 40) / 2 - 10
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.itemSize = CGSize(width: imageSide, height: imageSide)
        
        let imagesCollection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        imagesCollection.backgroundColor = UIColor.clear
        imagesCollection.register(UserImagesCell.self, forCellWithReuseIdentifier: "NewPlaceViewCell")
        imagesCollection.dataSource = viewController
        imagesCollection.delegate = viewController
        imagesCollection.isScrollEnabled = false
        self.imagesCollectionView = imagesCollection
        self.contentView.addSubview(imagesCollection)
        
        let savePlaceBarButton = UIBarButtonItem(title: "Save spot", style: .plain, target: viewController, action: #selector(AddNewPlaceViewController.savePlace))
        viewController.navigationItem.rightBarButtonItem = savePlaceBarButton
        
        self.setUpConstraints()
        
    }
    
    
    
    private func setUpConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: self.viewController.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.widthAnchor.constraint(equalTo: self.viewController.view.widthAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: self.viewController.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.contentViewBottomConstraint = self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        self.contentViewBottomConstraint!.isActive = true
        self.contentView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        
        self.backgroundView!.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundView!.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        self.backgroundView!.widthAnchor.constraint(equalTo: self.contentView.widthAnchor).isActive = true
        self.backgroundView!.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.5).isActive = true
        
        self.greyView!.translatesAutoresizingMaskIntoConstraints = false
        self.greyView!.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20).isActive = true
        self.greyView!.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20).isActive = true
        self.greyView!.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20).isActive = true
        self.greyView!.heightAnchor.constraint(equalTo: self.contentView.widthAnchor).isActive = true
        
        self.mapView!.translatesAutoresizingMaskIntoConstraints = false
        self.mapView!.topAnchor.constraint(equalTo: self.greyView!.topAnchor).isActive = true
        self.mapView!.leadingAnchor.constraint(equalTo: self.greyView!.leadingAnchor).isActive = true
        self.mapView!.trailingAnchor.constraint(equalTo: self.greyView!.trailingAnchor).isActive = true
        self.mapView!.heightAnchor.constraint(equalTo: self.greyView!.heightAnchor).isActive = true
        
        self.switchLabel!.translatesAutoresizingMaskIntoConstraints = false
        self.switchLabel!.topAnchor.constraint(equalTo: self.greyView!.bottomAnchor, constant: 20).isActive = true
        self.switchLabel!.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20).isActive = true
        self.switchLabel!.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.locationSwitch!.translatesAutoresizingMaskIntoConstraints = false
        self.locationSwitch!.topAnchor.constraint(equalTo: self.greyView!.bottomAnchor, constant: 20).isActive = true
        self.locationSwitch!.leadingAnchor.constraint(equalTo: self.switchLabel!.trailingAnchor).isActive = true
        self.locationSwitch!.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.locationSwitch!.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20).isActive = true
        
        self.placeName!.translatesAutoresizingMaskIntoConstraints = false
        self.placeName!.topAnchor.constraint(equalTo: self.switchLabel!.bottomAnchor, constant: 20).isActive = true
        self.placeName!.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20).isActive = true
        self.placeName!.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20).isActive = true
        self.placeName!.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        self.addPhotoButton!.translatesAutoresizingMaskIntoConstraints = false
        self.addPhotoButton!.widthAnchor.constraint(equalToConstant: 45).isActive = true
        self.addPhotoButton!.heightAnchor.constraint(equalToConstant: 45).isActive = true
        self.addPhotoButton!.topAnchor.constraint(equalTo: self.placeName!.topAnchor).isActive = true
        self.addPhotoButton!.leadingAnchor.constraint(equalTo: self.placeName!.trailingAnchor, constant: -45).isActive = true
        
        self.placeDescr!.translatesAutoresizingMaskIntoConstraints = false
        self.placeDescr!.topAnchor.constraint(equalTo: self.placeName!.bottomAnchor, constant: 20).isActive = true
        self.placeDescr!.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20).isActive = true
        self.placeDescr!.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20).isActive = true
        self.placeDescr!.heightAnchor.constraint(equalToConstant: 80).isActive = true
        self.descrLabelBottomConstraint = self.placeDescr!.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -20)
        self.descrLabelBottomConstraint!.isActive = true
        
        self.placeholderLabel!.translatesAutoresizingMaskIntoConstraints = false
        self.placeholderLabel!.topAnchor.constraint(equalTo: self.placeDescr!.topAnchor, constant: 3).isActive = true
        self.placeholderLabel!.leadingAnchor.constraint(equalTo: self.placeDescr!.leadingAnchor, constant: 4).isActive = true
        self.placeholderLabel!.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.imagesCollectionView!.translatesAutoresizingMaskIntoConstraints = false
        self.imagesCollectionViewTopConstraint = self.imagesCollectionView!.topAnchor.constraint(equalTo: self.placeDescr!.bottomAnchor, constant: 20)
        let imageSide = (self.bounds.width - 40) / 2 - 10
        self.imagesCollectionViewHeightConstraint = self.imagesCollectionView!.heightAnchor.constraint(equalToConstant: imageSide)
        self.imagesCollectionViewBottomConstraint = self.imagesCollectionView!.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -20)
        self.imagesCollectionView!.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20).isActive = true
        self.imagesCollectionView!.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20).isActive = true
        
    }
    
    
    
    func isPlaceholderLabelHidden(bool: Bool) {
        if bool {
            self.placeholderLabel!.alpha = 0.0
        } else {
            self.placeholderLabel!.alpha = 1.0
        }
    }
    
    
    
    
    
    //MARK: - Map interaction methods
    
    
    func setMarkerOnTheMap(with coordinates: CLLocationCoordinate2D) {
        self.mapView!.alpha = 1.0
        let placeMarker = GMSMarker(position: coordinates)
        placeMarker.map = self.mapView
    }
    
    
    
    func setCameraOnTheMap(with coordinates: CLLocationCoordinate2D) {
        self.mapView!.alpha = 1.0
        let camera = GMSCameraPosition.camera(withLatitude: coordinates.latitude, longitude: coordinates.longitude, zoom: 15.0)
        self.mapView!.animate(to: camera)
    }
    
    
    
    
    
    
    //MARK: - Keyboard methods updating autolayout
    
    
    func increaseContentHeightWhileShowingKeyboard(with keyboardRect: CGRect, currentImageTag: Int) {
        var frameOfCurrentFirstResponder = CGRect.zero
        if self.placeName!.isFirstResponder {
            frameOfCurrentFirstResponder = self.placeName!.frame
        } else {
            frameOfCurrentFirstResponder = self.placeDescr!.frame
        }
        var constraintHeight: CGFloat = 0.0
        
        switch currentImageTag {
        case 0:
            let deltaHeight = self.placeDescr!.frame.maxY - keyboardRect.height
            constraintHeight = frameOfCurrentFirstResponder.maxY - deltaHeight  + 6
            self.descrLabelBottomConstraint!.isActive = false
            self.descrLabelBottomConstraint = self.placeDescr!.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -constraintHeight)
            self.descrLabelBottomConstraint!.isActive = true
        case 1...2:
            let deltaHeight = self.imagesCollectionView!.frame.maxY - keyboardRect.height
            constraintHeight = frameOfCurrentFirstResponder.maxY - deltaHeight + 6
            self.imagesCollectionViewBottomConstraint!.isActive = false
            self.imagesCollectionViewBottomConstraint = self.imagesCollectionView!.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -constraintHeight)
            self.imagesCollectionViewBottomConstraint!.isActive = true
        case 3...4:
            let deltaHeight = self.imagesCollectionView!.frame.maxY - keyboardRect.height
            constraintHeight = deltaHeight - frameOfCurrentFirstResponder.maxY - 6
            self.imagesCollectionViewBottomConstraint!.isActive = false
            self.imagesCollectionViewBottomConstraint = self.imagesCollectionView!.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: constraintHeight)
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
            self.descrLabelBottomConstraint = self.placeDescr!.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -20)
            self.descrLabelBottomConstraint!.isActive = true
        case 1...4:
            self.imagesCollectionViewBottomConstraint!.isActive = false
            self.imagesCollectionViewBottomConstraint = self.imagesCollectionView!.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -20)
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
            self.imagesCollectionViewHeightConstraint!.isActive = true
            self.isCollectionViewConstraintsActivated = true
        case 3:
            self.imagesCollectionViewHeightConstraint!.isActive = false
            self.imagesCollectionViewHeightConstraint = self.imagesCollectionView!.heightAnchor.constraint(equalToConstant: imageSide * 2)
            self.imagesCollectionViewHeightConstraint!.isActive = true
            self.imagesCollectionViewBottomConstraint!.isActive = false
            self.imagesCollectionViewBottomConstraint = self.imagesCollectionView!.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -20)
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
            self.descrLabelBottomConstraint = self.placeDescr!.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -20)
            self.descrLabelBottomConstraint!.isActive = true
            self.imagesCollectionViewTopConstraint!.isActive = false
            self.imagesCollectionViewBottomConstraint!.isActive = false
            self.imagesCollectionViewHeightConstraint!.isActive = false
            self.isCollectionViewConstraintsActivated = false
        case 3:
            self.imagesCollectionViewHeightConstraint!.isActive = false
            self.imagesCollectionViewHeightConstraint = self.imagesCollectionView!.heightAnchor.constraint(equalToConstant: imageSide)
            self.imagesCollectionViewHeightConstraint!.isActive = true
            self.imagesCollectionViewBottomConstraint!.isActive = false
            self.imagesCollectionViewBottomConstraint = self.imagesCollectionView!.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -20)
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



