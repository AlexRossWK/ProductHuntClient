//
//  MainCell.swift
//  ProductHuntClient
//
//  Created by Алексей Россошанский on 28.11.17.
//  Copyright © 2017 Alexey Rossoshasky. All rights reserved.
//

import UIKit
import Kingfisher
import SDWebImage

class MainCell: UITableViewCell {

    @IBOutlet weak var imageOfProduct: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var upvotesLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(product : ProductModel) {
        //GIF
        let image = UIImage(named: "default_profile_icon")
        imageOfProduct.kf.indicatorType = .activity
        imageOfProduct.kf.setImage(with: URL(string: product.thumbnail))
        //IMAGE
        //imageOfProduct.sd_setImage(with: URL(string: product.thumbnail), placeholderImage: nil)
        nameLabel.text = product.name
        descriptionLabel.text = product.description
        upvotesLabel.text = "✔︎\(product.upvotesAmount)"
    }

}
