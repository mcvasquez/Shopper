//
//  EditableTableDataSource.swift
//  shopper
//
//  Created by Misael Cuevas Vásquez on 3/17/18.
//  Copyright © 2018 Cuevas Cabrera. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabaseUI

// README: - https://stackoverflow.com/a/41497218/3273221
class EditableTableDataSource: FUITableViewDataSource {
    
    /// Called to populate each cell in the UITableView.
    typealias PopulateCellBlock = (UITableView, IndexPath, DataSnapshot) -> UITableViewCell
    
    /// Called to commit an edit to the UITableView.
    typealias CommitEditBlock = (UITableView, UITableViewCellEditingStyle, IndexPath) -> Void
    typealias CommitCanEditBlock = (UITableView, IndexPath) -> Bool
    
    private let commitEditBlock: CommitEditBlock?
    private let commitCanEditBlock : CommitCanEditBlock?
    
    /// A wrapper around FUITableViewDataSource.init(query:view tableView:populateCell:), with the
    /// addition of a CommitEditBlock.
    public init(query: DatabaseQuery,
                populateCell: @escaping PopulateCellBlock,
                commitEdit: @escaping CommitEditBlock,
                commitCanEdit: @escaping CommitCanEditBlock)
    {
        commitEditBlock = commitEdit
        commitCanEditBlock = commitCanEdit
        super.init(collection: FUIArray.init(query: query), populateCell: populateCell)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if commitCanEditBlock != nil {
            return commitCanEditBlock!(tableView, indexPath)
        }
        return false
    }
    
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCellEditingStyle,
                            forRowAt indexPath: IndexPath)
    {
        if (commitEditBlock != nil) {
            commitEditBlock!(tableView, editingStyle, indexPath)
        }
    }
}
