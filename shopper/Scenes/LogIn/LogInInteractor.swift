//
//  SignInInteractor.swift
//  shopper
//
//  Created by Daniel Cabrera on 3/6/18.
//  Copyright © 2018 Cuevas Cabrera. All rights reserved.
//

import Foundation
extension LogInViewController {
    
    func LogIn(aEmail: String, aPass: String ,completionHandler: @escaping (Bool) -> ()) {
        FirebaseHelper.LogInFirebase(aEmail: aEmail, aPass: aPass) { (success, message) in
            debugPrint(message)
            completionHandler(success)
        }
    }
    
}
