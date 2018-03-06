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

@testable import shopper

class shopperTests: XCTestCase {
    
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
    
}
