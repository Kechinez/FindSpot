//
//  ErrorManager.swift
//  thesisProject
//
//  Created by Nikita Kechinov on 18.04.2018.
//  Copyright © 2018 Nikita Kechinov. All rights reserved.
//

import Foundation
import UIKit

class ErrorManager {
    
    private init() { }
    static let shared = ErrorManager()
    
    func showErrorMessage(with error: Error, shownAt viewController: UIViewController) {
        let alertViewController = UIAlertController(title: "Problem occured!", message: error.localizedDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "continue", style: .default, handler: nil)
        alertViewController.addAction(okAction)
        viewController.present(alertViewController, animated: true, completion: nil)
    }
    
}
