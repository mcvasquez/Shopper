//
//  Double+Extensions.swift
//  shopper
//
//  Created by Misael Cuevas Vásquez on 3/16/18.
//  Copyright © 2018 Cuevas Cabrera. All rights reserved.
//

import Foundation

extension Double {
    func toCurrency() -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = NSLocale.current
        
        return currencyFormatter.string(from: NSNumber(value: self)) ?? ""
    }
}
