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

    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var menuView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
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
                        
                        self.thumbnail.contentMode = .scaleAspectFit
                        self.thumbnail.layer.borderWidth = 1
                        self.thumbnail.layer.masksToBounds = false
                        self.thumbnail.layer.borderColor = UIColor.black.cgColor
                        self.thumbnail.layer.cornerRadius = self.thumbnail.frame.height/2
                        self.thumbnail.clipsToBounds = true
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
