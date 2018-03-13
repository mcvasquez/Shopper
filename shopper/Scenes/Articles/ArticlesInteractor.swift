//
//  ArticlesInteractor.swift
//  shopper
//
//  Created by Daniel Cabrera on 3/13/18.
//  Copyright © 2018 Cuevas Cabrera. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabaseUI
import FirebaseDatabase
extension ArticlesViewController {
    
    func onCreateTableview() {
        tableViewViewDataSource = self.tableView.bind(to: FirebaseHelper.articlesQuery(), populateCell: { (tableView, indexPath, aSnapshot) -> UITableViewCell in
            let cell = tableView.dequeueReusableCell(withIdentifier: "articlesCell")
                as! ArticlesTableViewCell
            if let aArticle = Articles.init(snapshot: aSnapshot) {
                cell.populateCellWithArticles(aArticle)
            }
            return cell
        })
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goingToPerformSegue("showArticleDetails")
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
