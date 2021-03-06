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
    @IBOutlet weak var errorMessage: UILabel!
    
    let LOGIN = "Login"
    let SIGNUP = "Sign Up"
    var authType = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        email.delegate = self
        password.delegate = self
        observeKeyboard()
        email.placeholder = "Enter email"
        password.placeholder = "Enter password"
        signup.setTitleColor(UIColor.init(hexString: "#94c7f2"), for: .normal)
        authType = LOGIN
    }
    
    // todo handle different error message
    // hide error message on input change
    @IBAction func handleStart(_ sender: Any) {
        
        SVProgressHUD.show()
        switch authType {
            case LOGIN:
            Auth.auth().signIn(withEmail: email.text!, password: password.text!) {
                (user, error) in
                SVProgressHUD.dismiss()
                if error != nil {
                    self.errorMessage.text = "Failed"
                    print("Login error \(error!)")
                } else {
//                    self.currentUser = user?.user
                    self.performSegue(withIdentifier: "goToCategories", sender: self)
                }
            }
            case SIGNUP:
            Auth.auth().createUser(withEmail: email.text!, password: password.text!) {
                (user, error) in
                SVProgressHUD.dismiss()
                if error != nil {
                    self.errorMessage.text = "Failed"
                    print("Sign up error \(error!)")
                } else {
                    print("> \(user!)")
                    self.performSegue(withIdentifier: "goToCategories", sender: self)
                }
            }
            default:
            print("default")
        }
    }
    
    //MARK: - prepare segue
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let navVC = segue.destination as! UINavigationController
//        let categoryVC = navVC.viewControllers.first as! CategoryViewController
//        categoryVC.currentUser = currentUser
//    }
    
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
