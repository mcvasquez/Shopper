//
//  ManageArticleViewController.swift
//  shopper
//
//  Created by Misael Cuevas Vásquez on 3/12/18.
//  Copyright © 2018 Cuevas Cabrera. All rights reserved.
//

import UIKit

class ManageArticleViewController: UIViewController, UINavigationControllerDelegate,UIImagePickerControllerDelegate {

    @IBOutlet weak var contentViewWidth: NSLayoutConstraint!
    @IBOutlet weak var scrollContentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var articleTitle: UITextField!
    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var condition: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var articleDescription: UITextView!
    let picker = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        scrollContentView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        // Do any additional setup after loading the view.
        weak var weakSelf = self
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut,
                       animations: {
                        weakSelf?.scrollContentView.transform = CGAffineTransform(scaleX:1, y:1)
        }) { done in
            
            UIView.animate(withDuration: 0.3, delay: 0.2, options: .curveEaseInOut,
                           animations: {  
                             weakSelf?.scrollContentView.transform = .identity
            })
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    @IBAction func didAddImage(_ sender: Any) {
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerEditedImage] as! UIImage
        thumbnail.image = chosenImage
        dismiss(animated:true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didManageArticle(_ sender: Any) {
        FirebaseHelper.setArticleData(address: address.text!, image: thumbnail.image!, description: articleDescription.text!, price: price.text!, title: articleTitle.text!) { (sucess, message) in
            debugPrint(message)
            if sucess {
                
            }
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}
