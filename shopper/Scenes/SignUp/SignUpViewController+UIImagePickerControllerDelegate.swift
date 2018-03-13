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
            thumbnail.contentMode = .scaleAspectFit
            thumbnail.image = pickedImage
            
            thumbnail.layer.borderWidth = 1
            thumbnail.layer.masksToBounds = false
            thumbnail.layer.borderColor = UIColor.black.cgColor
            thumbnail.layer.cornerRadius = thumbnail.frame.height/2
            thumbnail.clipsToBounds = true
        }
        
//        if let pickedImageURL = info[UIImagePickerControllerImageURL] as? URL {
//            self.pickedPhotoURL = pickedImageURL
//        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
