//
//  DetailViewController.swift
//  ProductHuntClient
//
//  Created by Алексей Россошанский on 28.11.17.
//  Copyright © 2017 Alexey Rossoshasky. All rights reserved.
//

import UIKit
import Kingfisher


class DetailViewController: UIViewController {


    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var upvotesLabel: UILabel!
    @IBOutlet weak var descrtiptionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var gitItButton: UIButton!
    
    var gradientLayer = CAGradientLayer()
    
    var product: ProductModel!
    
    
}


//MARK: - View Loads
extension DetailViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
     generateDetailVC()
    }
}

//MARK: - Go by reference
extension DetailViewController {
    @IBAction func getItPressed(_ sender: UIButton) {
        UIApplication.shared.openURL(URL(string: product.ref)!)
    }
}


//MARK: - Gradient
extension DetailViewController {
    
     func configGradientLayer(_ gradientLayer: CAGradientLayer){
        
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0)
        
        let startColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1).cgColor
        let middleColor = #colorLiteral(red: 0.4033790827, green: 0.6433452964, blue: 0.2546537817, alpha: 1).cgColor
        let endColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1).cgColor
        gradientLayer.colors = [startColor, middleColor, endColor]
    }
}



//MARK: - VCFormatter
extension DetailViewController {
    func generateDetailVC() {
        //fctivity View
        view.layer.insertSublayer(gradientLayer, at: 0)
        let ai = UIActivityIndicatorView(frame: CGRect(x: 0, y: 64, width: 310, height: 285))
        view.addSubview(ai)
        ai.startAnimating()
        //add Gradient
        configGradientLayer(gradientLayer)
        gradientLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        //fill Outlets
        imageView.kf.setImage(with: URL(string: product.screenshotUrl), placeholder: nil, options: nil, progressBlock: nil) { (image, error, _, _) in
            ai.stopAnimating()
            ai.removeFromSuperview()
        }
        upvotesLabel.layer.cornerRadius = 10
        upvotesLabel.layer.masksToBounds = true
        upvotesLabel.text = "✔︎\(product.upvotesAmount)"
        descrtiptionLabel.text = product.description
        nameLabel.text = product.name
        gitItButton.layer.cornerRadius = 10
        gitItButton.layer.masksToBounds = true
        gitItButton.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1).withAlphaComponent(0.2)
        gitItButton.layer.borderColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
        gitItButton.layer.borderWidth = 0.7
    }
}
