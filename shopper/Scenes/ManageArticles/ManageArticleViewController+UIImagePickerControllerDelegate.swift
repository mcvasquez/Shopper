//
//  ManageArticleViewController+UIImagePickerControllerDelegate.swift
//  shopper
//
//  Created by Misael Cuevas Vásquez on 3/16/18.
//  Copyright © 2018 Cuevas Cabrera. All rights reserved.
//

import Foundation
import UIKit

extension ManageArticleViewController : UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerEditedImage] as! UIImage
        thumbnail.image = chosenImage
        thumbnail.toRounded(borderWidth: 1, borderColor: nil)
        dismiss(animated:true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
