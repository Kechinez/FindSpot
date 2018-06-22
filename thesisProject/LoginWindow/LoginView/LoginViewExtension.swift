//
//  LoginViewProtocol.swift
//  thesisProject
//
//  Created by Nikita Kechinov on 21.06.2018.
//  Copyright © 2018 Nikita Kechinov. All rights reserved.
//

import Foundation
import UIKit


extension UIButton {
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


extension UITextField {
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
        case .FindPlaceTextFeild:
            let atributedPlaceholder = NSMutableAttributedString(string: "Find place")
            self.attributedPlaceholder = atributedPlaceholder
            self.font = UIFont(name: "OpenSans", size: 15.0)
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
        case .FindPlaceTextFeild:
            self.clearButtonMode = .whileEditing
            self.autocorrectionType = .no
            self.autocapitalizationType = .words
        }
    }
}

