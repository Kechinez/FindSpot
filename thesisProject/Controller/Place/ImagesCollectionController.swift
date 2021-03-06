//
//  ImagesCollectionController.swift
//  thesisProject
//
//  Created by Nikita Kechinov on 16.06.2018.
//  Copyright © 2018 Nikita Kechinov. All rights reserved.
//

import UIKit

private let reuseIdentifier = "ImagesCollectionCell"

class ImagesCollectionController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let expectedNumberOfImages: Int
    private var isZooming = false
    var images: [UIImage]? {
        didSet {
            self.collectionView!.reloadData()
        }
    }
    
    //MARK: - init
    init(collectionViewLayout layout: UICollectionViewLayout, expectedNumberOfItems: Int) {
        self.expectedNumberOfImages = expectedNumberOfItems
        super.init(collectionViewLayout: layout)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - ViewController life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(ImagesCollectionCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView!.isPagingEnabled = true
       
    }

    //MARK: - UICollectionView DataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.expectedNumberOfImages
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ImagesCollectionCell
        
        if self.images == nil {
            cell.setUpAndRunActivityIndicator()
        } else {
            if let images = images {
                cell.image.image = images[indexPath.row]
                cell.delegate = self
                if let activityIndncator = cell.activityIndicator {
                    activityIndncator.stopAnimating()
                }
            }
        }
        return cell
    }

    // MARK: UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print("self.view.frame is \(self.view.frame)")
        return CGSize(width: self.view.frame.width, height: self.view.frame.height)
    }

}
