//
//  shopperTests.swift
//  shopperTests
//
//  Created by Misael Cuevas Vásquez on 3/4/18.
//  Copyright © 2018 Cuevas Cabrera. All rights reserved.
//

import XCTest
import Firebase
import FirebaseDatabase
import FirebaseAuth

@testable import shopper

class shopperTests: XCTestCase {
    let aEmail = "dcabrera@outlook.es"
    let aPass = "123456"
    
    override func setUp() {
        super.setUp()
        
    }
    
    override func tearDown() {
        
        super.tearDown()
    }
    
    func testConectionToDatabase() {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        XCTAssertNotNil(ref, "Es Nil")
    }
    
    func testRegisterFirebase() {
        let expect = expectation(description: "CreateFirebaseUser")
        Auth.auth().createUser(withEmail: aEmail, password: aPass) { (user, error) in
            guard error == nil else {
                XCTFail("the auth has not be succesfully")
                return
            }
            debugPrint(user?.email ?? "Not email")
            debugPrint("Success creating user")
            expect.fulfill()
        }
        
        waitForExpectations(timeout: 10.0, handler: { (error) in
            print("Error: \(String(describing: error?.localizedDescription))")
        })
    
    }
    
    func testSignInFirebase()  {
        let expect = expectation(description: "SignInUser")
        FirebaseHelper.SignInFirebase(aEmail: aEmail, aPass: aPass) { (success, message) in
            debugPrint(message)
            expect.fulfill()
        }
        waitForExpectations(timeout: 10.0, handler: { (error) in
            print("Error: \(String(describing: error?.localizedDescription))")
        })
    }
    
    func testSignOutFirebase()  {
        do {
            try Auth.auth().signOut()
        } catch  {
            XCTFail("Fail going out")
        }
    }
    
    func testGetUser() {
        let expect = expectation(description: "Users get")
        var ref: DatabaseReference!
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let username = value?["name"] as? String ?? ""
            XCTAssertEqual(username, "Daniel Cabrera")
            debugPrint(username)
            expect.fulfill()
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
        
        waitForExpectations(timeout: 10.0, handler: { (error) in
            print("Error: \(String(describing: error?.localizedDescription))")
        })
        
    }
    
    func testUserImage() {
        let expect = expectation(description: "Users send")
        let image = UIImage(named: "zelda")
        FirebaseHelper.setUserData(name: "Juancho", thumbnail: image!) { (succes, message) in
            debugPrint(message)
            expect.fulfill()
        }
        
        waitForExpectations(timeout: 10.0, handler: { (error) in
            print("Error: \(String(describing: error?.localizedDescription))")
        })
    }
    
   
    
}
