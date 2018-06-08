//
//  LoginView.swift
//  thesisProject
//
//  Created by Nikita Kechinov on 23.03.2018.
//  Copyright © 2018 Nikita Kechinov. All rights reserved.
//

import UIKit

enum AnimationType {
    case AppearingOfView
    case DisappearingOfView
}

class LoginView: UIScrollView {
    private var viewController: LoginViewController
    private var emailTextField: UITextField?
    private var passwordTextField: UITextField?
    private var registerView: RegisterView?
    private var findSpotLabel: UILabel?
    private var loginButton: UIButton?
    private var registerButton: UIButton?
    private var backgroundView: UIView?
    
    
    
    init(usedViewController: LoginViewController) {
        let rect = CGRect.zero
        self.viewController = usedViewController
        super.init(frame: rect)
        viewController.view.addSubview(self)
    }
    
    
    
    convenience init(withAssociated viewController: LoginViewController) {
        self.init(usedViewController: viewController)
        
        let backgroundView = UIImageView(image: UIImage(named: "Leaves.png"))
        backgroundView.alpha = 0.45
        self.addSubview(backgroundView)
        self.bringSubview(toFront: backgroundView)
        self.backgroundColor = #colorLiteral(red: 0.4078431373, green: 0.6941176471, blue: 0.09411764706, alpha: 1)
        self.backgroundView = backgroundView
        
        let placeholderFont = UIFont(name: "OpenSans", size: 14.0)
        let textFieldFont = UIFont(name: "OpenSans", size: 18.0)
        let buttonFont = UIFont(name: "OpenSans", size: 22.0)
        let attributesDictionary: [NSAttributedStringKey: Any] = [
            NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue): #colorLiteral(red: 0.6257788431, green: 0.6374320992, blue: 0.6723918676, alpha: 1),
            NSAttributedStringKey(rawValue: NSAttributedStringKey.font.rawValue): placeholderFont!]
        
        let findSpotLabel = UILabel()
        findSpotLabel.text = "FindSpot"
        if let font = UIFont(name: "Comfortaa", size: 38) {
            findSpotLabel.font = font
        }
        findSpotLabel.textColor = UIColor.white
        self.addSubview(findSpotLabel)
        self.findSpotLabel = findSpotLabel
        
        let atributedPlaceholder = NSMutableAttributedString(string: "write your password")
        atributedPlaceholder.addAttributes(attributesDictionary, range: NSRange (location:0, length: atributedPlaceholder.length))

        let passwordTextField = UITextField()
        passwordTextField.attributedPlaceholder = atributedPlaceholder
        passwordTextField.font = textFieldFont!
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.autocorrectionType = .no
        passwordTextField.keyboardType = .emailAddress
        passwordTextField.tag = TextFields.passwordTextField.rawValue
        self.addSubview(passwordTextField)
        self.passwordTextField = passwordTextField
        
