//
//  ArticlesModel.swift
//  shopper
//
//  Created by Daniel Cabrera on 3/13/18.
//  Copyright © 2018 Cuevas Cabrera. All rights reserved.
//

import Foundation
import Firebase

struct Articles {
    
    var id: String
    var address, description, image, title: String
    var price: Double
    var timestamp: Date
    var position: Double
    var user: String?
    
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String: Any] else { return nil }
        guard let address = dict["address"] else { return nil }
        guard let description = dict["description"] else { return nil }
        guard let image = dict["image"] else { return nil }
        guard let title = dict["title"] else { return nil }
        guard let price = dict["price"] else { return nil }
        guard let timestamp = dict["timestamp"] as? Double else { return nil }
        guard let position = dict["position"] as? Double else { return nil }
        
        self.id = snapshot.key
        self.address = address as! String
        self.description = description as! String
        self.image = image as! String
        self.title = title as! String
        self.price = price as! Double
        self.timestamp = Date(timeIntervalSince1970: TimeInterval(timestamp)) as Date
        self.position = position
        
//        snapshot.childSnapshot(forPath: "user").hasChild("k3Y3ga9xBsYUFPhaIjsNo6EaUO82")
        if let user = (dict["user"] as? [String:Any])?.keys.first {
            self.user = user
        } else {
            self.user = ""
        }
    }
}
