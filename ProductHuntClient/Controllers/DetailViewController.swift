//
//  DetailViewController.swift
//  ProductHuntClient
//
//  Created by Алексей Россошанский on 28.11.17.
//  Copyright © 2017 Alexey Rossoshasky. All rights reserved.
//

import UIKit
import Kingfisher
import SafariServices


class DetailViewController: UIViewController {
    
    
    let upvotesLabel = UILabel()
    let descrtiptionLabel = UILabel()
    let nameLabel = UILabel()
    let gitItButton = UIButton()
    //for animation
    let imageView = UIImageView()
    let backgroundView = UIView()
    let navBarView = UIView()
    var startImageFrame = CGRect()
    var zoomImage = UIImageView()
    
    var gradientLayer = CAGradientLayer()
    
    var product: ProductModel!
    
    var navigationBarHeight = CGFloat(64)
    
    
    
    
}


//MARK: - View Loads
extension DetailViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        addGradient()
        generateImage()
        generateLabelsAndButton()
        
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

    func generateLabelsAndButton() {
        

        //Labels
        upvotesLabel.frame = CGRect(x: 0, y: navigationBarHeight + imageView.frame.height, width: 70, height: 30)
        upvotesLabel.layer.cornerRadius = 10
        upvotesLabel.layer.masksToBounds = true
        upvotesLabel.text = "✔︎\(product.upvotesAmount)"
        upvotesLabel.textAlignment = .center
        upvotesLabel.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1).withAlphaComponent(0.2)
        upvotesLabel.layer.borderColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
        upvotesLabel.layer.borderWidth = 0.7

        view.addSubview(upvotesLabel)
        
        nameLabel.frame = CGRect(x: upvotesLabel.frame.width+2, y: navigationBarHeight + imageView.frame.height + 2, width: view.frame.width - 2*(upvotesLabel.frame.width+2), height: 60)
        nameLabel.text = product.name
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.systemFont(ofSize: 21, weight: UIFont.Weight.bold)
        nameLabel.numberOfLines = 0
        nameLabel.layer.cornerRadius = 10
        nameLabel.layer.masksToBounds = true
        nameLabel.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1).withAlphaComponent(0.2)
        nameLabel.layer.borderColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
        nameLabel.layer.borderWidth = 0.7
        view.addSubview(nameLabel)
        
        descrtiptionLabel.frame = CGRect(x: 30, y: navigationBarHeight + imageView.frame.height + nameLabel.frame.height + 4, width: view.frame.width - 60, height: 130)
        descrtiptionLabel.text = product.description
        descrtiptionLabel.numberOfLines = 0
        descrtiptionLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.regular)
        descrtiptionLabel.layer.cornerRadius = 10
        descrtiptionLabel.layer.masksToBounds = true
        descrtiptionLabel.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1).withAlphaComponent(0.2)
        descrtiptionLabel.layer.borderColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
        descrtiptionLabel.layer.borderWidth = 0.7
        view.addSubview(descrtiptionLabel)
        //Button
        gitItButton.frame = CGRect(x: view.frame.width/2 - 90/2, y: navigationBarHeight + imageView.frame.height + nameLabel.frame.height + descrtiptionLabel.frame.height + 10, width: 90, height: 50)
        gitItButton.layer.cornerRadius = 10
        gitItButton.layer.masksToBounds = true
        gitItButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).withAlphaComponent(0.2)
        gitItButton.layer.borderColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
        gitItButton.layer.borderWidth = 0.7
        gitItButton.setTitle("Get it", for: .normal)
        gitItButton.setTitleColor(UIColor.black, for: .normal)
        gitItButton.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.bold)
        gitItButton.showsTouchWhenHighlighted = true
        
        gitItButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(getItPressed)))
        
        view.addSubview(gitItButton)
    }
    
    func addGradient(){
        //add Gradient
        configGradientLayer(gradientLayer)
        gradientLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func generateImage() {
        
        //activity View
        
        let ai = UIActivityIndicatorView(frame: CGRect(x: 0, y: 64, width: UIScreen.main.bounds.width, height: self.view.frame.height/2.4))
        view.addSubview(ai)
        ai.startAnimating()
        //image view
        imageView.frame = CGRect(x: 0, y: 64, width: self.view.frame.width, height: self.view.frame.height/2.4)
        self.startImageFrame = self.imageView.frame
        self.view.addSubview(imageView)
        
        imageView.kf.setImage(with: URL(string: product.screenshotUrl), placeholder: nil, options: nil, progressBlock: nil) { (image, error, _, _) in
            ai.stopAnimating()
            ai.removeFromSuperview()
        }
        zoomImage = imageView
        
      addGestureRecognezerToImage()
    }
    
}


//MARK: Image zooming Animation (CoreAnimation)

extension DetailViewController {
    
    func addGestureRecognezerToImage() {
        self.imageView.isUserInteractionEnabled = true
        self.imageView.clipsToBounds = true
        self.imageView.contentMode = .scaleAspectFill
        self.imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animateFirstTap)))
    }
    
    @objc func animateFirstTap() {
        
        backgroundView.frame = self.view.frame
        backgroundView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        backgroundView.alpha = 0
        view.addSubview(backgroundView)
        
        navBarView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: navigationBarHeight)
        navBarView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        navBarView.alpha = 0
        UIApplication.shared.keyWindow?.addSubview(navBarView)
        
        zoomImage.frame = imageView.frame
        view.addSubview(zoomImage)
        
        
        zoomImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animateSecondTap)))
        
        
        UIView.animate(withDuration: 0.8) {
            let height = (self.view.frame.width / self.startImageFrame.width) * self.startImageFrame.height
            let y = self.view.frame.height/2 - height/2
            self.zoomImage.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: height)
            self.backgroundView.alpha = 1
            self.navBarView.alpha = 1
            
        }
    }
    
    @objc func animateSecondTap() {
        UIView.animate(withDuration: 0.8, animations: {
            self.zoomImage.frame = self.startImageFrame
            self.backgroundView.alpha = 0
            self.navBarView.alpha = 0
        }) { (completed) in
            self.backgroundView.removeFromSuperview()
            self.zoomImage.removeFromSuperview()
            self.generateImage()
            self.navBarView.removeFromSuperview()
        }
    }
    
}

//MARK: - Go by reference (delegate for dismissing safariView)
extension DetailViewController: SFSafariViewControllerDelegate {
    @objc func getItPressed(_ sender: UIButton) {
        let safariView = SFSafariViewController(url: URL(string: product.ref)!, entersReaderIfAvailable: true)
        safariView.delegate = self
        present(safariView, animated: true, completion: nil)
    }
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}

