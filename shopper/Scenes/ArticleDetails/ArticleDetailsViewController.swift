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

    @IBOutlet weak var stackView: UIStackView!
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
        thumbnail.alpha = 0.0
        stackView.alpha = 0.0
        onCreateArticleInformation()
    }
    
    func onCreateArticleInformation() {
        guard aArticle != nil else {
            debugPrint("Fail to retrieve article")
            return
        }
        
        let df = DateFormatter()
        df.dateFormat = "dd/MM/yyyy"
        
        articleTitle.text = aArticle?.title
        condition.text = df.string(from: aArticle!.timestamp)
        price.text = aArticle!.price.toCurrency()
        address.text = aArticle?.address
        articleDescription.text = aArticle?.description
        thumbnail.kf.setImage(with: URL(string: aArticle!.image),
                              placeholder: nil,
                              options: [.transition(.fade(1))],
                              progressBlock: nil,
                              completionHandler: nil)
        onCreateAnimation()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onCreateAnimation() {
        weak var weakSelf = self
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut,
                       animations: {
                        weakSelf?.thumbnail.alpha = 0.0
                        weakSelf?.stackView.alpha = 0.0
        }) { done in
            
            UIView.animate(withDuration: 0.3, delay: 0.2, options: .curveEaseInOut,
                           animations: {
                            weakSelf?.thumbnail.alpha = 1.0
                            weakSelf?.stackView.alpha = 1.0
                            
            })
        }
    }
    // MARK: - Actions
    @IBAction func didContactButton(_ sender: Any) {
    }
}
