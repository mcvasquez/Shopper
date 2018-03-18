//
//  ArticlesInteractor.swift
//  shopper
//
//  Created by Daniel Cabrera on 3/13/18.
//  Copyright © 2018 Cuevas Cabrera. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabaseUI
import FirebaseDatabase

extension ArticlesViewController {
    
    func onCreateTableview() {
        
        tableViewViewDataSource = self.tableView.bind(to: FirebaseHelper.articlesQuery(),
                                                      populateCell: populateCellBlock(),
                                                      commitEdit: commitEditBlock(),
                                                      commitCanEdit: commitCanEditBlock())
    }
    
    // MARK: TableView Data Source
    func populateCellBlock() -> EditableTableDataSource.PopulateCellBlock {
        return { tableView, indexPath, snapshot in
            let cell = tableView.dequeueReusableCell(withIdentifier: "articlesCell")
                as! ArticlesTableViewCell
            if let aArticle = Articles.init(snapshot: snapshot) {
                cell.populateCellWithArticles(aArticle)
            }
            return cell
        }
    }
    
    func commitEditBlock() -> EditableTableDataSource.CommitEditBlock {
        return { tableView, editingStyle, indexPath in
            if (editingStyle != .delete) {
                return
            }
        }
    }
    
    func commitCanEditBlock() -> EditableTableDataSource.CommitCanEditBlock {
        return { tableView, IndexPath in
            let snapshot = self.tableViewViewDataSource.snapshot(at: IndexPath.row)
            
            if let article = Articles(snapshot: snapshot), article.user?.compare(Auth.auth().currentUser?.uid ?? "") == .orderedSame {
                return true
            }
            
            return false
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goingToPerformSegue("showArticleDetails")
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let snapshot = self.tableViewViewDataSource.snapshot(at: indexPath.row)
        let article  = Articles(snapshot: snapshot)
        
        var rowActions: [UITableViewRowAction] = []
        let delete = UITableViewRowAction(style: .destructive, title: "Eliminar") { action, indexPath in
            guard article != nil else { return }
            FirebaseHelper.removeArticle(id: article!.id, completion: { error in
                if error != nil {
                    self.present(yesAlert(title: "Información",
                                          message: "Hubo un error eliminando el artículo. Favor intentar más tarde.",
                                          positiveText: "OK",
                                          positiveAction: nil),
                                 animated: true,
                                 completion: nil)
                    
                }
            })
        }
        rowActions.append(delete)
        
        let edit = UITableViewRowAction(style: .normal, title: "Editar", handler: { action, indexPath in
            guard article != nil else { return }
            self.editableArticle = article
            self.goingToPerformSegue("showArticleCreate")
        })
        edit.backgroundColor = UIColor(red:0.96, green:0.79, blue:0.22, alpha:1.0)
        rowActions.append(edit)
        
        return rowActions
    }
}
