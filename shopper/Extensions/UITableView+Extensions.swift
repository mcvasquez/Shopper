//
//  UITableView+Extensions.swift
//  shopper
//
//  Created by Misael Cuevas Vásquez on 3/17/18.
//  Copyright © 2018 Cuevas Cabrera. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabaseUI

extension UITableView {
    
    /// Creates a data source, binds it to the table view, and returns it. Note that this is the
    /// `EditableTableViewDataSource` equivalent of the
    /// `FUITableViewDataSource.bind(to:populateCell:)` method.
    ///
    /// - parameters:
    ///   - to:             The Firebase query to bind to.
    ///   - populateCell:   A closure that's called to populate each cell.
    ///   - commitEdit:     A closure that's called when the user commits some kind of edit. Maps to
    ///                     `tableView(:commit:forRowAt:)`.
    func bind(to query: DatabaseQuery,
              populateCell: @escaping EditableTableDataSource.PopulateCellBlock,
              commitEdit: @escaping EditableTableDataSource.CommitEditBlock,
              commitCanEdit: @escaping EditableTableDataSource.CommitCanEditBlock)
        -> EditableTableDataSource
    {
        let dataSource = EditableTableDataSource(query: query,
                                                 populateCell: populateCell,
                                                 commitEdit: commitEdit,
                                                 commitCanEdit: commitCanEdit)
        dataSource.bind(to: self)
        return dataSource
    }
}
