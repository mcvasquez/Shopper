//
//  ArticlesRouter.swift
//  shopper
//
//  Created by Daniel Cabrera on 3/13/18.
//  Copyright © 2018 Cuevas Cabrera. All rights reserved.
//

import Foundation
import UIKit
import Firebase

extension ArticlesViewController {
    // MARK: - Routers
    @objc func didSelectUserAccount() {
        FirebaseHelper.isAlreadySignIn { response, _ in
            if response {
                self.goingToPerformSegue("showProfile")
            } else {
                self.goingToPerformSegue("showSignIn")
            }
        }
    }
    
    @objc func didSelectCreateArticle() {
        FirebaseHelper.isAlreadySignIn { response, _ in
            if response {
                self.editableArticle = nil
                self.goingToPerformSegue("showArticleCreate")
            } else {
                self.present(yesNoAlert(title: "Información",
                                        message: "Debe iniciar sesión para crear artículos.",
                                        positiveText: "Iniciar Sesión", positiveAction: {
                                            self.goingToPerformSegue("showSignIn")
                                        },
                                        negativeText: "Cancelar",
                                        negativeAction: nil),
                             animated: true,
                             completion: nil)
                
            }
        }
    }
    
    func goingToPerformSegue(_ fromIdentifier : String) {
        self.performSegue(withIdentifier: fromIdentifier, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showArticleDetails" {
            if let row = tableView.indexPathForSelectedRow?.row {
                let aDetailVC = segue.destination as! ArticleDetailsViewController
                let mArticle = tableViewViewDataSource.snapshot(at: row)
                aDetailVC.aArticle = Articles.init(snapshot: mArticle)!
            }
        } else if segue.identifier == "showArticleCreate" {
            let manageArticleVC = segue.destination as! ManageArticleViewController
            manageArticleVC.editableArticle = self.editableArticle
        }
    }
}
