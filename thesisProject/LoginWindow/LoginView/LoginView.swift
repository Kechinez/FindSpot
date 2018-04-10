//
//  LoginView.swift
//  thesisProject
//
//  Created by Nikita Kechinov on 23.03.2018.
//  Copyright © 2018 Nikita Kechinov. All rights reserved.
//

import UIKit

class LoginView: UIView {
    private var viewController: LoginViewController
    private var emailTextField: UITextField?
    private var passwordTextField: UITextField?
    
    init(usedViewController: LoginViewController) {
        let rect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        self.viewController = usedViewController
        super.init(frame: rect)
    }
    
    
    convenience init(withAssociated viewController: LoginViewController) {
        self.init(usedViewController: viewController)
    
        let leavesImage = UIImage(named: "Leaves.png")
        let backgroundView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height * 0.5))
        //backgroundView.setIma
        backgroundView.image = leavesImage
        backgroundView.alpha = 0.45
        self.addSubview(backgroundView)
        self.bringSubview(toFront: backgroundView)
        self.backgroundColor = #colorLiteral(red: 0.3647058824, green: 0.6549019608, blue: 0.04705882353, alpha: 1)
        
        let emailTextField = UITextField(frame: CGRect(x: (self.bounds.width / 7), y: self.bounds.height / 3, width: self.bounds.width * 5/7, height: 45))
        emailTextField.placeholder = "write your email"
        emailTextField.font = UIFont.systemFont(ofSize: 18)
        emailTextField.borderStyle = .roundedRect
        emailTextField.autocorrectionType = .no
        emailTextField.keyboardType = .emailAddress
        emailTextField.tag = TextFields.emailTextField.rawValue
        self.addSubview(emailTextField)
        self.emailTextField = emailTextField
        
        let passwordTextField = UITextField(frame: CGRect(x: (self.bounds.width / 7), y: (self.bounds.height / 3 + 75), width: self.bounds.width * 5/7, height: 45))
        passwordTextField.placeholder = "write your password"
        passwordTextField.font = UIFont.systemFont(ofSize: 18)
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.autocorrectionType = .no
        passwordTextField.keyboardType = .emailAddress
        passwordTextField.tag = TextFields.passwordTextField.rawValue
        self.addSubview(passwordTextField)
        self.passwordTextField = passwordTextField
        
        let loginButton = UIButton(frame: CGRect(x: (self.bounds.width / 5), y: (self.bounds.height / 3 + 155), width: self.bounds.width * 0.6, height: 55))
        loginButton.setTitle("Login", for: .normal)
        loginButton.titleLabel?.font = UIFont(name: "Helvetica", size: 22)
        loginButton.setTitleColor(UIColor.white, for: .normal)
        loginButton.layer.cornerRadius = 8.0
        loginButton.backgroundColor = #colorLiteral(red: 0.4431372549, green: 0.5647058824, blue: 0.8784313725, alpha: 1)
        loginButton.addTarget(viewController, action: #selector(LoginViewController.loginActionMethod), for: .touchUpInside)
        self.addSubview(loginButton)
        
        let registerButton = UIButton(frame: CGRect(x: (self.bounds.width * 3/8), y: self.bounds.height / 3 + 235, width: self.bounds.width / 4, height: 30))
        registerButton.setTitle("Register", for: .normal)
        registerButton.setTitleColor(UIColor.white, for: .normal)
        registerButton.titleLabel?.font = UIFont(name: "Helvetica", size: 22)
        registerButton.addTarget(viewController, action: #selector(LoginViewController.registerActionMethod), for: .touchUpInside)
        self.addSubview(registerButton)
        
        let findSpotLabel = UILabel(frame: CGRect(x: self.bounds.width / 4, y: self.bounds.height / 9, width: self.bounds.width / 2, height: self.bounds.height / 7))
        findSpotLabel.text = "FindSpot"
        if let font = UIFont(name: "Helvetica", size: 44) {
            findSpotLabel.font = font
        }
        findSpotLabel.textColor = UIColor.white
        self.addSubview(findSpotLabel)
        
        
        self.setTextFieldDelegate(with: self.viewController)
        self.setTextFieldsForLoginUsage(within: self.viewController)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setTextFieldsForLoginUsage(within viewController: LoginViewController) {
        viewController.emailTextField = self.emailTextField
        viewController.passTextField = self.passwordTextField
    }
    
    func setTextFieldDelegate(with delegate: LoginViewController) {
        self.emailTextField?.delegate = delegate
        self.passwordTextField?.delegate = delegate
    }
    
}
