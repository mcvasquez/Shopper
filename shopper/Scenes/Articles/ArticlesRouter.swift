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
        }
    }
}
