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


class AddNewPlaceViewController: UIViewController, UINavigationControllerDelegate, UITextViewDelegate, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    unowned var addNewPlaceView: AddNewPlaceView {
        return self.view as! AddNewPlaceView
    }
    var currentUserLocation: CLLocationCoordinate2D?
    var uploadedPhotos: [UIImage] = []
    private var imageTag = 0
    private var cityOfMadePhoto: String?
    private var autoChosenLocation: CLLocationCoordinate2D?
    private var manualChoosingLocation = false
    private var manualChosenLocation: CLLocationCoordinate2D?
    
    
    //MARK: ViewController lifecycle
    override func loadView() {
        self.view = AddNewPlaceView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addNewPlaceView.mapView.delegate = self
        self.addNewPlaceView.imagesCollectionView.dataSource = self
        self.addNewPlaceView.imagesCollectionView.delegate = self
        
        self.addNewPlaceView.setBarButtonItems(linkedWith: self)
        self.addNewPlaceView.setDelegateOfTextFields(using: self)
        self.addNewPlaceView.setActionMethods(linkedWith: self)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(notification: )), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let tabBarController = self.tabBarController {
            tabBarController.tabBar.isHidden = true
        }
    }

    // MARK: - supporting methods:
    @objc func switchSourceOfLocation(_ sender: UISwitch) {
        if sender.isOn {
            self.manualChoosingLocation = true
            self.addNewPlaceView.setCameraOnTheMap(with: self.currentUserLocation!)
        } else {
            self.manualChoosingLocation = false
            guard let placeLocation = self.autoChosenLocation else { return }
            self.addNewPlaceView.setCameraOnTheMap(with: placeLocation)
            self.addNewPlaceView.setMarkerOnTheMap(with: placeLocation)
        }
    }
    
    //MARK: Image logic
    @objc func removeImage(sender: UILongPressGestureRecognizer) {
        if sender.state == UIGestureRecognizerState.ended {
            let touchedPoint = sender.location(in: self.addNewPlaceView.imagesCollectionView)
            guard let indexPathOfTouchedCell = self.addNewPlaceView.imagesCollectionView.indexPathForItem(at: touchedPoint) else { return }
            self.uploadedPhotos.remove(at: indexPathOfTouchedCell.row)
            
            if self.imageTag == 3 || self.imageTag == 1 {
                self.addNewPlaceView.decreaseHeightOfImageCollectionXTimesFewer(x: self.imageTag)
            }
            self.imageTag -= 1
            self.addNewPlaceView.imagesCollectionView.reloadData()
        }
    }
    
    @objc func addImage() {
        guard self.imageTag < 5 else { return }
        let photos = PHPhotoLibrary.authorizationStatus()
        if photos == .notDetermined {
            PHPhotoLibrary.requestAuthorization({ status in
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
    
    func isEverythingFilled() -> Bool {
        if self.addNewPlaceView.placeNameTextField.text == "" || self.addNewPlaceView.placeInfoTextView.text == "" || self.uploadedPhotos.count == 0 || self.manualChosenLocation == nil  || self.cityOfMadePhoto == nil {
            return false
        } else {
            return true
        }
    }
    
    //MARK: save new place in Database
    @objc func savePlace() {
        guard self.isEverythingFilled() == true else { return }
        var finalLocation: CLLocationCoordinate2D?
        
        if self.manualChoosingLocation {
            finalLocation = self.manualChosenLocation
        } else {
            finalLocation = self.autoChosenLocation
        }
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        PhotoManager.shared.uploadPhotos(with: self.uploadedPhotos, and: finalLocation!) { [weak self] (downloadURLs) in
            guard let downloadURLs = downloadURLs else { return }
            guard let placeNameTextFieldText = self?.addNewPlaceView.placeNameTextField.text, let placeInfoTextViewText = self?.addNewPlaceView.placeInfoTextView.text, let photoCity = self?.cityOfMadePhoto else { return }
            
            let newPlace = Place(placeName: placeNameTextFieldText, placeDescription: placeInfoTextViewText, photosDownloadURLs: downloadURLs, cityName: photoCity, coordinates: finalLocation!)
            
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
        let keyboardHeight = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        self.addNewPlaceView.increaseContentHeightWhileShowingKeyboard(with: keyboardHeight, currentImageTag: self.imageTag)
    }
    
    @objc func keyboardDidHide() {
        self.addNewPlaceView.decreaseContentHeightWhileShowingKeyboard(with: self.imageTag)
    }
    
}

//MARK: - UITextFieldDelegate
extension AddNewPlaceViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            if textView.text == "" {
                self.addNewPlaceView.isPlaceholderLabelHidden(bool: false)
            }
            view.endEditing(true)
            return false
        } else {
            self.addNewPlaceView.isPlaceholderLabelHidden(bool: true)
            return true
        }
    }
}

//MARK: - UICollectionViewDataSource
extension AddNewPlaceViewController: UICollectionViewDataSource {
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
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let imageSide = (self.view.bounds.width - 40) / 2 - 10
        return CGSize(width: imageSide, height: imageSide)
    }
}

