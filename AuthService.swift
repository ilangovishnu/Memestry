//
//  AuthService.swift
//  Memestry
//
//  Created by Vishnu Priya on 5/6/19.
//  Copyright © 2019 Codepath. All rights reserved.
//

import Foundation
import FirebaseAuth
class AuthService{
    
    static func signIn(email: String, password: String, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String?) -> Void){
        
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user,error) in
        if error != nil {
            print(error!.localizedDescription)
            return
        }
            onSuccess()
    })

    
    }
   
    
    
    
    
}


