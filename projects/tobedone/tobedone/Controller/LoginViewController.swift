//
//  ViewController.swift
//  tobedone
//
//  Created by ArronStudio on 2019-07-09.
//  Copyright © 2019 AaronStudio. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD
import ChameleonFramework

class LoginViewController: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var login: UIButton!
    @IBOutlet weak var signup: UIButton!
    
    let LOGIN = "Login"
    let SIGNUP = "Sign Up"
    var authType = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        email.delegate = self
        password.delegate = self
        observeKeyboard()
        email.placeholder = "Enter login email"
        password.placeholder = "Enter login password"
        signup.setTitleColor(UIColor.init(hexString: "#94c7f2"), for: .normal)
        authType = LOGIN
    }
    
    @IBAction func handleStart(_ sender: Any) {
        
        SVProgressHUD.show()
        switch authType {
            case LOGIN:
            Auth.auth().signIn(withEmail: email.text!, password: password.text!) {
                (user, error) in
                SVProgressHUD.dismiss()
                if error != nil {
                    print("error \(error!)")
                } else {
                    print(user!)
                    self.performSegue(withIdentifier: "goToCategories", sender: self)
                }
            }
            case SIGNUP:
            Auth.auth().createUser(withEmail: email.text!, password: password.text!) {
                (user, error) in
                SVProgressHUD.dismiss()
                if error != nil {
                    print("Sign up error \(error!)")
                } else {
                    self.performSegue(withIdentifier: "goToCategories", sender: self)
                }
            }
            default:
            print("default")
        }
        
        
    }
    
    @IBAction func toggleAuthType(_ sender: Any) {
        let targetButton = sender as! UIButton
        let buttonText = targetButton.titleLabel!.text!
        switch buttonText {
        case LOGIN:
            toggleButtonStyle(highlight: login, inactive: signup)
            authType = LOGIN
        case SIGNUP:
            toggleButtonStyle(highlight: signup, inactive: login)
            authType = SIGNUP
        default:
            print("default")
        }
    }
    
    
    @objc func keyboardWillChange(notification: Notification) {
//        var keyboardHeight: CGFloat = 0.0
//        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
//            let keyboardRectangle = keyboardFrame.cgRectValue
//            keyboardHeight = keyboardRectangle.height
//            print("> \(keyboardHeight)")
//        }
        
        switch notification.name.rawValue {
        case "UIKeyboardWillShowNotification":
            view.frame.origin.y = -80
        case "UIKeyboardWillHideNotification":
            view.frame.origin.y = 0
        default:
            print("test")
        }
        
        
    }
    
    func toggleButtonStyle (highlight highlightButton: UIButton, inactive inactiveButton: UIButton) {
        highlightButton.setTitleColor(UIColor.init(hexString: "#ffffff"), for: .normal)
        inactiveButton.setTitleColor(UIColor.init(hexString: "#94c7f2"), for: .normal)
    }
    
    func observeKeyboard () {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
}

extension LoginViewController : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
//        activeTextField = textField
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.email.resignFirstResponder()
        self.password.resignFirstResponder()
        return true
    }
}
