//
//  ChangePasswordViewController.swift
//  shopper
//
//  Created by Misael Cuevas Vásquez on 3/17/18.
//  Copyright © 2018 Cuevas Cabrera. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController {

    @IBOutlet weak var currentPassword: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var confirmNewPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Actualizar contraseña"
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
    @IBAction func didForgotPassword(_ sender: Any) {
        self.performSegue(withIdentifier: "showForgotPassword", sender: nil)
    }
    
    @IBAction func didChangePassword(_ sender: Any) {
        guard !currentPassword.text!.isEmpty && !newPassword.text!.isEmpty && !confirmNewPassword.text!.isEmpty else {
            self.present(yesAlert(title: "Información",
                                  message: "Favor de completar todos los campos.",
                                  positiveText: "Ok",
                                  positiveAction: nil),
                         animated: true,
                         completion: nil)
            return
        }
        
        guard newPassword.text!.compare(confirmNewPassword.text!) == .orderedSame else {
            self.present(yesAlert(title: "Información",
                                  message: "La nueva contraseña no coincide.",
                                  positiveText: "Ok",
                                  positiveAction: nil),
                         animated: true,
                         completion: nil)
            return
        }
        
        guard newPassword.text!.count >= 6 else {
            self.present(yesAlert(title: "Información",
                                  message: "La nueva contraseña debe tener 6 caracteres de largo o más.",
                                  positiveText: "Ok",
                                  positiveAction: nil),
                         animated: true,
                         completion: nil)
            return
        }
        
        FirebaseHelper.updatePassword(currentPassword: currentPassword.text!, newPassword: newPassword.text!) { error in
            
            if error == nil {
                self.present(yesAlert(title: "Información",
                                      message: "Su contraseña se ha actualizado. Debe volver a iniciar sesión como medida de seguridad.",
                                      positiveText: "Ok",
                                      positiveAction: {
                                        self.navigationController?.popToRootViewController(animated: true)
                                      }),
                 animated: true,
                 completion: nil)
            } else {
                switch error! {
                case .UserNotFound:
                    self.present(yesAlert(title: "Información",
                                          message: "Contraseña actual incorrecta.",
                                          positiveText: "Ok",
                                          positiveAction: nil),
                                 animated: true,
                                 completion: nil)
                    break
                    
                case .Unknown:
                    self.present(yesAlert(title: "Información",
                                          message: "Ha habido un error actualizando su contraseña.",
                                          positiveText: "Ok",
                                          positiveAction: nil),
                                 animated: true,
                                 completion: nil)
                    break
                }
            }
        }
        
        /*
        Auth.auth().currentUser?.updatePassword(to: newPassword.text!) { error in
            if error == nil {
                self.present(yesAlert(title: "Información",
                                      message: "Su contraseña se ha actualizado. Debe volver a iniciar sesión como medida de seguridad.",
                                      positiveText: "Ok",
                                      positiveAction: {
                                        self.navigationController?.popToRootViewController(animated: true)
                                      }),
                    animated: true,
                    completion: nil)
         
            } else {
//                17014
                self.present(yesAlert(title: "Información",
                                      message: "Ha habido un error actualizando su contraseña.",
                                      positiveText: "Ok",
                                      positiveAction: nil),
                             animated: true,
                             completion: nil)
            }
        }
 */
    }
}
