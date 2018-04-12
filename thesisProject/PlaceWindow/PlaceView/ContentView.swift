//
//  ContentView.swift
//  thesisProject
//
//  Created by Nikita Kechinov on 10.04.2018.
//  Copyright © 2018 Nikita Kechinov. All rights reserved.
//

import UIKit

class ContentView: UIView {
    var image: UIImageView?
    var pageControl: UIPageControl?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        image.clipsToBounds = true
        self.addSubview(image)
        self.image = image
    
        let pageControl = UIPageControl(frame: CGRect(x: self.bounds.width / 2 - 25, y: self.bounds.height - 35, width: 50, height: 25))
        self.pageControl = pageControl
        self.pageControl!.layer.cornerRadius = 7.0
        self.pageControl!.pageIndicatorTintColor = #colorLiteral(red: 0.3647058824, green: 0.6549019608, blue: 0.04705882353, alpha: 1)
        self.pageControl!.currentPageIndicatorTintColor = #colorLiteral(red: 0.2549019608, green: 0.4588235294, blue: 0.01960784314, alpha: 1)
        self.pageControl!.backgroundColor = UIColor(red: 235 / 255.0, green: 242 / 255.0, blue: 243 / 255.0, alpha: 0.5)
        self.addSubview(self.pageControl!)
        self.bringSubview(toFront: self.pageControl!)
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
