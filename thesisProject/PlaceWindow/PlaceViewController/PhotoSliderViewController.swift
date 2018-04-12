//
//  PhotoSliderViewController.swift
//  thesisProject
//
//  Created by Nikita Kechinov on 10.04.2018.
//  Copyright © 2018 Nikita Kechinov. All rights reserved.
//

import UIKit

class PhotoSliderViewController: UIPageViewController {
    var currentIndex: Int?
    var images: [UIImage]?
    private var previousContentVC: ContentViewController?

    
    override init(transitionStyle style:
        UIPageViewControllerTransitionStyle, navigationOrientation: UIPageViewControllerNavigationOrientation, options: [String : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = self

        if let firstContentVC = self.displayContentViewController(atIndex: currentIndex!) {
            self.setViewControllers([firstContentVC], direction: .forward, animated: true, completion: nil)
        }
        
    }

    
    
    
    // MARK: - Additional methods
    
    func displayContentViewController(atIndex index: Int) -> ContentViewController? {
        guard index >= 0 else { return nil }
        guard index < (self.images!.count) else { return nil }
        
        let contentVC = ContentViewController()
        contentVC.image = self.images![index]
        contentVC.index = index
        contentVC.numberOfImages = self.images!.count
        return contentVC
        
    }

}




// MARK: - PhotoSliderViewController dataSource methods

extension PhotoSliderViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

        var index = (viewController as! ContentViewController).index!
        index -= 1
        return displayContentViewController(atIndex: index)
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! ContentViewController).index!
        index += 1
        return displayContentViewController(atIndex: index)
    }
    
}

