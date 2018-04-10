//
//  PlaceViewController.swift
//  thesisProject
//
//  Created by Nikita Kechinov on 07.04.2018.
//  Copyright © 2018 Nikita Kechinov. All rights reserved.
//

import UIKit

class PlaceViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UINavigationControllerDelegate {
    private var images: [UIImage] = []
    var place: Place?
    var collectionView: UICollectionView?
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3 // потом обратить на это внимание!!!!!! из
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! ImagesCollectionCell
        if images.count > 0 {
            cell.imageView.image = images[indexPath.row]
        }
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let tabBarHeight = self.tabBarController?.tabBar.frame.height ?? 0.0
        let topBarHeight = UIApplication.shared.statusBarFrame.size.height +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
        
        let placeView = PlaceView(with: CGRect(x: 0, y: topBarHeight, width: self.view.frame.size.width, height: self.view.frame.size.height - topBarHeight), placeCoordinate: place!.coordinates, placeDescription: place!.placeDescription, corespondingVC: self)
        self.view.addSubview(placeView)
        
        let photoManager = PhotoManager()
        photoManager.getPhotoFromStorage(using: place!.photos) { (images) in
            guard let tempImages = images.threadSafeImages else { return }
            self.images = tempImages
            self.setUpImages()
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func setUpImages() {
        self.collectionView!.reloadData()
    }
    

}
