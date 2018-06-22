//
//  ImagesViewCell.swift
//  thesisProject
//
//  Created by Nikita Kechinov on 16.06.2018.
//  Copyright © 2018 Nikita Kechinov. All rights reserved.
//

import UIKit

class ImagesCollectionCell: UICollectionViewCell, UIGestureRecognizerDelegate {
    public let image: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    var delegate: ImagesCollectionController?
    var activityIndicator: UIActivityIndicatorView?
    private var isZooming = false
    private var originalImageCenter: CGPoint?
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.clipsToBounds = false
        self.contentView.addSubview(image)
        self.setUpConstraints()
        
        let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(self.zoomImage(sender:)))
        pinchGestureRecognizer.delegate = self
        self.image.addGestureRecognizer(pinchGestureRecognizer)
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.moveZoomedImage(sender:)))
        self.image.addGestureRecognizer(panGestureRecognizer)
        panGestureRecognizer.delegate = self
        
    }
    
    
    @objc func moveZoomedImage(sender: UIPanGestureRecognizer) {
        if self.isZooming && sender.state == .began {
            self.originalImageCenter = sender.view?.center
        } else if self.isZooming && sender.state == .changed {
            let translation = sender.translation(in: self)
            if let view = sender.view {
                view.center = CGPoint(x:view.center.x + translation.x,
                                      y:view.center.y + translation.y)
            }
            sender.setTranslation(CGPoint.zero, in: self.image.superview)
        }
    }
    
    
    @objc func zoomImage(sender: UIPinchGestureRecognizer) {
        
        if sender.state == .began {
            let currentScale = self.image.frame.size.width / self.image.bounds.size.width
            let newScale = currentScale*sender.scale
            
            if newScale > 1 {
                self.isZooming = true
                self.delegate!.collectionView!.isPagingEnabled = false
                self.delegate!.collectionView!.isScrollEnabled = false
            }
        } else if sender.state == .changed {
            guard let view = sender.view else { return }
            
            let pinchCenter = CGPoint(x: sender.location(in: view).x - view.bounds.midX,
                                      y: sender.location(in: view).y - view.bounds.midY)
            let transform = view.transform.translatedBy(x: pinchCenter.x, y: pinchCenter.y)
                .scaledBy(x: sender.scale, y: sender.scale)
                .translatedBy(x: -pinchCenter.x, y: -pinchCenter.y)
        
            let currentScale = self.image.frame.size.width / self.image.bounds.size.width
            var newScale = currentScale * sender.scale
            if newScale < 1 {
                newScale = 1
                let transform = CGAffineTransform(scaleX: newScale, y: newScale)
                self.image.transform = transform
                sender.scale = 1
            } else {
                view.transform = transform
                sender.scale = 1
            }
            
        } else if sender.state == .ended || sender.state == .failed || sender.state == .cancelled {
            
            guard let center = self.originalImageCenter else { return }
            
            UIView.animate(withDuration: 0.35, animations: {
                self.image.transform = CGAffineTransform.identity
                self.image.center = center
            }, completion: { _ in
                self.delegate!.collectionView!.isPagingEnabled = true
                self.delegate!.collectionView!.isScrollEnabled = true
                self.isZooming = false
            })
        }
    }
    
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    
    func setUpAndRunActivityIndicator() {
        self.activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
        self.contentView.addSubview(self.activityIndicator!)
        
        self.activityIndicator!.translatesAutoresizingMaskIntoConstraints = false
        self.activityIndicator!.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        self.activityIndicator!.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        self.activityIndicator!.widthAnchor.constraint(equalToConstant: 40).isActive = true
        self.activityIndicator!.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        self.activityIndicator!.startAnimating()
    }
    
    
    private func setUpConstraints() {
        self.image.translatesAutoresizingMaskIntoConstraints = false
        self.image.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        self.image.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        self.image.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        self.image.heightAnchor.constraint(equalTo: self.contentView.heightAnchor).isActive = true

    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
