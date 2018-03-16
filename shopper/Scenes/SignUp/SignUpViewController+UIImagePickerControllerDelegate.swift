//
//  SignUpViewController+UIImagePickerControllerDelegate.swift
//  shopper
//
//  Created by Misael Cuevas Vásquez on 3/13/18.
//  Copyright © 2018 Cuevas Cabrera. All rights reserved.
//

import Foundation
import UIKit

extension SignUpViewController : UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            thumbnail.image = pickedImage
            thumbnail.toRounded(borderWidth: 1, borderColor: nil)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