        let emailTextField = UITextField()
        self.addSubview(emailTextField)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.topAnchor.constraintEqualToSystemSpacingBelow(findSpotLabel.bottomAnchor, multiplier: 8).isActive = true
        emailTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.75).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 45).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20).isActive = true
        
        atributedPlaceholder.mutableString.setString("write your email")
        emailTextField.attributedPlaceholder = atributedPlaceholder
        emailTextField.font = textFieldFont!
        emailTextField.borderStyle = .roundedRect
        emailTextField.autocorrectionType = .no
        emailTextField.keyboardType = .emailAddress
        emailTextField.tag = TextFields.emailTextField.rawValue
        self.addSubview(emailTextField)
        self.emailTextField = emailTextField
        
        let loginButton = UIButton()
        loginButton.setTitle("Login", for: .normal)
        loginButton.titleLabel?.font = buttonFont!
        loginButton.setTitleColor(UIColor.white, for: .normal)
        loginButton.layer.cornerRadius = 8.0
        loginButton.backgroundColor = #colorLiteral(red: 0.2549019608, green: 0.5137254902, blue: 0.7568627451, alpha: 1)
        loginButton.addTarget(viewController, action: #selector(LoginViewController.loginActionMethod), for: .touchUpInside)
        self.addSubview(loginButton)
        self.loginButton = loginButton
        
        let registerButton = UIButton()
        registerButton.setTitle("Register", for: .normal)
        registerButton.setTitleColor(UIColor.white, for: .normal)
        registerButton.titleLabel?.font = buttonFont!.withSize(19.0)
        registerButton.addTarget(viewController, action: #selector(LoginViewController.registerActionMethod), for: .touchUpInside)
        self.addSubview(registerButton)
        self.registerButton = registerButton
        
        self.setTextFieldDelegate()
        self.setTextFieldsForLoginUsage()
        self.setUpConstraints()
    }

    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func setUpConstraints() {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: viewController.view.topAnchor).isActive = true
        self.widthAnchor.constraint(equalTo: viewController.view.widthAnchor).isActive = true
        self.heightAnchor.constraint(equalTo: viewController.view.heightAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor).isActive = true
        
        self.backgroundView!.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundView!.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.backgroundView!.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5).isActive = true
        self.backgroundView!.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        
        self.findSpotLabel!.translatesAutoresizingMaskIntoConstraints = false
        self.findSpotLabel!.topAnchor.constraintEqualToSystemSpacingBelow(self.topAnchor, multiplier: 10).isActive = true
        self.findSpotLabel!.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        self.passwordTextField!.translatesAutoresizingMaskIntoConstraints = false
        self.passwordTextField!.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.passwordTextField!.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.75).isActive = true
        self.passwordTextField!.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        self.loginButton!.translatesAutoresizingMaskIntoConstraints = false
        self.loginButton!.topAnchor.constraint(equalTo: self.passwordTextField!.bottomAnchor, constant: 35).isActive = true
        self.loginButton!.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.loginButton!.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.6).isActive = true
        self.loginButton!.heightAnchor.constraint(equalToConstant: 55).isActive = true
        self.loginButton!.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        self.registerButton!.translatesAutoresizingMaskIntoConstraints = false
        self.registerButton!.topAnchor.constraint(equalTo: self.loginButton!.bottomAnchor, constant: 10).isActive = true
        self.registerButton!.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.registerButton!.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    
    
    func createRegisterView() {
        let registerView = RegisterView(with: self, loginViewController: self.viewController)
        self.registerView = registerView
    }
    
    
    
    func setTextFieldsForLoginUsage() {
        self.viewController.emailTextField = self.emailTextField
        self.viewController.passTextField = self.passwordTextField
    }
    
    
    
    func setTextFieldDelegate() {
        self.emailTextField?.delegate = self.viewController
        self.passwordTextField?.delegate = self.viewController
    }
    
    
    
    func setAnimationOf(type: AnimationType) {
        
        switch type {
        case .AppearingOfView:
            UIView.animate(withDuration: 1.0, animations: {
                self.registerView!.alpha = 1.0
            }, completion: nil)
        case .DisappearingOfView:
            UIView.animate(withDuration: 1.0, animations: {
                self.registerView!.alpha = 0.0
                self.layoutSubviews()
            }, completion: { (true) in
                self.registerView!.removeFromSuperview()
                self.setTextFieldDelegate()
                self.setTextFieldsForLoginUsage()
            })
        }
    }
    
    
    
    func increaseContentSizeOn(value: CGFloat) {
        self.contentSize = CGSize(width: self.bounds.width, height: self.bounds.height + value)
        self.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: value, right: 0)
    }
    
    
    
    func decreaseContentSizeToDefaultValues() {
        UIView.transition(with: self, duration: 0.4 , options: .curveEaseOut, animations: {
            self.contentSize = CGSize(width: self.bounds.width, height: self.bounds.height)
        }, completion: nil)
    }
   
    
}

