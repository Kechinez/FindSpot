//
//  LoginViewProtocol.swift
//  thesisProject
//
//  Created by Nikita Kechinov on 21.06.2018.
//  Copyright © 2018 Nikita Kechinov. All rights reserved.
//

import Foundation
import UIKit

public enum TextFields: Int {
    case NameTextField           = 0
    case EmailTextField          = 1
    case PasswordTextField       = 2
    case FindPlaceTextFeild      = 3
    case PlaceNameTextField      = 4
}

public enum ButtonType {
    case LoginButton
    case RegisterButton
    case AlreadyHaveAnAccountButton
    case RegisterNewUserButton
    case ShowSpotImagesButton
}

extension String {
    func isEmail() -> Bool {
        let firstPart = "[A-Z0-9a-z]([A-Z0-9a-z._%+-]{0,30}[A-Z0-9a-z])?"
        let serverPart = "([A-Z0-9a-z]([A-Z0-9a-z-]{0,30}[A-Z0-9a-z])?\\.){1,5}"
        let emailRegex = firstPart + "@" + serverPart + "[A-Za-z]{2,6}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: self)
    }
}

extension UIButton {
    func setButtonAppearance(_ buttonType: ButtonType) {
        guard let buttonFont = UIFont(name: "OpenSans", size: 20.0) else { return }
        switch buttonType {
        case .LoginButton, .RegisterNewUserButton:
            self.titleLabel?.font = buttonFont
            self.setTitleColor(UIColor.white, for: .normal)
            self.layer.cornerRadius = 8.0
            self.backgroundColor = #colorLiteral(red: 0.2549019608, green: 0.5137254902, blue: 0.7568627451, alpha: 1)
            if buttonType == .LoginButton {
                self.setTitle("Login", for: .normal)
            } else {
                self.setTitle("Register", for: .normal)
            }
        case .RegisterButton, .AlreadyHaveAnAccountButton, .ShowSpotImagesButton:
            self.setTitleColor(UIColor.white, for: .normal)
            self.titleLabel?.font = buttonFont.withSize(18.0)
            if buttonType == .RegisterButton {
                self.setTitle("Register", for: .normal)
            } else if buttonType == .AlreadyHaveAnAccountButton {
                self.setTitle("I already have account", for: .normal)
            } else {
                self.backgroundColor = #colorLiteral(red: 0.2549019608, green: 0.5137254902, blue: 0.7568627451, alpha: 1)
                self.layer.cornerRadius = 8.0
                self.setTitle("Show spot's images", for: .normal)
            }
        }
    }
}


extension UITextField {
    func setTextAndFont(_ textFieldType: TextFields) {
        guard let placeholderFont = UIFont(name: "OpenSans", size: 14.0),
              let textFieldFont = UIFont(name: "OpenSans", size: 18.0) else { return }
        let attributesDictionary: [NSAttributedStringKey: Any] = [
            NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue): #colorLiteral(red: 0.6257788431, green: 0.6374320992, blue: 0.6723918676, alpha: 1),
            NSAttributedStringKey(rawValue: NSAttributedStringKey.font.rawValue): placeholderFont]
        
        switch textFieldType {
        case .NameTextField:
            let atributedPlaceholder = NSMutableAttributedString(string: "write your nickname")
            atributedPlaceholder.addAttributes(attributesDictionary, range: NSRange (location:0, length: atributedPlaceholder.length))
            self.attributedPlaceholder = atributedPlaceholder
            self.font = textFieldFont
        case .EmailTextField:
            let atributedPlaceholder = NSMutableAttributedString(string: "write your email")
            atributedPlaceholder.addAttributes(attributesDictionary, range: NSRange (location:0, length: atributedPlaceholder.length))
            self.attributedPlaceholder = atributedPlaceholder
            self.font = textFieldFont
        case .PasswordTextField:
            let atributedPlaceholder = NSMutableAttributedString(string: "write your password")
            atributedPlaceholder.addAttributes(attributesDictionary, range: NSRange (location:0, length: atributedPlaceholder.length))
            self.attributedPlaceholder = atributedPlaceholder
            self.font = textFieldFont
        case .FindPlaceTextFeild:
            let atributedPlaceholder = NSMutableAttributedString(string: "Find place")
            atributedPlaceholder.addAttributes(attributesDictionary, range: NSRange (location:0, length: atributedPlaceholder.length))
            self.attributedPlaceholder = atributedPlaceholder
            self.font = UIFont(name: "OpenSans", size: 15.0)
        case .PlaceNameTextField:
            let atributedPlaceholder = NSMutableAttributedString(string: "Name of spot")
            atributedPlaceholder.addAttributes(attributesDictionary, range: NSRange (location:0, length: atributedPlaceholder.length))
            self.attributedPlaceholder = atributedPlaceholder
            self.font = textFieldFont
        }
    }
    
    
    func setKeyboardSettings(_ textFieldType: TextFields) {
        switch textFieldType {
        case .NameTextField, .PlaceNameTextField:
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

