//
//  SignInViewController.swift
//  shopper
//
//  Created by Daniel Cabrera on 3/6/18.
//  Copyright © 2018 Cuevas Cabrera. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

    // MARK: - Actions
    @IBAction func didSignIn(_ sender: Any) {
    }
    
    @IBAction func didRegister(_ sender: Any) {
    }
    
    @IBAction func didForgotPassword(_ sender: Any) {
    }
}
