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
        title = "Iniciar Sesión"
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
        if email.text!.isEmpty || password.text!.isEmpty {
            self.present(yesAlert(title: "Información",
                                  message: "Favor de completar todos los campos.",
                                  positiveText: "Ok",
                                  positiveAction: nil),
                         animated: true,
                         completion: nil)
        } else {
            FirebaseHelper.SignInFirebase(aEmail: email.text!, aPass: password.text!, completionHandler: { response, _ in
                if response {
                    self.navigationController?.popViewController(animated: true)
                }
            })
        }
    }
    
    @IBAction func didRegister(_ sender: Any) {
        self.performSegue(withIdentifier: "showSignUp", sender: nil)
    }
    
    @IBAction func didForgotPassword(_ sender: Any) {
    }
}
