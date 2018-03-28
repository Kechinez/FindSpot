//
//  RegisterView.swift
//  thesisProject
//
//  Created by Nikita Kechinov on 26.03.2018.
//  Copyright © 2018 Nikita Kechinov. All rights reserved.
//

import UIKit

class RegisterView: UIView {
    private var viewController: LoginViewController
    private var nameField: UITextField?
    private var emailField: UITextField?
    private var passField: UITextField?
    
    init(frame: CGRect, loginViewController: LoginViewController) {
        self.viewController = loginViewController
        super.init(frame: frame)
        
        self.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        self.layer.cornerRadius = 10
        
        let nameField = UITextField(frame: CGRect(x: 15, y: 15, width: self.bounds.width - 30, height: 35))
        nameField.placeholder = "write your nickname"
        nameField.font = UIFont.systemFont(ofSize: 18)
        nameField.borderStyle = .roundedRect
        nameField.autocorrectionType = .no
        nameField.keyboardType = .alphabet
        nameField.tag = TextFields.nameTextField.rawValue
        self.addSubview(nameField)
        self.nameField = nameField
        
        let emailField = UITextField(frame: CGRect(x: 15, y: 65, width: self.bounds.width - 30, height: 35))
        emailField.placeholder = "write your email address"
        emailField.font = UIFont.systemFont(ofSize: 18)
        emailField.borderStyle = .roundedRect
        emailField.autocorrectionType = .no
        emailField.keyboardType = .emailAddress
        emailField.tag = TextFields.emailTextField.rawValue
        self.addSubview(emailField)
        self.emailField = emailField
        
        let passField = UITextField(frame: CGRect(x: 15, y: 110, width: self.bounds.width - 30, height: 35))
        passField.placeholder = "write your password"
        passField.font = UIFont.systemFont(ofSize: 18)
        passField.borderStyle = .roundedRect
        passField.autocorrectionType = .no
        passField.keyboardType = .emailAddress
        passField.tag = TextFields.passwordTextField.rawValue
        self.addSubview(passField)
        self.passField = passField
        
        let registerButton = UIButton(frame: CGRect(x: ((self.bounds.width) / 5) - 7, y: 175, width: self.bounds.width * 2 / 3, height: 30))
        registerButton.setTitle("Register", for: .normal)
        registerButton.setTitleColor(.black, for: .normal)
        registerButton.layer.cornerRadius = 8.0
        registerButton.backgroundColor = .yellow
        registerButton.addTarget(viewController, action: #selector(LoginViewController.registerNewUser), for: .touchUpInside)
        self.addSubview(registerButton)
        
        let haveAccountButton = UIButton(frame: CGRect(x: 15, y: 220, width: self.bounds.width - 30, height: 20))
        haveAccountButton.setTitle("I already have account", for: .normal)
        haveAccountButton.setTitleColor(.black, for: .normal)
        haveAccountButton.backgroundColor = UIColor.clear
        haveAccountButton.addTarget(viewController, action: #selector(LoginViewController.removeRegisterView), for: .touchUpInside)
        self.addSubview(haveAccountButton)
        
        
        
    }
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTextFieldsDelegate(with delegate: LoginViewController) {
        self.emailField?.delegate = delegate
        self.nameField?.delegate = delegate
        self.passField?.delegate = delegate
    }
    
    func setTextFeildsForRegisterUsage(within viewController: LoginViewController) {
        viewController.nameTextField = self.nameField
        viewController.emailTextField = self.emailField
        viewController.passTextField = self.passField
    }
    
}
