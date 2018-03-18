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
        case articles
    }
    
    enum FirebaseError {
        case UserNotFound
        case Unknown
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
    
    static func updatePassword(currentPassword: String, newPassword: String, completionHandler: @escaping (FirebaseError?) -> ()) -> () {
        guard let user = Auth.auth().currentUser else {
            completionHandler(.UserNotFound)
            return
        }
        
        SignInFirebase(aEmail: user.email!, aPass: currentPassword) { response, _ in
            if response {
                Auth.auth().currentUser?.updatePassword(to: newPassword, completion: { error in
                    if error == nil {
                        SignOut(completionHandler: { _,_ in })
                        completionHandler(nil)
                    } else {
                        completionHandler(.Unknown)
                    }
                })
            } else {
                completionHandler(.UserNotFound)
            }
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
            let userReference = FirebaseHelper.ref.child(FirebaseDBKeys.users.rawValue).child(userID!)
            let values = ["name": name, "thumbnail": url!.absoluteString] as [String : Any]
            userReference.updateChildValues(values, withCompletionBlock: { (error, ref) in
                
                print("sucess")
                guard error == nil else {
                    return
                }
                
                completion(true, "user has being record")
                debugPrint("sucess")
            })
        }
    }
    
    static func articlesQuery() -> DatabaseQuery  {
        let ref = FirebaseHelper.ref.child(FirebaseDBKeys.articles.rawValue)
        return ref.queryOrdered(byChild: "position")
    }
    
    static func setArticleData(id: String?, address: String ,image: UIImage, description: String, price: String, title : String, completion: @escaping (Bool,String) -> ()) {
        uploadImage(image: image) { (url, message) in
            debugPrint(message)
            guard url != nil else {
                completion(false,"There was an error saving image")
                return
            }
            let userID = Auth.auth().currentUser?.uid
            let aPrice = Double(price)
            
            let aId: String = id ?? UUID().uuidString
            
            let artReference = FirebaseHelper.ref.child(FirebaseDBKeys.articles.rawValue).child(aId)
            let timestamp = Date().timeIntervalSince1970
            let values = [
                "address": address,
                "image": url!.absoluteString,
                "description" : description,
                "price": aPrice!,
                "title" : title,
                "timestamp": timestamp,
                "position": Double("-\(timestamp)")!,
                "user/\(userID!)" : true
            ] as [String : Any]
            
            artReference.updateChildValues(values, withCompletionBlock: { (error, dbRef) in
                print("sucess")
                guard error == nil else {
                    return
                }
                
                guard Auth.auth().currentUser != nil else {
                    completion(true, "user has being record")
                    return
                }
                
                ref.child(FirebaseDBKeys.users.rawValue)
                    .child(Auth.auth().currentUser!.uid)
                    .child(FirebaseDBKeys.articles.rawValue)
                    .child(aId).setValue(true)
                
                completion(true, "user has being record")
                debugPrint("sucess")
            })
        }
    }
    
    static func removeArticle(id: String, completion: @escaping (Error?) -> ()) -> () {
        // Delete article
        ref.child(FirebaseDBKeys.articles.rawValue)
            .child(id)
            .removeValue { error, dbRef in
                if error == nil {
                    // Delete article in user
                    guard Auth.auth().currentUser != nil else {
                        completion(nil)
                        return
                    }
                    
                    ref.child(FirebaseDBKeys.users.rawValue)
                        .child(Auth.auth().currentUser!.uid)
                        .child(FirebaseDBKeys.articles.rawValue)
                        .child(id)
                        .removeValue()
                    
                    completion(nil)
                } else {
                   completion(error)
                }
        }
    }
}
