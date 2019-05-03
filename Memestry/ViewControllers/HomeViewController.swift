//
//  HomeViewController.swift
//  Memestry
//
//  Created by Vishnu Priya on 4/23/19.
//  Copyright © 2019 Codepath. All rights reserved.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = UIColor.yellow
        // Do any additional setup after loading the view.
    }

    
    
    @IBAction func logout_TouchUpInside(_ sender: Any) {
        //print(Auth.auth().currentUser!)
        do{
            try Auth.auth().signOut()
        }
        catch let logoutError {

            print(logoutError)
        }
        //print(Auth.auth().currentUser!)

        let storyboard = UIStoryboard(name: "Start", bundle: nil)
        let loginVC = storyboard.instantiateViewController(withIdentifier:  "LoginViewController")

        self.present(loginVC, animated: true, completion: nil)
    }


}
