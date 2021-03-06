//
//  ArticlesViewCell.swift
//  shopper
//
//  Created by Daniel Cabrera on 22/03/2018.
//  Copyright © 2018 Cuevas Cabrera. All rights reserved.
//

import UIKit

class ArticlesViewCell: UITableViewCell {

    @IBOutlet weak var articlesCellView: UIView!
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var price: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        weak var weakSelf = self
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut,
                       animations: {
                        weakSelf?.articlesCellView.frame.origin.x = -200
        }) { done in
            
            UIView.animate(withDuration: 0.3, delay: 0.2, options: .curveEaseInOut,
                           animations: {
                            weakSelf?.articlesCellView.frame.origin.x = 0
                            
            })
            
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func populateCellWithArticles(_ aArticle : Articles) {
        title.text = aArticle.title
        price.text = aArticle.price.toCurrency()
        thumbnail.kf.setImage(with: URL(string: aArticle.image),
                              placeholder: nil,
                              options: [.transition(.fade(1))],
                              progressBlock: nil,
                              completionHandler: nil)
        thumbnail.toRounded(borderWidth: 1, borderColor: nil)
    }
    
}
