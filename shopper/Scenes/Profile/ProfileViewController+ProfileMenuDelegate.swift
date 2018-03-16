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
                break
            case 1: // Mis pedidos
                break
            default:
                break
            }
        } else if indexPath.section == 1 { // CONFIGURACIÓN
            switch indexPath.row {
            case 0: // Editar mi perfil
                break
            case 1: // Actualizar contraseña
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
