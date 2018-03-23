//
//  ProfileViewController+ProfileMenuDelegate.swift
//  shopper
//
//  Created by Misael Cuevas Vásquez on 3/16/18.
//  Copyright © 2018 Cuevas Cabrera. All rights reserved.
//

import Foundation

extension ProfileViewController : ProfileMenuDelegate {
    func didProfileMenuSelectRowAt(indexPath: IndexPath) {
        if indexPath.section == 0 { // GENERAL
            switch indexPath.row {
            case 0: // Mis articulos
                self.performSegue(withIdentifier: "myArticle", sender: nil)
                break
            case 1: // Mis pedidos
                break
            default:
                break
            }
        } else if indexPath.section == 1 { // CONFIGURACIÓN
            switch indexPath.row {
            case 0: // Editar mi perfil
                self.performSegue(withIdentifier: "showSignUp", sender: nil)
                break
            case 1: // Actualizar contraseña
                self.performSegue(withIdentifier: "showChangePassword", sender: nil)
                break
            case 2: // Cerrar sesión
                FirebaseHelper.SignOut(completionHandler: { response, _ in
                    if response {
                        self.navigationController?.popViewController(animated: true)
                    } else {
                        self.present(yesAlert(title: "Información", message: "Ha habido un error cerrando sesión", positiveText: "Ok", positiveAction: nil), animated: true, completion: nil)
                    }
                })
                break
            default:
                break
            }
        }
    }
}
