//
//  Message.swift
//  shopper
//
//  Created by Misael Cuevas Vásquez on 3/22/18.
//  Copyright © 2018 Cuevas Cabrera. All rights reserved.
//

import Foundation
import CoreLocation
import MessageKit
import Firebase

struct Message : MessageType {
    var messageId: String
    var sender: Sender
    var sentDate: Date
    var data: MessageData
    
    /*
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
        
        if let user = (dict["user"] as? [String:Any])?.keys.first {
            self.user = user
        } else {
            self.user = ""
        }
    }
 */
    
    init(data: MessageData, sender: Sender, messageId: String, date: Date) {
        self.data = data
        self.sender = sender
        self.messageId = messageId
        self.sentDate = date
    }
    
    init(text: String, sender: Sender, messageId: String, date: Date) {
        self.init(data: .text(text), sender: sender, messageId: messageId, date: date)
    }
    
    init(attributedText: NSAttributedString, sender: Sender, messageId: String, date: Date) {
        self.init(data: .attributedText(attributedText), sender: sender, messageId: messageId, date: date)
    }
    
    init(image: UIImage, sender: Sender, messageId: String, date: Date) {
        self.init(data: .photo(image), sender: sender, messageId: messageId, date: date)
    }
    
    init(thumbnail: UIImage, sender: Sender, messageId: String, date: Date) {
        let url = URL(fileURLWithPath: "")
        self.init(data: .video(file: url, thumbnail: thumbnail), sender: sender, messageId: messageId, date: date)
    }
    
    init(location: CLLocation, sender: Sender, messageId: String, date: Date) {
        self.init(data: .location(location), sender: sender, messageId: messageId, date: date)
    }
    
    init(emoji: String, sender: Sender, messageId: String, date: Date) {
        self.init(data: .emoji(emoji), sender: sender, messageId: messageId, date: date)
    }
}
