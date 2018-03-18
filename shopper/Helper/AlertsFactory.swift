//
//  AlertsFactory.swift
//  shopper
//
//  Created by Misael Cuevas Vásquez on 3/12/18.
//  Copyright © 2018 Cuevas Cabrera. All rights reserved.
//

import Foundation
import UIKit

func yesNoAlert (title: String?, message:String!, positiveText: String, positiveAction: (()-> ())?, negativeText: String, negativeAction: (()-> ())? ) -> UIAlertController {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: positiveText, style: .default, handler: { action in
        positiveAction?()
        alert.dismiss(animated: true, completion: nil)
    }))
    alert.addAction(UIAlertAction(title: negativeText, style: .cancel, handler: { action in
        negativeAction?()
        alert.dismiss(animated: true, completion: nil)
    }))
    return alert
}

func yesAlert(title: String?, message:String!, positiveText: String, positiveAction: (()-> ())?) -> UIAlertController {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: positiveText, style: .default, handler: { action in
        positiveAction?()
        alert.dismiss(animated: true, completion: nil)
    }))
    return alert
}
