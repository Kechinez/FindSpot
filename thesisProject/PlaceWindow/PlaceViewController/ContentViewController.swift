//
//  ContentViewController.swift
//  thesisProject
//
//  Created by Nikita Kechinov on 10.04.2018.
//  Copyright © 2018 Nikita Kechinov. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {
    var image: UIImage?
    var index: Int?
    var numberOfImages: Int?
    override func viewDidLoad() {
        super.viewDidLoad()

        let topBarHeight = UIApplication.shared.statusBarFrame.size.height +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
        let contentView = ContentView(frame: CGRect(x: 0, y: topBarHeight, width: self.view.frame.size.width, height: self.view.frame.size.height - topBarHeight))
        self.view.addSubview(contentView)
        
        contentView.image!.image = self.image!
        contentView.pageControl!.numberOfPages = numberOfImages!
        contentView.pageControl!.currentPage = index!
        
        
    }

    

}
