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
    
    

    
    
 
//        self.setTextFieldDelegate()
//        self.setTextFieldsForLoginUsage()
//        self.setUpConstraints()
  //  }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func setUpConstraints() {
        
//        self.translatesAutoresizingMaskIntoConstraints = false
//        self.topAnchor.constraint(equalTo: viewController.view.topAnchor).isActive = true
//        self.widthAnchor.constraint(equalTo: viewController.view.widthAnchor).isActive = true
//        self.heightAnchor.constraint(equalTo: viewController.view.heightAnchor).isActive = true
//        self.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
//        self.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor).isActive = true
//        self.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor).isActive = true
        
        
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
    
    
    
    
    
    func setActionsForButton(using viewController: LoginViewController) {
        self.loginButton.addTarget(viewController, action: #selector(LoginViewController.loginActionMethod), for: .touchUpInside)
        self.registerButton.addTarget(viewController, action: #selector(LoginViewController.registerActionMethod), for: .touchUpInside)
    }
    
    
    
    //MARK: - setting UITextField delegate methods
    
    
    
    
    
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
    
    
    
    
    
    
    //MARK: -Adjasting content size methods
    
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


public extension UITextField {
    
    func setTextAndFont(_ textFieldType: TextFields) {
        let placeholderFont = UIFont(name: "OpenSans", size: 14.0)
        let textFieldFont = UIFont(name: "OpenSans", size: 18.0)
        let attributesDictionary: [NSAttributedStringKey: Any] = [
            NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue): #colorLiteral(red: 0.6257788431, green: 0.6374320992, blue: 0.6723918676, alpha: 1),
            NSAttributedStringKey(rawValue: NSAttributedStringKey.font.rawValue): placeholderFont!]
        
        switch textFieldType {
        case .NameTextField:
            let atributedPlaceholder = NSMutableAttributedString(string: "write your nickname")
            atributedPlaceholder.addAttributes(attributesDictionary, range: NSRange (location:0, length: atributedPlaceholder.length))
            self.attributedPlaceholder = atributedPlaceholder
            self.font = textFieldFont!
        case .EmailTextField:
            let atributedPlaceholder = NSMutableAttributedString(string: "write your email")
            atributedPlaceholder.addAttributes(attributesDictionary, range: NSRange (location:0, length: atributedPlaceholder.length))
            self.attributedPlaceholder = atributedPlaceholder
            self.font = textFieldFont!
        case .PasswordTextField:
            let atributedPlaceholder = NSMutableAttributedString(string: "write your password")
            atributedPlaceholder.addAttributes(attributesDictionary, range: NSRange (location:0, length: atributedPlaceholder.length))
            self.attributedPlaceholder = atributedPlaceholder
            self.font = textFieldFont!
        }
    }


    func setKeyboardSettings(_ textFieldType: TextFields) {
        switch textFieldType {
        case .NameTextField:
            self.autocorrectionType = .no
            self.keyboardType = .alphabet
            self.autocapitalizationType = .words
        case .EmailTextField:
            self.autocorrectionType = .no
            self.keyboardType = .emailAddress
            self.autocapitalizationType = .none
        case .PasswordTextField:
            self.autocorrectionType = .no
            self.keyboardType = .emailAddress
            self.isSecureTextEntry = true
            self.autocapitalizationType = .none
        }
    }
    

}


public extension UIButton {
    func setButtonAppearance(_ buttonType: ButtonType) {
        let buttonFont = UIFont(name: "OpenSans", size: 22.0)
        switch buttonType {
        case .LoginButton:
            self.setTitle("Login", for: .normal)
            self.titleLabel?.font = buttonFont!
            self.setTitleColor(UIColor.white, for: .normal)
            self.layer.cornerRadius = 8.0
            self.backgroundColor = #colorLiteral(red: 0.2549019608, green: 0.5137254902, blue: 0.7568627451, alpha: 1)
        case .RegisterButton:
            self.setTitle("Register", for: .normal)
            self.setTitleColor(UIColor.white, for: .normal)
            self.titleLabel?.font = buttonFont!.withSize(19.0)
        case .AlreadyHaveAnAccountButton:
            self.setTitle("I already have account", for: .normal)
            self.setTitleColor(UIColor.white, for: .normal)
            self.titleLabel?.font = buttonFont!.withSize(19.0)
        case .RegisterNewUser:
            self.setTitle("Register", for: .normal)
            self.titleLabel?.font = buttonFont!
            self.setTitleColor(UIColor.white, for: .normal)
            self.layer.cornerRadius = 8.0
            self.backgroundColor = #colorLiteral(red: 0.2549019608, green: 0.5137254902, blue: 0.7568627451, alpha: 1)
        }
        
    }
}



