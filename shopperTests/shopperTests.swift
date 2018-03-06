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
    let aEmail = "danielcabri@gmail.com"
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
        Auth.auth().signIn(withEmail: aEmail, password: aPass) { (user, error) in
            guard error == nil else {
                XCTFail("the auth has not be succesfully")
                return
            }
            debugPrint(user?.email ?? "Not email")
            debugPrint("Success Sign In")
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
    
}
