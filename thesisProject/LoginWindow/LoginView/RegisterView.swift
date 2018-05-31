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
        
        self.backgroundColor = #colorLiteral(red: 0.2549019608, green: 0.4588235294, blue: 0.01960784314, alpha: 1)
        self.layer.cornerRadius = 10
        
        let placeholderFont = UIFont(name: "OpenSans", size: 14.0)
        let textFieldFont = UIFont(name: "OpenSans", size: 18.0)
        let buttonFont = UIFont(name: "OpenSans", size: 22.0)
        let attributesDictionary: [NSAttributedStringKey: Any] = [
            NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue): #colorLiteral(red: 0.6257788431, green: 0.6374320992, blue: 0.6723918676, alpha: 1),
            NSAttributedStringKey(rawValue: NSAttributedStringKey.font.rawValue): placeholderFont!]
        
        let atributedPlaceholder = NSMutableAttributedString(string: "write your nickname")
        atributedPlaceholder.addAttributes(attributesDictionary, range: NSRange (location:0, length: atributedPlaceholder.length))
        
        let nameField = UITextField(frame: CGRect(x: 15, y: 15, width: self.bounds.width - 30, height: 45))
        nameField.attributedPlaceholder = atributedPlaceholder
        nameField.font = textFieldFont!
        nameField.borderStyle = .roundedRect
        nameField.autocorrectionType = .no
        nameField.keyboardType = .alphabet
        nameField.tag = TextFields.nameTextField.rawValue
        self.addSubview(nameField)
        self.nameField = nameField
        
        let emailField = UITextField(frame: CGRect(x: 15, y: 90, width: self.bounds.width - 30, height: 45))
        atributedPlaceholder.mutableString.setString("write your email address")
        emailField.attributedPlaceholder = atributedPlaceholder
        emailField.font = textFieldFont!
        emailField.borderStyle = .roundedRect
        emailField.autocorrectionType = .no
        emailField.keyboardType = .emailAddress
        emailField.tag = TextFields.emailTextField.rawValue
        self.addSubview(emailField)
        self.emailField = emailField
        
        let passField = UITextField(frame: CGRect(x: 15, y: 165, width: self.bounds.width - 30, height: 45))
        atributedPlaceholder.mutableString.setString("write your password")
        passField.attributedPlaceholder = atributedPlaceholder
        passField.font = textFieldFont!
        passField.borderStyle = .roundedRect
        passField.autocorrectionType = .no
        passField.keyboardType = .emailAddress
        passField.tag = TextFields.passwordTextField.rawValue
        self.addSubview(passField)
        self.passField = passField
        
        let registerButton = UIButton(frame: CGRect(x: 42, y: 245, width: (self.bounds.width - 30) * 0.8, height: 55))
        registerButton.setTitle("Register", for: .normal)
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.titleLabel?.font = buttonFont!
        registerButton.layer.cornerRadius = 8.0
        registerButton.backgroundColor = #colorLiteral(red: 0.2549019608, green: 0.5137254902, blue: 0.7568627451, alpha: 1)
        registerButton.addTarget(viewController, action: #selector(LoginViewController.registerNewUser), for: .touchUpInside)
        self.addSubview(registerButton)
        
        let haveAccountButton = UIButton(frame: CGRect(x: 15, y: 310, width: self.bounds.width - 30, height: 30))
        haveAccountButton.setTitle("I already have account", for: .normal)
        haveAccountButton.setTitleColor(.white, for: .normal)
        haveAccountButton.titleLabel?.font = buttonFont!
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
