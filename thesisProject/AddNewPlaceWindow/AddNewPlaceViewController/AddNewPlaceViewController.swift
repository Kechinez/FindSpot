//
//  AddNewPlaceViewController.swift
//  thesisProject
//
//  Created by Nikita Kechinov on 02.04.2018.
//  Copyright © 2018 Nikita Kechinov. All rights reserved.
//

import UIKit
import Photos
import GoogleMaps

class AddNewPlaceViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UITextViewDelegate, GMSMapViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var currentUserLocation: CLLocationCoordinate2D?
    var uploadedPhotos: [UIImage] = []
    var newPlaceView: AddNewPlaceView?
    private var imageTag = 0
    private var cityOfMadePhoto: String?
    private var autoChosenLocation: CLLocationCoordinate2D?
    private var manualChoosingLocation = false
    private var manualChosenLocation: CLLocationCoordinate2D?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(notification: )), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
        
        let topBarHeight = UIApplication.shared.statusBarFrame.size.height +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
        let newPlaceView = AddNewPlaceView(frame: CGRect(x: 0, y: topBarHeight, width: self.view.frame.size.width, height: self.view.frame.size.height - topBarHeight), with: self)
        //self.view.addSubview(newPlaceView)
        self.newPlaceView = newPlaceView
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let tabBarController = self.tabBarController {
            tabBarController.tabBar.isHidden = true
        }
        
    }
    
    
    
    
    
    // MARK: - UIImagePickerControllerDelegate methods
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        self.imageTag += 1
        if self.imageTag == 1 || self.imageTag == 3 {
            self.newPlaceView!.increaseHeightOfImageCollectionXTimesBigger(x: self.imageTag)
        }
        
        let selectedImage = info[UIImagePickerControllerEditedImage] as? UIImage

        ifLocationSourceisPhoto: if !self.manualChoosingLocation {
            if let asset = info[UIImagePickerControllerPHAsset] as? PHAsset {
                guard let photoLocation = asset.location else {
                    DispatchQueue.main.async {
                        let userInfo = [NSLocalizedDescriptionKey: NSLocalizedString("Couldn't read geolocation of photo! You can choose location manually.", comment: "")]
                        let error = NSError(domain: "errorDomain", code: 100, userInfo: userInfo)
                        ErrorManager.shared.showErrorMessage(with: error, shownAt: self)
                    }
                    break ifLocationSourceisPhoto
                }
                if self.autoChosenLocation == nil {
                    self.autoChosenLocation = photoLocation.coordinate
                    GoogleApiRequests.shared.coordinatesToAddressRequest(with: photoLocation.coordinate) { (city) in
                        switch city {
                        case  .Success(let foundCity):
                            self.cityOfMadePhoto = foundCity.cityName
                            self.newPlaceView!.setCameraOnTheMap(with: self.autoChosenLocation!)
                            self.newPlaceView!.setMarkerOnTheMap(with: self.autoChosenLocation!)
                        case .Failure(_):
                            let userInfo = [NSLocalizedDescriptionKey: NSLocalizedString("Couldn't define the city where photo was taken! Probably, this place is far from the nearest city.", comment: "")]
                            let updatedError = NSError(domain: "errorDomain", code: 100, userInfo: userInfo)
                            ErrorManager.shared.showErrorMessage(with: updatedError, shownAt: self)
                        }
                    }
                }
                
            }
        }
        
        self.uploadedPhotos.append(selectedImage!)
        let cellIndexPathOfImage = IndexPath(row: self.imageTag - 1, section: 0)
        self.newPlaceView!.imagesCollectionView!.reloadItems(at: [cellIndexPathOfImage])
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
    // MARK: - GMSMapViewDelegate methods:
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        if self.manualChoosingLocation {
            self.newPlaceView!.setMarkerOnTheMap(with: coordinate)
            self.manualChosenLocation = coordinate
            GoogleApiRequests.shared.coordinatesToAddressRequest(with: coordinate) { (city) in
                switch city {
                case  .Success(let foundCity):
                    self.cityOfMadePhoto = foundCity.cityName
                case .Failure(_):
                    let userInfo = [NSLocalizedDescriptionKey: NSLocalizedString("Couldn't define the city where photo was taken! Probably, this place is far from the nearest city.", comment: "")]
                    let updatedError = NSError(domain: "errorDomain", code: 100, userInfo: userInfo)
                    ErrorManager.shared.showErrorMessage(with: updatedError, shownAt: self)
                }
            }
        }
    }
    
    
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        if self.manualChoosingLocation {
            self.newPlaceView!.mapView!.clear()
            self.manualChosenLocation = nil
        }
        return true
    }
    
    
    
    
    
    // MARK: - UICollectionView DataSource methods:
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewPlaceViewCell", for: indexPath) as! UserImagesCell
        if self.uploadedPhotos.count > indexPath.row {
            cell.imageView.image = self.uploadedPhotos[indexPath.row]
            cell.addGestureRecognizer(to: self)
        } else if self.uploadedPhotos.count <= indexPath.row {
            cell.deleteGestureRecognizer()
            cell.imageView.image = nil
        }
        return cell
    }
    
    
    
    
    
    
    
    // MARK: - TextField delegate methods:
    
   
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool
    {
        if(text == "\n")
        {
            if textView.text == "" {
                self.newPlaceView!.isPlaceholderLabelHidden(bool: false)
            }
            view.endEditing(true)
            return false
        } else {
            self.newPlaceView!.isPlaceholderLabelHidden(bool: true)
            return true
        }
    }
    
    
    
    
    
    // MARK: - Additional methods:
    
    @objc func switchSourceOfLocation(_ sender: UISwitch) {
        if sender.isOn {
            self.manualChoosingLocation = true
            self.newPlaceView!.setCameraOnTheMap(with: self.currentUserLocation!)
        } else {
            self.manualChoosingLocation = false
            guard let placeLocation = self.autoChosenLocation else {
                return
            }
            self.newPlaceView!.setCameraOnTheMap(with: placeLocation)
            self.newPlaceView!.setMarkerOnTheMap(with: placeLocation)
        }
        
    }
    
    
    
    @objc func removeImage(sender: UILongPressGestureRecognizer) {
        if sender.state == UIGestureRecognizerState.ended {
            let touchedPoint = sender.location(in: self.newPlaceView!.imagesCollectionView!)
            guard let indexPathOfTouchedCell = self.newPlaceView!.imagesCollectionView!.indexPathForItem(at: touchedPoint) else { return }
            self.uploadedPhotos.remove(at: indexPathOfTouchedCell.row)
            
            if self.imageTag == 3 || self.imageTag == 1 {
                self.newPlaceView!.decreaseHeightOfImageCollectionXTimesFewer(x: self.imageTag)
            }
    
            self.imageTag -= 1
            self.newPlaceView!.imagesCollectionView!.reloadData()
        }
        
    }
    
    
    
    func isEverythingFilled() -> Bool {
        if self.newPlaceView!.placeName!.text == "" || self.newPlaceView!.placeDescr!.text == "" || self.uploadedPhotos.count == 0 || self.manualChosenLocation == nil  || self.cityOfMadePhoto == nil {
            return false
        } else {
            return true
        }
    }
    
    
    
    @objc func addImage() {
        guard self.imageTag < 5 else { return }
        let photos = PHPhotoLibrary.authorizationStatus()
        if photos == .notDetermined {
            PHPhotoLibrary.requestAuthorization({status in
                if status == .authorized {
                }
            })
        } else if photos == .authorized {
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.allowsEditing = true
                imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true, completion: nil)
            }
        }
    }
    
    
    
    @objc func savePlace() {
        guard self.isEverythingFilled() == true else { return }
        var finalLocation: CLLocationCoordinate2D?
        
        if self.manualChoosingLocation {
            finalLocation = self.manualChosenLocation
        } else {
            finalLocation = self.autoChosenLocation
        }
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        PhotoManager.shared.uploadPhotos(with: self.uploadedPhotos, and: finalLocation!) { (downloadURLs) in
            guard let downloadURLs = downloadURLs else { return }
            let newPlace = Place(placeName: self.newPlaceView!.placeName!.text!, placeDescription: self.newPlaceView!.placeDescr!.text!, photosDownloadURLs: downloadURLs, cityName: self.cityOfMadePhoto!, coordinates: finalLocation!)
            
            DataBaseManager.shared.saveNewPlace(with: newPlace, completionHandler: {
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
            })
        }
        
        if let navigationController = self.navigationController {
            navigationController.popViewController(animated: true)
        }
    }


    
    
    
    // MARK: - keyboard notification methods
    
    @objc func keyboardDidShow(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        let keyboardHeight = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue//.height
        self.newPlaceView!.increaseContentHeightWhileShowingKeyboard(with: keyboardHeight, currentImageTag: self.imageTag)
    }
    
    
    
    @objc func keyboardDidHide() {
        self.newPlaceView!.decreaseContentHeightWhileShowingKeyboard(with: self.imageTag)
    }
    

}

