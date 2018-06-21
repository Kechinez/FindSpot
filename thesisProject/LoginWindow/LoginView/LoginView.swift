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

public enum ButtonType {
    case LoginButton
    case RegisterButton
    case AlreadyHaveAnAccountButton
    case RegisterNewUser
}


class LoginView: UIScrollView {

    var registerView: RegisterView?
    
    public let backgroundView: UIImageView = {
        let backgroundView = UIImageView(image: UIImage(named: "Leaves.png"))
        backgroundView.alpha = 0.45
        return backgroundView
    }()
    public let findSpotLabel: UILabel = {
        let findSpotLabel = UILabel()
        findSpotLabel.text = "FindSpot"
        if let font = UIFont(name: "Comfortaa", size: 38) {
            findSpotLabel.font = font
        }
        findSpotLabel.textColor = UIColor.white
        return findSpotLabel
    }()
    public let passwordTextField: UITextField = {
        let passwordTextField = UITextField()
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.tag = TextFields.PasswordTextField.rawValue
        passwordTextField.setTextAndFont(.PasswordTextField)
        passwordTextField.setKeyboardSettings(.PasswordTextField)
        return passwordTextField
    }()
    public let emailTextField: UITextField = {
        let emailTextField = UITextField()
        emailTextField.borderStyle = .roundedRect
        emailTextField.tag = TextFields.EmailTextField.rawValue
        emailTextField.setTextAndFont(.EmailTextField)
        emailTextField.setKeyboardSettings(.EmailTextField)
        return emailTextField
    }()
    public let loginButton: UIButton = {
        let loginButton = UIButton()
        loginButton.setButtonAppearance(.LoginButton)
        return loginButton
    }()
    public let registerButton: UIButton = {
        let registerButton = UIButton()
        registerButton.setButtonAppearance(.RegisterButton)
        return registerButton
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = #colorLiteral(red: 0.4078431373, green: 0.6941176471, blue: 0.09411764706, alpha: 1)
        
        self.addSubview(backgroundView)
        self.addSubview(findSpotLabel)
        self.addSubview(passwordTextField)
        self.addSubview(emailTextField)
        self.addSubview(loginButton)
        self.addSubview(registerButton)
        
        for subview in self.subviews {
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
        
        self.setUpConstraints()
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func setUpConstraints() {
        
        self.backgroundView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.backgroundView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5).isActive = true
        self.backgroundView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        
        self.findSpotLabel.topAnchor.constraintEqualToSystemSpacingBelow(self.topAnchor, multiplier: 10).isActive = true
        self.findSpotLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        self.emailTextField.translatesAutoresizingMaskIntoConstraints = false
        self.emailTextField.topAnchor.constraintEqualToSystemSpacingBelow(findSpotLabel.bottomAnchor, multiplier: 8).isActive = true
        self.emailTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.emailTextField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.75).isActive = true
        self.emailTextField.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        self.passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20).isActive = true
        self.passwordTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.passwordTextField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.75).isActive = true
        self.passwordTextField.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        self.loginButton.topAnchor.constraint(equalTo: self.passwordTextField.bottomAnchor, constant: 35).isActive = true
        self.loginButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.loginButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.6).isActive = true
        self.loginButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        self.loginButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        self.registerButton.topAnchor.constraint(equalTo: self.loginButton.bottomAnchor, constant: 10).isActive = true
        self.registerButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.registerButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    
    
    
    // MARK: setting action methods for buttons
    
    func setActionsForButton(using viewController: LoginViewController) {
        self.loginButton.addTarget(viewController, action: #selector(LoginViewController.loginActionMethod), for: .touchUpInside)
        self.registerButton.addTarget(viewController, action: #selector(LoginViewController.registerActionMethod), for: .touchUpInside)
    }
    
    
    
    //MARK: - setting UITextField delegate method
    
    func setDelegateOfLoginViewTextFields(using viewController: LoginViewController) {
       self.emailTextField.delegate = viewController
       self.passwordTextField.delegate = viewController
    }
    
    
    
    
    
    //MARK: - animating appearing/disappearing of RegisterView methods
    
    
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
            })
        }
    }
    
    
    
    func createRegisterView() {
        let registerView = RegisterView(with: self)
        self.registerView = registerView
    }
    
    
    
    
    
    
    
    //MARK: - Adjasting content size methods
    
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





