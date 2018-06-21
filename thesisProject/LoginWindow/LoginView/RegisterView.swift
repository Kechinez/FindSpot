//
//  RegisterView.swift
//  thesisProject
//
//  Created by Nikita Kechinov on 26.03.2018.
//  Copyright © 2018 Nikita Kechinov. All rights reserved.
//

import UIKit

class RegisterView: UIView {
    
    public let nameField: UITextField = {
        let nameField = UITextField()
        nameField.borderStyle = .roundedRect
        nameField.tag = TextFields.NameTextField.rawValue
        nameField.setTextAndFont(.NameTextField)
        nameField.setKeyboardSettings(.NameTextField)
        return nameField
    }()
    public let emailField: UITextField = {
        let emailField = UITextField()
        emailField.borderStyle = .roundedRect
        emailField.setKeyboardSettings(.EmailTextField)
        emailField.setTextAndFont(.EmailTextField)
        emailField.tag = TextFields.EmailTextField.rawValue
        return emailField
    }()
    public let passField: UITextField = {
        let passField = UITextField()
        passField.borderStyle = .roundedRect
        passField.setKeyboardSettings(.PasswordTextField)
        passField.setTextAndFont(.PasswordTextField)
        passField.tag = TextFields.PasswordTextField.rawValue
        return passField
    }()
    public let registerButton: UIButton = {
        let registerButton = UIButton()
        registerButton.setButtonAppearance(.RegisterNewUser)
        return registerButton
    }()
    public let alreadyHaveAccountButton: UIButton = {
        let alreadyHaveAccountButton = UIButton()
        alreadyHaveAccountButton.setButtonAppearance(.AlreadyHaveAnAccountButton)
        return alreadyHaveAccountButton
    }()
    
    
    private let superView: UIView
    
    
    init(with superView: UIView) {
        self.superView = superView
        super.init(frame: CGRect.zero)
        superView.addSubview(self)
        superView.bringSubview(toFront: self)
        self.backgroundColor = #colorLiteral(red: 0.2549019608, green: 0.4588235294, blue: 0.01960784314, alpha: 1)
        self.layer.cornerRadius = 10
        self.alpha = 0.0
        self.tag = 10
        
        self.addSubview(self.nameField)
        self.addSubview(self.emailField)
        self.addSubview(self.passField)
        self.addSubview(self.alreadyHaveAccountButton)
        self.addSubview(self.registerButton)
        
        for subview in self.subviews {
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
        
        self.setUpConstraints()
    }
    
    
    private func setUpConstraints() {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraintEqualToSystemSpacingBelow(self.superView.topAnchor, multiplier: 20).isActive = true
        self.centerXAnchor.constraint(equalTo: self.superView.centerXAnchor).isActive = true
        self.widthAnchor.constraint(equalTo: self.superView.widthAnchor, multiplier: 0.8).isActive = true
        self.heightAnchor.constraint(equalTo: self.superView.heightAnchor, multiplier: 0.6).isActive = true
        self.bottomAnchor.constraint(equalTo: self.superView.bottomAnchor).isActive = true
        
        self.nameField.translatesAutoresizingMaskIntoConstraints = false
        self.nameField.topAnchor.constraint(equalTo: self.topAnchor, constant: 25).isActive = true
        self.nameField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.nameField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9375).isActive = true
        self.nameField.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        self.emailField.translatesAutoresizingMaskIntoConstraints = false
        self.emailField.topAnchor.constraint(equalTo: self.nameField.bottomAnchor, constant: 20).isActive = true
        self.emailField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.emailField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9375).isActive = true
        self.emailField.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        self.passField.translatesAutoresizingMaskIntoConstraints = false
        self.passField.topAnchor.constraint(equalTo: self.emailField.bottomAnchor, constant: 20).isActive = true
        self.passField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.passField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9375).isActive = true
        self.passField.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        self.registerButton.translatesAutoresizingMaskIntoConstraints = false
        self.registerButton.topAnchor.constraint(equalTo: self.passField.bottomAnchor, constant: 35).isActive = true
        self.registerButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.registerButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.75).isActive = true
        self.registerButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        self.alreadyHaveAccountButton.translatesAutoresizingMaskIntoConstraints = false
        self.alreadyHaveAccountButton.topAnchor.constraint(equalTo: self.registerButton.bottomAnchor, constant: 10).isActive = true
        self.alreadyHaveAccountButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.alreadyHaveAccountButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.85).isActive = true
        self.alreadyHaveAccountButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    // MARK: - set delegate for textfields
    
    func setDelegateOfRegisterViewTextFields(using viewController: LoginViewController) {
        self.emailField.delegate = viewController
        self.nameField.delegate = viewController
        self.passField.delegate = viewController
    }
    
    
    
    
    // MARK: - set action methods for buttons
    
    func setActionsForButton(using viewController: LoginViewController) {
        self.alreadyHaveAccountButton.addTarget(viewController, action: #selector(LoginViewController.removeRegisterView), for: .touchUpInside)
        self.registerButton.addTarget(viewController, action: #selector(LoginViewController.registerNewUser), for: .touchUpInside)
    }
    
}