//MARK: - GMSMapViewDelegate
extension AddNewPlaceViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        if self.manualChoosingLocation {
            self.addNewPlaceView.setMarkerOnTheMap(with: coordinate)
            self.manualChosenLocation = coordinate
            GoogleApiRequests.shared.getAddressFromCoordinates(coordinate) { [weak self] (city) in
                switch city {
                case  .Success(let foundCity):
                    self?.cityOfMadePhoto = foundCity.cityName
                case .Failure(_):
                    let userInfo = [NSLocalizedDescriptionKey: NSLocalizedString("Couldn't define the city where photo was taken! Probably, this place is far from the nearest city.", comment: "")]
                    let updatedError = NSError(domain: "errorDomain", code: 100, userInfo: userInfo)
                    guard let vc = self else { return }
                    ErrorManager.shared.showErrorMessage(with: updatedError, shownAt: vc)
                }
            }
        }
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        if self.manualChoosingLocation {
            self.addNewPlaceView.mapView.clear()
            self.manualChosenLocation = nil
        }
        return true
    }
}

//MARK: - UIImagePickerControllerDelegate
extension AddNewPlaceViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.imageTag += 1
        if self.imageTag == 1 || self.imageTag == 3 {
            self.addNewPlaceView.increaseHeightOfImageCollectionXTimesBigger(x: self.imageTag)
        }
        let selectedImage = info[UIImagePickerControllerEditedImage] as? UIImage
        ifLocationSourceIsPhoto: if !self.manualChoosingLocation {
            if let asset = info[UIImagePickerControllerPHAsset] as? PHAsset {
                guard let photoLocation = asset.location else {
                    DispatchQueue.main.async {
                        let userInfo = [NSLocalizedDescriptionKey: NSLocalizedString("Couldn't read geolocation of photo! You can choose location manually.", comment: "")]
                        let error = NSError(domain: "errorDomain", code: 100, userInfo: userInfo)
                        ErrorManager.shared.showErrorMessage(with: error, shownAt: self)
                    }
                    break ifLocationSourceIsPhoto
                }
                if self.autoChosenLocation == nil {
                    self.autoChosenLocation = photoLocation.coordinate
                    
                    GoogleApiRequests.shared.getAddressFromCoordinates(photoLocation.coordinate) { [weak self] (city) in
                        switch city {
                        case  .Success(let foundCity):
                            guard let autoChosenLocation = self?.autoChosenLocation else { return }
                            self?.cityOfMadePhoto = foundCity.cityName
                            self?.addNewPlaceView.setCameraOnTheMap(with: autoChosenLocation)
                            self?.addNewPlaceView.setMarkerOnTheMap(with: autoChosenLocation)
                        
                        case .Failure(_):
                            let userInfo = [NSLocalizedDescriptionKey: NSLocalizedString("Couldn't define the city where photo was taken! Probably, this place is far from the nearest city.", comment: "")]
                            let updatedError = NSError(domain: "errorDomain", code: 100, userInfo: userInfo)
                            guard let vc = self else { return }
                            ErrorManager.shared.showErrorMessage(with: updatedError, shownAt: vc)
                        }
                    }
                }
            }
        }
        self.uploadedPhotos.append(selectedImage!)
        let cellIndexPathOfImage = IndexPath(row: self.imageTag - 1, section: 0)
        self.addNewPlaceView.imagesCollectionView.reloadItems(at: [cellIndexPathOfImage])
        picker.dismiss(animated: true, completion: nil)
    }
}
