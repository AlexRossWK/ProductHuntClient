//
//  CategoriesViewController.swift
//  ProductHuntClient
//
//  Created by Алексей Россошанский on 28.11.17.
//  Copyright © 2017 Alexey Rossoshasky. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var categories = [String]()
    weak var mainController : MainViewController!
}



//MARK: - View Loads
extension CategoriesViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}


//MARK: - Table View Data Source and Delegate
extension CategoriesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        cell.configureCell(category: categories[indexPath.row])
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCategory = categories[indexPath.row]
        mainController.choosenCategory = selectedCategory
        mainController.closeCategoriesVC()
    }
}




//MARK: Func to get categories
extension CategoriesViewController {
    func giveCategoriesToCategoriesVC(categories: [String]) {
    self.categories = categories
    }
}

//MARK: Func to get MainVC here
extension CategoriesViewController {
    func giveMainVC(vc: MainViewController) {
        self.mainController = vc
        
    }
}

