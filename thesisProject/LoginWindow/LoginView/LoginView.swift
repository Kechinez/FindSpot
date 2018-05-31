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
        self.backgroundColor = #colorLiteral(red: 0.4078431373, green: 0.6941176471, blue: 0.09411764706, alpha: 1)
    
        let placeholderFont = UIFont(name: "OpenSans", size: 14.0)
        let textFieldFont = UIFont(name: "OpenSans", size: 18.0)
        let buttonFont = UIFont(name: "OpenSans", size: 22.0)
        let attributesDictionary: [NSAttributedStringKey: Any] = [
            NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue): #colorLiteral(red: 0.6257788431, green: 0.6374320992, blue: 0.6723918676, alpha: 1),
            NSAttributedStringKey(rawValue: NSAttributedStringKey.font.rawValue): placeholderFont!]
        
        let atributedPlaceholder = NSMutableAttributedString(string: "write your email")
        atributedPlaceholder.addAttributes(attributesDictionary, range: NSRange (location:0, length: atributedPlaceholder.length))
        
        let emailTextField = UITextField(frame: CGRect(x: (self.bounds.width / 7), y: self.bounds.height / 3, width: self.bounds.width * 5/7, height: 45))
        emailTextField.attributedPlaceholder = atributedPlaceholder
    
        emailTextField.font = textFieldFont!
        emailTextField.borderStyle = .roundedRect
        emailTextField.autocorrectionType = .no
        emailTextField.keyboardType = .emailAddress
        emailTextField.tag = TextFields.emailTextField.rawValue
        self.addSubview(emailTextField)
        self.emailTextField = emailTextField
        
        let passwordTextField = UITextField(frame: CGRect(x: (self.bounds.width / 7), y: (self.bounds.height / 3 + 75), width: self.bounds.width * 5/7, height: 45))
        atributedPlaceholder.mutableString.setString("write your password")
        passwordTextField.attributedPlaceholder = atributedPlaceholder
        
        passwordTextField.font = textFieldFont!
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.autocorrectionType = .no
        passwordTextField.keyboardType = .emailAddress
        passwordTextField.tag = TextFields.passwordTextField.rawValue
        self.addSubview(passwordTextField)
        self.passwordTextField = passwordTextField
        
        let loginButton = UIButton(frame: CGRect(x: (self.bounds.width / 5), y: (self.bounds.height / 3 + 155), width: self.bounds.width * 0.6, height: 55))
        loginButton.setTitle("Login", for: .normal)
        loginButton.titleLabel?.font = buttonFont!
        loginButton.setTitleColor(UIColor.white, for: .normal)
        loginButton.layer.cornerRadius = 8.0
        loginButton.backgroundColor = #colorLiteral(red: 0.2549019608, green: 0.5137254902, blue: 0.7568627451, alpha: 1)
        loginButton.addTarget(viewController, action: #selector(LoginViewController.loginActionMethod), for: .touchUpInside)
        self.addSubview(loginButton)
        
        let registerButton = UIButton(frame: CGRect(x: (self.bounds.width * 3/8), y: self.bounds.height / 3 + 235, width: self.bounds.width / 4, height: 30))
        registerButton.setTitle("Register", for: .normal)
        registerButton.setTitleColor(UIColor.white, for: .normal)
        registerButton.titleLabel?.font = buttonFont!
        registerButton.addTarget(viewController, action: #selector(LoginViewController.registerActionMethod), for: .touchUpInside)
        self.addSubview(registerButton)
        
        let findSpotLabel = UILabel(frame: CGRect(x: self.bounds.width / 4, y: self.bounds.height / 9, width: self.bounds.width / 2, height: self.bounds.height / 7))
        findSpotLabel.text = "FindSpot"
        if let font = UIFont(name: "Comfortaa", size: 38) {
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
