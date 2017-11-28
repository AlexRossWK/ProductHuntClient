//
//  CategoryCell.swift
//  ProductHuntClient
//
//  Created by Алексей Россошанский on 28.11.17.
//  Copyright © 2017 Alexey Rossoshasky. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {


    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var viewInCell: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configureCell(category : String) {
        
        categoryLabel.text = category
        viewInCell.layer.cornerRadius = 5
        viewInCell.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        viewInCell.layer.shadowOpacity = 0.5
        viewInCell.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
}
