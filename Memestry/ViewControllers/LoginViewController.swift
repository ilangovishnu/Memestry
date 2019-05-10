//
//  LoginViewController.swift
//  Memestry
//
//  Created by Vishnu Priya on 4/23/19.
//  Copyright © 2019 Codepath. All rights reserved.
//

import UIKit
import FirebaseAuth
import ProgressHUD

@objcMembers class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.backgroundColor=UIColor.clear
        emailTextField.tintColor = UIColor.white
        emailTextField.textColor = UIColor.white
        emailTextField.attributedPlaceholder = NSAttributedString(string: emailTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor : UIColor(white: 1.0, alpha: 0.6)])
        let bottomLayerEmail = CALayer()
        bottomLayerEmail.frame = CGRect(x: 0, y: 29, width: 1000, height: 0.6)
        bottomLayerEmail.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 25/255, alpha: 1).cgColor
        emailTextField.layer.addSublayer(bottomLayerEmail)
        
        passwordTextField.backgroundColor=UIColor.clear
        passwordTextField.tintColor = UIColor.white
        passwordTextField.textColor = UIColor.white
        passwordTextField.attributedPlaceholder = NSAttributedString(string: passwordTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor : UIColor(white: 1.0, alpha: 0.6)])
        let bottomLayerPassword = CALayer()
        bottomLayerPassword.frame = CGRect(x: 0, y: 29, width: 1000, height: 0.6)
        bottomLayerPassword.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 25/255, alpha: 1).cgColor
        passwordTextField.layer.addSublayer(bottomLayerPassword)
        
        loginButton.isEnabled = false
        
        handleTextField()
        
        
    }
    
    //Dismiss Keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
         if Auth.auth().currentUser != nil {
        self.performSegue(withIdentifier: "loginTabbarVC", sender: nil)
        }
    }
    
    func handleTextField() {
    
        emailTextField.addTarget(self, action: #selector(self.textFieldDidChange), for: UIControl.Event.editingChanged)
        passwordTextField.addTarget(self, action: #selector(self.textFieldDidChange), for: UIControl.Event.editingChanged)
        
    }
    
    
    
        func textFieldDidChange() {
        guard let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty else {
            
            loginButton.setTitleColor(UIColor.lightText, for: UIControl.State.normal)
            loginButton.isEnabled = false
            return
        }
        loginButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        loginButton.isEnabled = true
    }
    
    
    @IBAction func loginButton_TouchUpInside(_ sender: Any) {
        view.endEditing(true)
        ProgressHUD.show("Waiting...",interaction: false)

        AuthService.signIn(email: emailTextField.text!, password: passwordTextField.text!, onSuccess: { ProgressHUD.showSuccess("Success")
            self.performSegue(withIdentifier: "loginTabbarVC", sender: nil)},
                           onError: { error in ProgressHUD.showError("Incorrect email or password")})
        
//{ error in ProgressHUD.showError("Incorrect email or password")}
//        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user,error) in
//            if error != nil {
//                print(error!.localizedDescription)
//                return
//            }
//            
//            self.performSegue(withIdentifier: "loginTabbarVC", sender: nil)
//        })
    }
    
    
    
}

