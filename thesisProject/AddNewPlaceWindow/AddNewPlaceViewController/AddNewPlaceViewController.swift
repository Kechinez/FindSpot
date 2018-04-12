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

class AddNewPlaceViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var uploadedPhotos: [UserLibraryPhoto] = []
    var imageViews: [UIImageView] = []
    var newPlaceView: AddNewPlaceView?
    private var imageTag = 0
    private let photoManager = PhotoManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tabBarHeight = self.tabBarController?.tabBar.frame.height ?? 0.0
        let topBarHeight = UIApplication.shared.statusBarFrame.size.height +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
        let newPlaceView = AddNewPlaceView(frame: CGRect(x: 0, y: topBarHeight, width: self.view.frame.size.width, height: self.view.frame.size.height - topBarHeight - tabBarHeight), with: self)
        self.view.addSubview(newPlaceView)
        self.newPlaceView = newPlaceView
        
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
            
            print(photoLocation)
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
    
    
    func savePlace() {
        //здесь проверить, находятся ли фото в оной локации или еще что
        //self.photoManager.
        
    }
    

    
}
    


    


