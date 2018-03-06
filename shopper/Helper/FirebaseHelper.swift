//
//  FirebaseHelper.swift
//  shopper
//
//  Created by Daniel Cabrera on 3/6/18.
//  Copyright © 2018 Cuevas Cabrera. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseAuth

struct FirebaseHelper {
    static func SignInFirebase(aEmail: String, aPass: String, completionHandler: @escaping (Bool, String) -> ()) {
        Auth.auth().signIn(withEmail: aEmail, password: aPass) { (user, error) in
            guard error == nil else {
                completionHandler(false,"Email/username in use try again")
                return
            }
            completionHandler(true, "User sign in")
        }
    }
    
    static func isAlreadySignIn(completionHandler: @escaping (Bool, String) -> ()) {
        if Auth.auth().currentUser != nil {
            completionHandler(true, "User log in")
        } else {
            completionHandler(false, "User not log in")
        }
    }
    
    static func SignOut(completionHandler: @escaping (Bool, String) -> ()) {
        do {
            try Auth.auth().signOut()
            completionHandler(true, "Sign Out")
        } catch  {
            completionHandler(false, "Error Sign Out")
        }
    }
    
    static func CreateFirebaseUser(aEmail: String, aPass: String, completionHandler: @escaping (Bool, String) -> ()) {
        Auth.auth().createUser(withEmail: aEmail, password: aPass) { (user, error) in
            guard error == nil else {
                completionHandler(false,"Error handling user")
                return
            }
            debugPrint(user?.email ?? "Not email")
            debugPrint("Success creating user")
            completionHandler(true,"User created")
        }
    }
}
