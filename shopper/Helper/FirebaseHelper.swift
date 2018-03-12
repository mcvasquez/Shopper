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
    
    enum FirebaseDBKeys : String {
        case users
    }
    
    static var ref: DatabaseReference! = {
        return Database.database().reference()
    }()
    
    
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
        guard Auth.auth().currentUser != nil else {
             completionHandler(false, "User not log in")
            return
        }
            completionHandler(true, "User log in")
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
    
    static func getUserData(completionHandler: @escaping (NSDictionary?, Bool) -> ()) {
        let userID = Auth.auth().currentUser?.uid
        ref.child(FirebaseDBKeys.users.rawValue).child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            if let value = snapshot.value as? NSDictionary {
                completionHandler(value, true)
            } else {
                completionHandler(nil, false)
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    static func uploadImage(image: UIImage, completion: @escaping (URL?,String) -> ()) {
        guard let data = UIImagePNGRepresentation(image) else { return completion(nil, "Error formatting image ")}
        let storageRef = Storage.storage().reference()
        let riversRef =  storageRef.child("\(UUID().uuidString).png")
        _ = riversRef.putData(data, metadata: nil) { (metadata, error) in
            guard let metadata = metadata else {
                completion(nil,"Error saving image")
                return
            }
            // Metadata contains file metadata such as size, content-type, and download URL.
            completion(metadata.downloadURL(), "Success storing image")
        }
    }
    
    static func setUserData(name: String ,thumbnail: UIImage, completion: @escaping (Bool,String) -> ()) {
        uploadImage(image: thumbnail) { (url, message) in
            debugPrint(message)
            guard url != nil else {
                completion(false,"There was an error saving image")
                return
            }
            let userID = Auth.auth().currentUser?.uid
            self.ref.child("users").child(userID!).setValue(["name": name, "thumbnail": url?.absoluteString])
            completion(true, "user has being record")
        }
    }
}
