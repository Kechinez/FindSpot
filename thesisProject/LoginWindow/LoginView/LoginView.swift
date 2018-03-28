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
    
        self.backgroundColor = UIColor.blue
        let emailTextField = UITextField(frame: CGRect(x: (self.bounds.width / 6), y: self.bounds.height / 2, width: self.bounds.width * 2/3, height: 35))
        emailTextField.placeholder = "write your email"
        emailTextField.font = UIFont.systemFont(ofSize: 18)
        emailTextField.borderStyle = .roundedRect
        emailTextField.autocorrectionType = .no
        emailTextField.keyboardType = .emailAddress
        //emailTextField.tag = TextFields.emailTextField.rawValue
        self.addSubview(emailTextField)
        self.emailTextField = emailTextField
        
        let passwordTextField = UITextField(frame: CGRect(x: (self.bounds.width / 6), y: (self.bounds.height / 2 + 50), width: self.bounds.width * 2/3, height: 35))
        passwordTextField.placeholder = "write your password"
        passwordTextField.font = UIFont.systemFont(ofSize: 18)
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.autocorrectionType = .no
        passwordTextField.keyboardType = .emailAddress
        //passwordTextField.tag = TextFields.passwordTextField.rawValue
        self.addSubview(passwordTextField)
        self.passwordTextField = passwordTextField
        
        let loginButton = UIButton(frame: CGRect(x: (self.bounds.width / 4), y: (self.bounds.height / 2 + 115), width: self.bounds.width / 2, height: 30))
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(UIColor.black, for: .normal)
        loginButton.layer.cornerRadius = 8.0
        loginButton.backgroundColor = UIColor.yellow
        loginButton.addTarget(viewController, action: #selector(LoginViewController.loginActionMethod), for: .touchUpInside)
        self.addSubview(loginButton)
        
        let registerButton = UIButton(frame: CGRect(x: (self.bounds.width / 4), y: (self.bounds.height / 2 + 160), width: self.bounds.width / 2, height: 30))
        registerButton.setTitle("Register", for: .normal)
        registerButton.setTitleColor(UIColor.black, for: .normal)
        registerButton.layer.cornerRadius = 8.0
        registerButton.backgroundColor = UIColor.yellow
        registerButton.addTarget(viewController, action: #selector(LoginViewController.registerActionMethod), for: .touchUpInside)
        self.addSubview(registerButton)
        
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
