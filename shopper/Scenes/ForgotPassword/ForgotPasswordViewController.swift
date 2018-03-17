//
//  ForgotPasswordViewController.swift
//  shopper
//
//  Created by Misael Cuevas Vásquez on 3/13/18.
//  Copyright © 2018 Cuevas Cabrera. All rights reserved.
//

import UIKit
import Firebase

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Recuperar cuenta"
        
        if let user = Auth.auth().currentUser {
            email.text = user.email
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

    // MARK: - Actions
    @IBAction func didRecoverAccount(_ sender: Any) {
        if email.text!.isEmpty {
            self.present(yesAlert(title: "Información", message: "Debe especificar un email.", positiveText: "Ok", positiveAction: nil), animated: true, completion: nil)
            return
        }
        
        if !isValidEmail(testStr: email.text!) {
            self.present(yesAlert(title: "Información", message: "Email inválido.", positiveText: "Ok", positiveAction: nil), animated: true, completion: nil)
            return
        }
        
        Auth.auth().sendPasswordReset(withEmail: email.text!) { error in
            if error == nil {
                self.present(yesAlert(title: "Información", message: "Se ha enviado las instrucciones a su email para recuperar su cuenta.", positiveText: "Ok", positiveAction: {
                    self.navigationController?.popToRootViewController(animated: true)
                }), animated: true, completion: nil)
            } else {
                self.present(yesAlert(title: "Información", message: "No hay registro de usuario correspondiente a este email. El usuario puede haber sido eliminado.", positiveText: "Ok", positiveAction: nil), animated: true, completion: nil)
            }
        }
    }
}
