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
        
        self.backgroundColor = UIColor(red: 93 / 255.0, green: 167 / 255.0, blue: 12 / 255.0, alpha: 0.6)
        self.layer.cornerRadius = 10.0
        
        let showRouteButton = UIButton(frame: CGRect(x: 10, y: self.bounds.size.height / 6, width: self.bounds.size.width / 5 * 2, height: self.bounds.size.height / 3 * 2))
        showRouteButton.backgroundColor = #colorLiteral(red: 0.4431372549, green: 0.5647058824, blue: 0.8784313725, alpha: 1)
        showRouteButton.setTitle("Show route", for: .normal)
        showRouteButton.titleLabel!.font = UIFont(name: "Helvetica", size: 10)
        self.addSubview(showRouteButton)
        
        let distanceLable = UILabel(frame: CGRect(x: self.bounds.size.width / 5 * 3 + 10, y: self.bounds.size.height / 6, width: self.bounds.size.width / 5 * 2 - 10, height: self.bounds.size.height / 18 * 5))
        distanceLable.font = UIFont(name: "Helvetica", size: 10)
        distanceLable.textColor = .white
        self.distanceLable = distanceLable
        self.addSubview(distanceLable)
        
        let timeLabel = UILabel(frame: CGRect(x: self.bounds.size.width / 5 * 3 + 10, y: self.bounds.size.height / 18 * 7, width: self.bounds.size.width / 5 * 2 - 10, height: self.bounds.size.height / 18 * 5))
        timeLabel.font = UIFont(name: "Helvetica", size: 10)
        timeLabel.textColor = .white
        self.timeLable = timeLabel
        self.addSubview(timeLabel)
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
