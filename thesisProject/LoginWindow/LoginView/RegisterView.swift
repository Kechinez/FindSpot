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
    private var registerButton: UIButton?
    private var alreadyRegistredButton: UIButton?
    private let superView: UIView
    
    
    init(with superView: UIView, loginViewController: LoginViewController) {
        self.viewController = loginViewController
        self.superView = superView
        super.init(frame: CGRect.zero)
        
        superView.addSubview(self)
        superView.bringSubview(toFront: self)
        self.backgroundColor = #colorLiteral(red: 0.2549019608, green: 0.4588235294, blue: 0.01960784314, alpha: 1)
        self.layer.cornerRadius = 10
        self.alpha = 0.0
        self.tag = 10
    
        let placeholderFont = UIFont(name: "OpenSans", size: 14.0)
        let textFieldFont = UIFont(name: "OpenSans", size: 18.0)
        let buttonFont = UIFont(name: "OpenSans", size: 22.0)
        let attributesDictionary: [NSAttributedStringKey: Any] = [
            NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue):  #colorLiteral(red: 0.6257788431, green: 0.6374320992, blue: 0.6723918676, alpha: 1),
            NSAttributedStringKey(rawValue: NSAttributedStringKey.font.rawValue): placeholderFont!]
        
        let atributedPlaceholder = NSMutableAttributedString(string: "write your nickname")
        atributedPlaceholder.addAttributes(attributesDictionary, range: NSRange (location:0, length: atributedPlaceholder.length))
        
        let nameField = UITextField()
        nameField.attributedPlaceholder = atributedPlaceholder
        nameField.font = textFieldFont!
        nameField.borderStyle = .roundedRect
        nameField.autocorrectionType = .no
        nameField.keyboardType = .alphabet
        nameField.tag = TextFields.nameTextField.rawValue
        self.addSubview(nameField)
        self.nameField = nameField
        
        let emailField = UITextField()
        atributedPlaceholder.mutableString.setString("write your email address")
        emailField.attributedPlaceholder = atributedPlaceholder
        emailField.font = textFieldFont!
        emailField.borderStyle = .roundedRect
        emailField.autocorrectionType = .no
        emailField.keyboardType = .emailAddress
        emailField.tag = TextFields.emailTextField.rawValue
        self.addSubview(emailField)
        self.emailField = emailField
        
        let passField = UITextField()
        atributedPlaceholder.mutableString.setString("write your password")
        passField.attributedPlaceholder = atributedPlaceholder
        passField.font = textFieldFont!
        passField.borderStyle = .roundedRect
        passField.autocorrectionType = .no
        passField.keyboardType = .emailAddress
        passField.tag = TextFields.passwordTextField.rawValue
        self.addSubview(passField)
        self.passField = passField
        
        let registerButton = UIButton()
        registerButton.setTitle("Register", for: .normal)
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.titleLabel?.font = buttonFont!
        registerButton.layer.cornerRadius = 8.0
        registerButton.backgroundColor = #colorLiteral(red: 0.2549019608, green: 0.5137254902, blue: 0.7568627451, alpha: 1)
        registerButton.addTarget(viewController, action: #selector(LoginViewController.registerNewUser), for: .touchUpInside)
        self.addSubview(registerButton)
        self.registerButton = registerButton
        
        let haveAccountButton = UIButton()
        haveAccountButton.setTitle("I already have account", for: .normal)
        haveAccountButton.setTitleColor(.white, for: .normal)
        haveAccountButton.titleLabel?.font = buttonFont!.withSize(19.0)
        haveAccountButton.addTarget(viewController, action: #selector(LoginViewController.removeRegisterView), for: .touchUpInside)
        self.addSubview(haveAccountButton)
        self.alreadyRegistredButton = haveAccountButton
        
        self.setTextFieldsDelegates()
        self.setUpConstraints()

    }
    
    
    
     private func setUpConstraints() {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraintEqualToSystemSpacingBelow(self.superView.topAnchor, multiplier: 20).isActive = true
        self.centerXAnchor.constraint(equalTo: self.superView.centerXAnchor).isActive = true
        self.widthAnchor.constraint(equalTo: self.superView.widthAnchor, multiplier: 0.8).isActive = true
        self.heightAnchor.constraint(equalTo: self.superView.heightAnchor, multiplier: 0.6).isActive = true
        self.bottomAnchor.constraint(equalTo: self.superView.bottomAnchor).isActive = true
        
        self.nameField!.translatesAutoresizingMaskIntoConstraints = false
        self.nameField!.topAnchor.constraint(equalTo: self.topAnchor, constant: 25).isActive = true
        self.nameField!.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.nameField!.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9375).isActive = true
        self.nameField!.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        self.emailField!.translatesAutoresizingMaskIntoConstraints = false
        self.emailField!.topAnchor.constraint(equalTo: self.nameField!.bottomAnchor, constant: 20).isActive = true
        self.emailField!.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.emailField!.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9375).isActive = true
        self.emailField!.heightAnchor.constraint(equalToConstant: 45).isActive = true
    
        self.passField!.translatesAutoresizingMaskIntoConstraints = false
        self.passField!.topAnchor.constraint(equalTo: self.emailField!.bottomAnchor, constant: 20).isActive = true
        self.passField!.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.passField!.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9375).isActive = true
        self.passField!.heightAnchor.constraint(equalToConstant: 45).isActive = true
    
        self.registerButton!.translatesAutoresizingMaskIntoConstraints = false
        self.registerButton!.topAnchor.constraint(equalTo: self.passField!.bottomAnchor, constant: 35).isActive = true
        self.registerButton!.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.registerButton!.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.75).isActive = true
        self.registerButton!.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        self.alreadyRegistredButton!.translatesAutoresizingMaskIntoConstraints = false
        self.alreadyRegistredButton!.topAnchor.constraint(equalTo: self.registerButton!.bottomAnchor, constant: 10).isActive = true
        self.alreadyRegistredButton!.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.alreadyRegistredButton!.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.85).isActive = true
        self.alreadyRegistredButton!.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func setTextFieldsDelegates() {
        self.emailField!.delegate = self.viewController
        self.nameField!.delegate = self.viewController
        self.passField!.delegate = self.viewController
    }
    
    
    
    
}
