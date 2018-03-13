//
//  ArticlesViewController.swift
//  shopper
//
//  Created by Misael Cuevas Vásquez on 3/12/18.
//  Copyright © 2018 Cuevas Cabrera. All rights reserved.
//

import UIKit
import FirebaseDatabaseUI
import FirebaseDatabase

class ArticlesViewController: UIViewController, UITableViewDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    var tableViewViewDataSource: FUITableViewDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Articulos"
        let userAccountItem = UIBarButtonItem(image: UIImage(named: "UserAccount"), style: .plain, target: self, action: #selector(didSelectUserAccount))
        let articleAccountItem = UIBarButtonItem(image: UIImage(named: "plus"), style: .plain, target: self, action: #selector(didSelectCreateArticle))
        self.navigationItem.rightBarButtonItem = userAccountItem
        self.navigationItem.leftBarButtonItem = articleAccountItem
        onCreateTableview()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        if #available(iOS 11.0, *) {
//            navigationController?.navigationBar.prefersLargeTitles = true
//            navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
//        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        if #available(iOS 11.0, *) {
//            navigationController?.navigationBar.prefersLargeTitles = false
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
