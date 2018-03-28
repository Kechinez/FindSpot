//
//  LoginViewController.swift
//  thesisProject
//
//  Created by Nikita Kechinov on 23.03.2018.
//  Copyright © 2018 Nikita Kechinov. All rights reserved.
//

import UIKit
import Firebase

public enum TextFields: Int {
    case nameTextField     = 0
    case emailTextField    = 1
    case passwordTextField = 2
}

enum TextFeildsErrorType: String {
    case invalidEmailFormat = "wrong email address format"
    case invalidName = "name contains invalid symbols"
    case passwordError = "must be more than 8 letters"
}

class LoginViewController: UIViewController, UITextFieldDelegate {
    var passTextField: UITextField?
    var emailTextField: UITextField?
    var nameTextField: UITextField?
    var loginView: LoginView?
    var registrationIsAllowed = [false, false, false]
    var ref: DatabaseReference!
    
    override func loadView() {
        let scrollView = UIScrollView()
        self.view = scrollView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let loginView = LoginView(withAssociated: self)
        self.loginView = loginView
        self.view.addSubview(self.loginView!)
        ref = Database.database().reference(withPath: "users")
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(notification: )), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
        
    }

    

    
    
    // MARK: - register and login methods
    
   @objc func loginActionMethod() {
        Auth.auth().signIn(withEmail: self.emailTextField!.text!, password: passTextField!.text!) { [weak self] (user, error) in
            guard error == nil, user != nil else {
                // здесь напистаь метод для показа ошибки при логине
                return
            }
            let navigationController = UINavigationController(rootViewController: CustomTabBarController())
            self?.present(navigationController, animated: true, completion: nil)
        }
    }
    
    
    @objc func registerActionMethod() {
        let registerRect = CGRect(x: (self.view.frame.width / 6 - 15), y: (self.view.frame.height / 2 - 15), width: self.view.frame.width * 2/3 + 30, height: 255)
        let registerView = RegisterView(frame: registerRect, loginViewController: self)
        registerView.tag = 10
        
        registerView.alpha = 0
        registerView.setTextFieldsDelegate(with: self)
        registerView.setTextFeildsForRegisterUsage(within: self)
        self.loginView!.addSubview(registerView)
        self.loginView!.bringSubview(toFront: registerView)
        
        UIView.animate(withDuration: 1.2, animations: {
            registerView.alpha = 1
        }, completion: nil)
        
        
    }

    
    @objc func registerNewUser() {
        for bool in self.registrationIsAllowed {
            if !bool {
                return
            }
        }
        Auth.auth().createUser(withEmail: self.emailTextField!.text!, password: self.passTextField!.text!) { [weak self] (user, error) in
            
            guard error == nil, user != nil else {
                // здесь разобраться с ошибкой ее типом и вывести эту ошибку в UILabel
                return
            }
        
            guard let userRef = self?.ref.child((user?.uid)!) else { return }
            userRef.setValue(["name": self?.nameTextField?.text])
        }
        
        let navigationController = UINavigationController(rootViewController: CustomTabBarController())
        self.present(navigationController, animated: true, completion: nil)
    }
    
    
    
    
    // MARK: - keyboard notification methods
    
    @objc func keyboardDidShow(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        let keyboardFrameSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let scrollableView = self.view as! UIScrollView
        scrollableView.contentSize = CGSize(width: self.view.bounds.width, height: self.view.bounds.height + keyboardFrameSize.height / 2)
        scrollableView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrameSize.height, right: 0)
        
    }
    
    
    @objc func keyboardDidHide() {
        let scrollableView = self.view as! UIScrollView
        scrollableView.contentSize = CGSize(width: self.view.bounds.width, height: self.view.bounds.height)
    }
    
    

    
    // MARK: - TextField delegate methods
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField.textColor == .red {
            textField.textColor = .black
            textField.text = ""
        }
        return true
    }
   
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        self.textFieldTextChecking(within: textField)
        return true
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    
   
    
    
    
    // MARK: - Additional methods
    
    @objc func removeRegisterView() {
        var tempRegisterView: RegisterView?
        for view in self.loginView!.subviews {
            if view.tag == 10 {
                tempRegisterView = view as? RegisterView
            }
        }
        guard let registerView = tempRegisterView else { return }
        print(registerView.subviews.count)
        UIView.animate(withDuration: 1.2, animations: {
            registerView.alpha = 0
            
            
            self.view.layoutSubviews()
        }, completion: { (true) in
            registerView.removeFromSuperview()
            self.loginView?.setTextFieldDelegate(with: self)
            self.loginView?.setTextFieldsForLoginUsage(within: self)
        })
        
    }
    
    
    func showError(with error: TextFeildsErrorType, within textField: UITextField) {
        switch error {
        case .invalidEmailFormat:
            textField.text = error.rawValue
        case .invalidName:
            textField.text = error.rawValue
        case .passwordError:
            textField.text = error.rawValue
        }
        textField.textColor = UIColor.red
    }
    
    
    func textFieldTextChecking(within textField: UITextField) {
        guard let resultText = textField.text else { return }
        guard !(resultText == "") else {
            self.registrationIsAllowed[textField.tag] = false
            return
        }
        switch textField.tag {
        case TextFields.nameTextField.rawValue:
            let allowedChars = CharacterSet.alphanumerics
            if (resultText.trimmingCharacters(in: allowedChars) != "") {
                self.showError(with: .invalidName, within: textField)
                self.registrationIsAllowed[TextFields.nameTextField.rawValue] = false
                return
            }
        case TextFields.emailTextField.rawValue:
            if !resultText.isEmail() {
                self.showError(with: .invalidEmailFormat, within: textField)
                self.registrationIsAllowed[TextFields.emailTextField.rawValue] = false
                return
            }
        case TextFields.passwordTextField.rawValue:
            if resultText.count < 8 {
                self.showError(with: .passwordError, within: textField)
                self.registrationIsAllowed[TextFields.passwordTextField.rawValue] = false
                return
            }
        default:
            break
        }
        
        self.registrationIsAllowed[textField.tag] = true
    
    }
    
    
    
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



