//
//  ManageArticleViewController.swift
//  shopper
//
//  Created by Misael Cuevas Vásquez on 3/12/18.
//  Copyright © 2018 Cuevas Cabrera. All rights reserved.
//

import UIKit
import Toast_Swift

class ManageArticleViewController: UIViewController {

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
        // basic usage
        picker.delegate = self
        scrollContentView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        
        self.articleDescription.layer.borderWidth = 1
        self.articleDescription.layer.borderColor = UIColor.lightGray.cgColor
        
        onBeginControllerAnimation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    @IBAction func didAddImage(_ sender: Any) {
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        
        present(picker, animated: true, completion: nil)
    }
    
    @IBAction func didManageArticle(_ sender: Any) {
        self.view.makeToast("Articulo enviado :)")
        FirebaseHelper.setArticleData(address: address.text!, image: thumbnail.image!, description: articleDescription.text!, price: price.text!, title: articleTitle.text!) { (sucess, message) in
            debugPrint(message)
            if sucess {
                
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
             self.navigationController?.popViewController(animated: true)
        }
       
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func onBeginControllerAnimation() {
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
}
