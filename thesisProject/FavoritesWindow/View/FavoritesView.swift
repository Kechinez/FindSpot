//
//  FavoritesView.swift
//  thesisProject
//
//  Created by Nikita Kechinov on 14.04.2018.
//  Copyright © 2018 Nikita Kechinov. All rights reserved.
//

import UIKit

class FavoritesView: UIView {

    var tableView: UITableView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        
        let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        let leavesImage = UIImage(named: "Leaves.png")
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height * 0.7))
        imageView.image = leavesImage
        imageView.alpha = 0.45
        backgroundView.addSubview(imageView)
        //self.bringSubview(toFront: backgroundView)
        backgroundView.backgroundColor = #colorLiteral(red: 0.3647058824, green: 0.6549019608, blue: 0.04705882353, alpha: 1)
        
        tableView.backgroundView = backgroundView
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .white
        self.addSubview(tableView)
        self.tableView = tableView
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
