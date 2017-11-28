//
//  DetailCell.swift
//  ProductHuntClient
//
//  Created by Алексей Россошанский on 28.11.17.
//  Copyright © 2017 Alexey Rossoshasky. All rights reserved.
//

import UIKit

class DetailCell: UITableViewCell {

    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var upvotesLabel: UILabel!
    
    
    @IBAction func getItPressed(_ sender: UIButton) {
        
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }



}
