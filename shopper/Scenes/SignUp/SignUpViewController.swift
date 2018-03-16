//
//  SignUpViewController.swift
//  shopper
//
//  Created by Misael Cuevas Vásquez on 3/12/18.
//  Copyright © 2018 Cuevas Cabrera. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Crear cuenta"
        imagePicker.delegate = self
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
    @IBAction func didAddProfileImage(_ sender: Any) {
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func didSignUp(_ sender: Any) {
        if email.text!.isEmpty || password.text!.isEmpty || name.text!.isEmpty || confirmPassword.text!.isEmpty || thumbnail.image == nil {
            self.present(yesAlert(title: "Información",
                                  message: "Favor de completar todos los campos.",
                                  positiveText: "Ok",
                                  positiveAction: nil),
                         animated: true,
                         completion: nil)
            return
        }
        
        if !isValidEmail(testStr: email.text!) {
            self.present(yesAlert(title: "Información", message: "Email inválido.", positiveText: "Ok", positiveAction: nil), animated: true, completion: nil)
            return
        }
        
        if password.text!.compare(confirmPassword.text!) != .orderedSame {
            self.present(yesAlert(title: "Información",
                                  message: "Las contraseñas no son iguales.",
                                  positiveText: "Ok",
                                  positiveAction: nil),
                         animated: true,
                         completion: nil)
            return
        }
        
        if password.text!.count < 6 {
            self.present(yesAlert(title: "Información",
                                  message: "La contraseña debe tener 6 caracteres de largo o más.",
                                  positiveText: "Ok",
                                  positiveAction: nil),
                         animated: true,
                         completion: nil)
            return
        }
        
        FirebaseHelper.CreateFirebaseUser(aEmail: email.text!, aPass: password.text!) { response, _ in
            if response {
                FirebaseHelper.setUserData(name: self.name.text!, thumbnail: self.thumbnail.image!, completion: { response, _ in
                })
                self.navigationController?.popViewController(animated: true)
            } else {
                self.present(yesAlert(title: "Información",
                                      message: "Ha habido un error creando su cuenta.",
                                      positiveText: "Ok",
                                      positiveAction: nil),
                             animated: true,
                             completion: nil)
            }
        }
    }
}
