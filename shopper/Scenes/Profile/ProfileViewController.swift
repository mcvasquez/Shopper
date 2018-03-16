//
//  ProfileViewController.swift
//  shopper
//
//  Created by Misael Cuevas Vásquez on 3/12/18.
//  Copyright © 2018 Cuevas Cabrera. All rights reserved.
//

import UIKit
import Firebase
import Kingfisher

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileStackView: UIStackView!
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var menuView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weak var weakSelf = self
        profileStackView.transform = CGAffineTransform(scaleX:0, y:0)
        profileStackView.alpha = 0.0
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut,
                       animations: {
                        weakSelf?.profileStackView.transform = CGAffineTransform(scaleX:1.2, y:1.2)
                        weakSelf?.profileStackView.alpha = 0.5
        }) { done in
            
            UIView.animate(withDuration: 0.3, delay: 0.2, options: .curveEaseInOut,
                           animations: {
                            weakSelf?.profileStackView.transform = .identity
                            weakSelf?.profileStackView.alpha = 1.0
            })
        }
        
        if let user =  Auth.auth().currentUser {
            email.text = user.email
            name.text = user.displayName
            
            FirebaseHelper.getUserData(completionHandler: { data, response  in
                if response {
                    self.name.text = data!["name"] as? String ?? ""
                    
                    if let imageUrl =  data!["thumbnail"] as? String {
                        self.thumbnail.kf.setImage(with: URL(string: imageUrl),
                                              placeholder: nil,
                                              options: [.transition(.fade(1))],
                                              progressBlock: nil,
                                              completionHandler: nil)
                        
                        self.thumbnail.toRounded(borderWidth: 1, borderColor: nil)
                    }
                }
            })
            
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "showProfileMenu" {
            (segue.destination as! ProfileMenuTableViewController).delegate = self
        }
    }
}
