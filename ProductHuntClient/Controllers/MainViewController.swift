//
//  MainViewController.swift
//  ProductHuntClient
//
//  Created by Алексей Россошанский on 27.11.17.
//  Copyright © 2017 Alexey Rossoshasky. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class MainViewController: UIViewController {
    
    //MARK: - Vars and Outlets
    var arrayOfUniqCategoriesToday = [String]()
    var choosenCategory = "tech"
    var arrayOfProducts = [ProductModel]()
    
    weak var childController : CategoriesViewController!
    
    var viewUnderCategoryView: UIView!
    
    var refreshControl = UIRefreshControl()
    
    //Flags
    var categoryPressed = false
    var firstTouch = true
    
    @IBOutlet weak var tableView: UITableView!
    
    
}


//MARK: - View Loads
extension MainViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addRefreshControl()
        addCategoryButton()
        
        self.childController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CategoriesVC") as! CategoriesViewController
        self.addChildViewController(self.childController)
        
        self.tableView.register(UINib(nibName: "MainCell", bundle: nil) , forCellReuseIdentifier: "MainCell")
        self.tableView.estimatedRowHeight = 150
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        getProducts()
        getCategories()
        
    }
    
    
}


//MARK: - Func to get all categories today
extension MainViewController {
    
    func getCategories() {
        FetchingData.fetchTodaysCategories { [weak self] (categories) in
            
            self?.childController.giveMainVC(vc: self!)
            self?.arrayOfUniqCategoriesToday.append(contentsOf: categories)
            self?.childController.giveCategoriesToCategoriesVC(categories: Array(categories))
            DispatchQueue.main.async {
                
                if (self?.firstTouch)! == false {
                    self?.childController.tableView.reloadData()
                }
            }
            
        }
    }
}


//MARK: - Func to get all products of today's in choosen category
extension MainViewController {
    
    @objc fileprivate func getProducts(){
        if arrayOfProducts.count == 0 {
            showWaitingView()
        }
        FetchingData.fetchProducts(category: self.choosenCategory) { (products) in
            self.arrayOfProducts.removeAll()
            self.arrayOfProducts.append(contentsOf: products)
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.hideWaitingView()
                self.refreshControl.endRefreshing()
            }
            
            
        }
    }
}


//MARK: - Funcs for category button pressed
extension MainViewController {
    func openCategoriesVC() {
        
        //Add View to blur effect under categoty View
        self.viewUnderCategoryView = UIView(frame: self.view.frame)
        self.viewUnderCategoryView.backgroundColor = UIColor.clear
        self.view.addSubview(self.viewUnderCategoryView)
        
        //Add category View
        self.childController.view.frame = CGRect(x: CGFloat(30), y: CGFloat(-700), width: UIScreen.main.bounds.width - CGFloat(30)*2, height: UIScreen.main.bounds.height - CGFloat(65)*2)
        self.view.addSubview(self.childController.view)
        
        UIView.animate(withDuration: 0.2) {
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
            self.childController.view.frame = CGRect(x: CGFloat(30), y: CGFloat((self.navigationController?.navigationBar.frame.height)!), width: UIScreen.main.bounds.width - CGFloat(30)*2, height: UIScreen.main.bounds.height - CGFloat((self.navigationController?.navigationBar.frame.height)!)*2)
            self.viewUnderCategoryView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            self.viewUnderCategoryView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        }
        self.categoryPressed = true
    }
    
    
    
    
    func closeCategoriesVC() {
        UIView.animate(withDuration: 0.5) {
            self.childController.view.frame = CGRect(x: CGFloat(30), y: CGFloat(-700), width: UIScreen.main.bounds.width - CGFloat(30)*2, height: UIScreen.main.bounds.height - CGFloat((self.navigationController?.navigationBar.frame.height)!)*2)
            self.viewUnderCategoryView.backgroundColor = UIColor.clear
            
        }
        //To delay removing of views
        let when = DispatchTime.now() + 0.55
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.childController.view.removeFromSuperview()
            self.viewUnderCategoryView.removeFromSuperview()
            
        }
        self.categoryPressed = false
        getProducts()
        addCategoryButton()
        showWaitingView()
        
    }
}

//MARK: - Table View Data Source and Delegate
extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell") as! MainCell
        cell.configureCell(product: self.arrayOfProducts[indexPath.row])
        return cell
    }
    
    //Go to Detail View
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        let destination = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        destination.product = arrayOfProducts[indexPath.row]
        navigationController?.pushViewController(destination, animated: true)
        
    }
    
    
}


//MARK: - Add refresh Control
extension MainViewController{
    func addRefreshControl(){
        refreshControl.addTarget(self, action: #selector(getProducts), for: .valueChanged)
        refreshControl.tintColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        refreshControl.attributedTitle = NSAttributedString(string: "Waiting")
        tableView.addSubview(refreshControl)
    }
}



//MARK: - Add categoryButton on navigation bar
extension MainViewController {
    func addCategoryButton(){
        
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        let label = UILabel()
        label.text = choosenCategory
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        label.font = label.font.withSize(25)
        label.sizeToFit()
        label.center = button.center
        label.textAlignment = NSTextAlignment.center
        button.showsTouchWhenHighlighted = true
        button.addSubview(label)
        button.addTarget(self, action: #selector(categoryButtonPressed), for: .touchUpInside)
        self.navigationItem.titleView = button
        
    }
}


//MARK: - Category button pressed
extension MainViewController {
    @objc func categoryButtonPressed() {
        
        if !categoryPressed {
            openCategoriesVC()
            firstTouch = false
        } else {
            closeCategoriesVC()
        }
    }
}


//MARK: - Activity View
extension MainViewController {
    func showWaitingView(){
        let alert = UIAlertController(title: nil, message: "Wait please...", preferredStyle: .alert)
        alert.view.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating()
        alert.view.addSubview(loadingIndicator)
        self.navigationController?.present(alert, animated: true, completion: nil)
    }
    
    
    
    func hideWaitingView(){
        self.dismiss(animated: true, completion: nil)
    }
    
}
