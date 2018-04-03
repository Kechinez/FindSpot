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

class AddNewPlaceViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var uploadedPhotos: [PhotosArray] = []
    var imageViews: [UIImageView] = []
    var selectedRow: IndexPath?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tabBarHeight = self.tabBarController?.tabBar.frame.height ?? 0.0
        let topBarHeight = UIApplication.shared.statusBarFrame.size.height +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
        let viewshechka = AddNewPlaceView(frame: CGRect(x: 0, y: topBarHeight, width: self.view.frame.size.width, height: self.view.frame.size.height - topBarHeight - tabBarHeight), with: self)
        
        self.view.addSubview(viewshechka)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    
    // MARK: - UICollectionView Delegate and DataSource methods
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! ImagePickerViewCell
        
        //cell.backgroundColor = .red
        uploadedPhotos.append((imageView: cell.imageView, location: nil))
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedRow = indexPath
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }
    
    }
    
    
    
    
    // MARK: - UIImagePickerControllerDelegate methods
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let index = self.selectedRow!.row
        let selectedImageView = self.uploadedPhotos[index].imageView
        
        selectedImageView!.image = info[UIImagePickerControllerEditedImage] as? UIImage
        selectedImageView!.contentMode = .scaleAspectFill
        selectedImageView!.clipsToBounds = true
        
        let asset = info[UIImagePickerControllerPHAsset] //as? PHAsset {    // в ассет почему-то нил. Скорее всего это из-за того, что дефолтные фото в эмуляторе айфона не имеют никакой локации
//            guard let photoLocation = asset.location else {
//                // здесь вызвать метод, который скажет юзеру, что не удалось определить локацию фото
//                return
//            }
//            self.uploadedPhotos[index].location = photoLocation
        
       // }
    
        dismiss(animated: true, completion: nil)
        print(self.uploadedPhotos[index].location)
    }
    
    
    
    

    

}
