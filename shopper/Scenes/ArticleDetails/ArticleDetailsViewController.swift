//
//  ArticleDetailsViewController.swift
//  shopper
//
//  Created by Misael Cuevas Vásquez on 3/12/18.
//  Copyright © 2018 Cuevas Cabrera. All rights reserved.
//

import UIKit
import Kingfisher

class ArticleDetailsViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var condition: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var articleDescription: UITextView!
    var aArticle : Articles?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        onCreateArticleInformation()
    }
    
    func onCreateArticleInformation() {
        guard aArticle != nil else {
            debugPrint("Fail to retrieve article")
            return
        }
        articleTitle.text = aArticle?.title
        condition.text = String(describing: aArticle!.timestamp)
        price.text = "$\(String(aArticle!.price))"
        address.text = aArticle?.address
        articleDescription.text = aArticle?.description
        thumbnail.kf.setImage(with: URL(string: aArticle!.image),
                              placeholder: nil,
                              options: [.transition(.fade(1))],
                              progressBlock: nil,
                              completionHandler: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - Actions
    @IBAction func didContactButton(_ sender: Any) {
    }
}
