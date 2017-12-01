//
//  WebViewController.swift
//  ProductHuntClient
//
//  Created by Алексей Россошанский on 01.12.17.
//  Copyright © 2017 Alexey Rossoshasky. All rights reserved.
//

import UIKit
import SafariServices
class WebViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    var urlRef: URL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let safariView = SFSafariViewController(url: urlRef, entersReaderIfAvailable: true)
//        present(safariView, animated: true, completion: nil)
//        webView.loadRequest(URLRequest(url: urlRef))
    }

}
