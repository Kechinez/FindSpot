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
    private var backgroundView: UIView?
    private var imageView: UIImageView?
    private let viewController: FavoritesViewController
    
    init(viewController: FavoritesViewController) {
        self.viewController = viewController
        super.init(frame: CGRect.zero)
        viewController.view.addSubview(self)
        
        let backgroundView = UIView(frame: CGRect.zero)
        backgroundView.backgroundColor = #colorLiteral(red: 0.4078431373, green: 0.6941176471, blue: 0.09411764706, alpha: 1)
        self.backgroundView = backgroundView
        
        let leavesImage = UIImage(named: "Leaves.png")
        let imageView = UIImageView()
        imageView.image = leavesImage
        imageView.alpha = 0.45
        self.imageView = imageView
        backgroundView.addSubview(imageView)
        
        let tableView = UITableView()
        tableView.backgroundView = backgroundView
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .white
        self.addSubview(tableView)
        self.tableView = tableView
    
        self.setUpConstraints()
    }
    
    
    
    private func setUpConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: self.viewController.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.widthAnchor.constraint(equalTo: self.viewController.view.widthAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: self.viewController.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        self.tableView!.translatesAutoresizingMaskIntoConstraints = false
        self.tableView!.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.tableView!.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        self.tableView!.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        self.backgroundView!.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundView!.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.backgroundView!.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        self.backgroundView!.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        self.imageView!.translatesAutoresizingMaskIntoConstraints = false
        self.imageView!.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.imageView!.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        self.imageView!.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.7).isActive = true
        
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
