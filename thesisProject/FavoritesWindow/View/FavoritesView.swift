//
//  FavoritesView.swift
//  thesisProject
//
//  Created by Nikita Kechinov on 14.04.2018.
//  Copyright © 2018 Nikita Kechinov. All rights reserved.
//

import UIKit

class FavoritesView: UIView {

    public let backgroundView: UIView = {
        let backgroundView = UIView(frame: CGRect.zero)
        backgroundView.backgroundColor = #colorLiteral(red: 0.4078431373, green: 0.6941176471, blue: 0.09411764706, alpha: 1)
        return backgroundView
    }()
    public let leavesImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Leaves.png"))
        imageView.alpha = 0.45
        return imageView
    }()

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.backgroundView)
        self.backgroundView.addSubview(self.leavesImageView)
        self.setUpConstraints()
    }
    
    
    private func setUpConstraints() {
        
        self.backgroundView.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.backgroundView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        self.backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.backgroundView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
        self.leavesImageView.translatesAutoresizingMaskIntoConstraints = false
        self.leavesImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.leavesImageView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        self.leavesImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.7).isActive = true
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
