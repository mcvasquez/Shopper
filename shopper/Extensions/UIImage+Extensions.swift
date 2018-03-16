//
//  UIImage+Extensions.swift
//  shopper
//
//  Created by Misael Cuevas Vásquez on 3/16/18.
//  Copyright © 2018 Cuevas Cabrera. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func toRounded(borderWidth: CGFloat?, borderColor: UIColor?) {
        if let bw = borderWidth {
            self.layer.borderWidth = bw
        }
        
        self.layer.masksToBounds = false
        self.layer.borderColor = borderColor?.cgColor ?? UIColor.black.cgColor
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
    }
}
