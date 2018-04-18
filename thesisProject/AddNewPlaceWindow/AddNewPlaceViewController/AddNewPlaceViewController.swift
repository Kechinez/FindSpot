//
//  AddNewPlaceViewController.swift
//  thesisProject
//
//  Created by Nikita Kechinov on 02.04.2018.
//  Copyright © 2018 Nikita Kechinov. All rights reserved.
//

import UIKit
import Photos

typealias PhotosArray = (imageView: UIImageView?, location: CLLocation?)

class AddNewPlaceViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UITextViewDelegate {
    
    var uploadedPhotos: [UserLibraryPhoto] = []
    //var imageViews: [UIImageView] = []
    var newPlaceView: AddNewPlaceView?
    private var imageTag = 0
    private let photoManager = PhotoManager()
    private var cityOfMadePhoto: String?
    private var placeLocation: CLLocationCoordinate2D?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // let tabBarHeight = self.tabBarController?.tabBar.frame.height ?? 0.0
        let topBarHeight = UIApplication.shared.statusBarFrame.size.height +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
        let newPlaceView = AddNewPlaceView(frame: CGRect(x: 0, y: topBarHeight, width: self.view.frame.size.width, height: self.view.frame.size.height - topBarHeight), with: self)
        self.view.addSubview(newPlaceView)
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
        guard self.imageTag < 4 else { return }
        let selectedImageView = self.newPlaceView!.photosCollection[self.imageTag]
        
        selectedImageView.image = info[UIImagePickerControllerEditedImage] as? UIImage
        selectedImageView.contentMode = .scaleAspectFill
        selectedImageView.clipsToBounds = true
        
        if let asset = info[UIImagePickerControllerPHAsset] as? PHAsset {
            guard let photoLocation = asset.location else {
                // здесь вызвать метод, который скажет юзеру, что не удалось определить локацию фото
                return
            }
            if self.placeLocation == nil {
                self.placeLocation = photoLocation.coordinate
                let googleApiManager = GoogleApiRequests()
                googleApiManager.coordinatesToAddressRequest(with: photoLocation.coordinate) { (city) in
                    switch city {
                    case  .Success(let foundCity):
                        self.cityOfMadePhoto = foundCity.cityName
                    case .Failure(let error):
                        ErrorManager.shared.showErrorMessage(with: error, shownAt: self)
                        return
                    }
                }
            }
            
            self.uploadedPhotos.append(UserLibraryPhoto(image: selectedImageView.image!, photoLocation: photoLocation.coordinate))
        }
        
        self.imageTag += 1
        dismiss(animated: true, completion: nil)
    }
    
        
        
    @objc func addImage() {
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
        self.photoManager.uploadPhotos(with: self.uploadedPhotos) { (downloadURLs) in
            guard let downloadURLs = downloadURLs else { return }
            print(downloadURLs)
            //let databaseManager = DataBaseManager()
            let newPlace = Place(placeName: self.newPlaceView!.placeName!.text!, placeDescription: self.newPlaceView!.placeDescr!.text!, photosDownloadURLs: downloadURLs, cityName: self.cityOfMadePhoto!, coordinates: self.placeLocation!)
            
            //databaseManager.saveNewPlace(with: newPlace, completionHandler: {
                DataBaseManager.shared.saveNewPlace(with: newPlace, completionHandler: {
            })
        }
        if let navigationController = self.navigationController {
            navigationController.popToViewController(self, animated: true)
        }
    }
    
    
    
    func isEverythingFilled() -> Bool {
        if self.newPlaceView!.placeName!.text == "" || self.newPlaceView!.placeDescr!.text == "" || self.uploadedPhotos.count == 0 {
            return false
        } else {
            return true
        }
    }
    

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool
    {
        if(text == "\n")
        {
            view.endEditing(true)
            return false
        }
        else
        {
            return true
        }
    }
    
    
    
    
    
    
}
    


    


