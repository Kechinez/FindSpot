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
    var nameField: UITextField?
    var emailField: UITextField?
    var passField: UITextField?
    
    
    
    init(frame: CGRect, loginViewController: LoginViewController) {
        self.viewController = loginViewController
        super.init(frame: frame)
        
        self.backgroundColor = #colorLiteral(red: 0.2549019608, green: 0.4588235294, blue: 0.01960784314, alpha: 1)
        self.layer.cornerRadius = 10
        self.alpha = 0.0
        self.tag = 10
    }
    
    
    
    func setUI() {
        
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
        
        nameField.translatesAutoresizingMaskIntoConstraints = false
        nameField.topAnchor.constraint(equalTo: self.topAnchor, constant: 25).isActive = true
        nameField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        nameField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9375).isActive = true
        nameField.heightAnchor.constraint(equalToConstant: 45).isActive = true
        

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
        
        emailField.translatesAutoresizingMaskIntoConstraints = false
        emailField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 20).isActive = true
        emailField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        emailField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9375).isActive = true
        emailField.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        
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
        
        passField.translatesAutoresizingMaskIntoConstraints = false
        passField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 20).isActive = true
        passField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        passField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9375).isActive = true
        passField.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        
        let registerButton = UIButton()
        registerButton.setTitle("Register", for: .normal)
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.titleLabel?.font = buttonFont!
        registerButton.layer.cornerRadius = 8.0
        registerButton.backgroundColor = #colorLiteral(red: 0.2549019608, green: 0.5137254902, blue: 0.7568627451, alpha: 1)
        registerButton.addTarget(viewController, action: #selector(LoginViewController.registerNewUser), for: .touchUpInside)
        self.addSubview(registerButton)
        
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.topAnchor.constraint(equalTo: passField.bottomAnchor, constant: 35).isActive = true
        registerButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        registerButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.75).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        
        let haveAccountButton = UIButton()
        haveAccountButton.setTitle("I already have account", for: .normal)
        haveAccountButton.setTitleColor(.white, for: .normal)
        haveAccountButton.titleLabel?.font = buttonFont!.withSize(19.0)
        haveAccountButton.addTarget(viewController, action: #selector(LoginViewController.removeRegisterView), for: .touchUpInside)
        self.addSubview(haveAccountButton)
        
        haveAccountButton.translatesAutoresizingMaskIntoConstraints = false
        haveAccountButton.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 10).isActive = true
        haveAccountButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        haveAccountButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.85).isActive = true
        haveAccountButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
   
        self.setTextFieldsDelegates()
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func setTextFieldsDelegates() {
        self.emailField?.delegate = self.viewController
        self.nameField?.delegate = self.viewController
        self.passField?.delegate = self.viewController
    }
    
    
    
    
}
