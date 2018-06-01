//
//  InfoWindowView.swift
//  thesisProject
//
//  Created by Nikita Kechinov on 11.04.2018.
//  Copyright © 2018 Nikita Kechinov. All rights reserved.
//

import UIKit

class InfoWindowView: UIView {

    var distanceLable: UILabel?
    var timeLable: UILabel?
    
    init(frame: CGRect, with viewController: PlaceViewController) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(red: 104 / 255.0, green: 177 / 255.0, blue: 24 / 255.0, alpha: 0.6)
        self.layer.cornerRadius = 10.0
        
        
        let distanceLable = UILabel(frame: CGRect(x: 5, y: 5, width: self.bounds.size.width - 10, height: (self.bounds.size.height - 15) / 2))
        distanceLable.font = UIFont(name: "OpenSans", size: 14)
        distanceLable.textColor = .white
        self.distanceLable = distanceLable
        self.addSubview(distanceLable)
        
        let timeLabel = UILabel(frame: CGRect(x: 5, y: (self.bounds.size.height - 10) / 2 + 10, width: self.bounds.size.width - 10, height: (self.bounds.size.height - 15) / 2))
        timeLabel.font = UIFont(name: "OpenSans", size: 14)
        timeLabel.textColor = .white
        self.timeLable = timeLabel
        self.addSubview(timeLabel)
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
