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
    var viewController: AddNewPlaceViewController?
    var photosCollection: [UIImageView] = []
    var placeName: UITextField?
    var placeDescr: UITextView?
    private var placeholderLabel: UILabel?
    var imagesCollectionView: UICollectionView?
    
    init(frame: CGRect, with viewController: AddNewPlaceViewController) {
        super.init(frame: frame)
        
        let placeholderFont = UIFont(name: "OpenSans", size: 14.0)
        let textFieldFont = UIFont(name: "OpenSans", size: 18.0)
        
        self.viewController = viewController
        self.backgroundColor = #colorLiteral(red: 0.4078431373, green: 0.6941176471, blue: 0.09411764706, alpha: 1)
        
        let leavesImage = UIImage(named: "Leaves.png")
        let backgroundView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height * 0.6))
        backgroundView.image = leavesImage
        backgroundView.alpha = 0.45
        self.addSubview(backgroundView)
        self.bringSubview(toFront: backgroundView)
        
        let greyView = UIView(frame: CGRect(x: 20, y: 20, width: self.bounds.size.width - 40, height: self.bounds.size.width - 40))
        greyView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.addSubview(greyView)
        
        let map = GMSMapView(frame: CGRect(x: 20, y: 20, width: greyView.bounds.width, height: greyView.bounds.height))
        map.layer.borderColor = #colorLiteral(red: 0.6257788431, green: 0.6374320992, blue: 0.6723918676, alpha: 1)
        map.layer.borderWidth = 1.0
        map.alpha = 0.2
        greyView.addSubview(map)
        self.mapView = map
        self.addSubview(self.mapView!)
        self.mapView!.delegate = viewController
        
        let switchLabel = UILabel(frame: CGRect(x: 20, y: self.bounds.size.width, width: self.bounds.size.width - 70, height: 30))
        switchLabel.font = textFieldFont!
        switchLabel.textColor = .white
        switchLabel.text = "Manual choosing a location"
        self.addSubview(switchLabel)
        
        let locationSwitch = UISwitch(frame: CGRect(x: self.bounds.maxX - 65, y: self.bounds.size.width, width: 40, height: 30))
        locationSwitch.addTarget(viewController, action: #selector(AddNewPlaceViewController.switchSourceOfLocation), for: .allEvents)
        locationSwitch.onTintColor = #colorLiteral(red: 0.8701816307, green: 0.8701816307, blue: 0.8701816307, alpha: 1)
        self.addSubview(locationSwitch)
        
        
        let attributesDictionary: [NSAttributedStringKey: Any] = [
            NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue): #colorLiteral(red: 0.6257788431, green: 0.6374320992, blue: 0.6723918676, alpha: 1),
            NSAttributedStringKey(rawValue: NSAttributedStringKey.font.rawValue): placeholderFont!]
        
        let atributedPlaceholder = NSMutableAttributedString(string: "name of place")
        atributedPlaceholder.addAttributes(attributesDictionary, range: NSRange (location:0, length: atributedPlaceholder.length))
        
        let placeNameTextField = UITextField(frame: CGRect(x: 20, y: self.bounds.size.width + 50, width: frame.size.width - 40, height: 45))
        placeNameTextField.borderStyle = .roundedRect
        placeNameTextField.attributedPlaceholder = atributedPlaceholder
        self.addSubview(placeNameTextField)
        placeNameTextField.delegate = viewController
        self.placeName = placeNameTextField
        
        let addPhotoButton = UIButton(frame: CGRect(x: placeNameTextField.bounds.maxX - 45, y: 0, width: 45, height: 45))
        let clipIcon = UIImage(named: "clipIcon.png")
        addPhotoButton.setImage(clipIcon, for: UIControlState.normal)
        addPhotoButton.addTarget(viewController, action: #selector(AddNewPlaceViewController.addImage), for: .touchUpInside)
        placeNameTextField.addSubview(addPhotoButton)
        placeNameTextField.bringSubview(toFront: addPhotoButton)
        
        let placeInfoTextView = UITextView(frame: CGRect(x: 20, y: frame.size.width + 115, width: frame.size.width - 40, height: 80))
        placeInfoTextView.font = textFieldFont!
        placeInfoTextView.isEditable = true
        placeInfoTextView.layer.cornerRadius = 4
        placeInfoTextView.delegate = viewController
        self.addSubview(placeInfoTextView)
        self.placeDescr = placeInfoTextView
        
        let placeHolderLabel = UILabel(frame: CGRect(x: 25, y: frame.size.width + 120, width: frame.size.width - 60, height: 30))
        placeHolderLabel.backgroundColor = .clear
        atributedPlaceholder.mutableString.setString("Describe spot here")
        placeHolderLabel.attributedText = atributedPlaceholder
        self.addSubview(placeHolderLabel)
        self.placeholderLabel = placeHolderLabel
        
        let imageSide = (self.bounds.width - 40) / 2 - 10
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        let itemSide = imageSide
        layout.itemSize = CGSize(width: itemSide, height: itemSide)
        
        let imagesCollection = UICollectionView(frame: CGRect(x: 20, y: frame.size.width + 215, width: self.bounds.size.width - 40, height: imageSide * 2 + 30), collectionViewLayout: layout)
        imagesCollection.backgroundColor = UIColor.clear
        imagesCollection.register(UserImagesCell.self, forCellWithReuseIdentifier: "NewPlaceViewCell")
        imagesCollection.dataSource = viewController
        imagesCollection.delegate = viewController
        self.imagesCollectionView = imagesCollection
        self.addSubview(imagesCollection)
        
        self.contentSize = CGSize(width: self.bounds.width, height: self.bounds.height + 40)
        self.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: self.bounds.height, right: 0)
        
        
        let savePlaceBarButton = UIBarButtonItem(title: "Save spot", style: .plain, target: viewController, action: #selector(AddNewPlaceViewController.savePlace))
        viewController.navigationItem.rightBarButtonItem = savePlaceBarButton
    
    }
    
    
    func isPlaceholderLabelHidden(bool: Bool) {
        if bool {
            self.placeholderLabel!.alpha = 0.0
        } else {
           self.placeholderLabel!.alpha = 1.0
        }
    }
    
    
    
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
    
    
    
    func increaseHeightOfScrollView(onImageHeightWith multiplier: Int?, or particularValue: CGFloat?) {
        var frame = CGSize.zero
        if let multiplier = multiplier {
            let imageSide = (self.bounds.width - 40) / 2 - 10
            switch multiplier {
            case 0: frame = CGSize(width: self.bounds.width, height: self.bounds.height + imageSide + 50)
            case 2: frame = CGSize(width: self.bounds.width, height: self.bounds.height + 2 * imageSide + 60)
            default: break
            }
        } else {
            frame = CGSize(width: self.bounds.width, height: self.bounds.height + 40 + particularValue!)
            }

        UIView.transition(with: self, duration: 0.4 , options: .curveEaseOut, animations: {
            self.contentSize = frame
        }, completion: nil)
    }
    
    
    
    func decreaseHeightOfScrollView(onImageHeightWith multiplier: Int?) {
        var frame = CGSize.zero
        if let multiplier = multiplier {
            let imageSide = (self.bounds.width - 40) / 2 - 10
            switch multiplier {
            case 1: frame = CGSize(width: self.bounds.width, height: self.bounds.height + 40)
            case 3: frame = CGSize(width: self.bounds.width, height: self.bounds.height + imageSide + 50)
            default: break
            }
        } else {
           frame = CGSize(width: self.bounds.width, height: self.bounds.height + 40)
        }
        
        UIView.transition(with: self, duration: 0.4 , options: .curveEaseOut, animations: {
            self.contentSize = frame
        }, completion: nil)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



