//
//  FetchingData.swift
//  ProductHuntClient
//
//  Created by Алексей Россошанский on 27.11.17.
//  Copyright © 2017 Alexey Rossoshasky. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON



class FetchingData {
    
    
    static func fetchProducts(category: String, success: @escaping (_ products: [ProductModel] ) -> Void) {
        Alamofire.request(
            URL(string: "https://api.producthunt.com/v1/categories/\(category)/posts")!,
            method: .get,
            parameters: ["days_ago": "0",
                         "day": DateSingleton.shared.chosenDate],
            headers: ["Accept": "application/json",
                      "Content-Type": "application/json",
                      "Authorization": "Bearer 591f99547f569b05ba7d8777e2e0824eea16c440292cce1f8dfb3952cc9937ff",
                      "Host": "api.producthunt.com"])
            .validate(statusCode: 200..<600)
            .responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    
                    var productsInCategory = [ProductModel]()
                    
                    for product in json["posts"].arrayValue{
                        let name = product["name"].stringValue
                        let description = product["tagline"].stringValue
                        let upvotesAmount = product["votes_count"].intValue
                        let thumbnail = product["thumbnail"]["image_url"].stringValue
                        let ref = product["redirect_url"].stringValue
                        let screenshotUrl = product["screenshot_url"]["850px"].stringValue
                        let newProduct = ProductModel(name: name, description: description, upvotesAmount: upvotesAmount, thumbnail: thumbnail, ref: ref, screenshotUrl: screenshotUrl)
                        productsInCategory.append(newProduct)
                    }
                    success(productsInCategory)
  
                case .failure(let error):
                    print(error)
                    
                }
        }
    }
    
    
    static func fetchTodaysCategories(success: @escaping (_ categories: Set<String> ) -> Void) {
        Alamofire.request(
            URL(string: "https://api.producthunt.com/v1/posts/all")!,
            method: .get,
            headers: ["Accept": "application/json",
                      "Content-Type": "application/json",
                      "Authorization": "Bearer 591f99547f569b05ba7d8777e2e0824eea16c440292cce1f8dfb3952cc9937ff",
                      "Host": "api.producthunt.com"])
            .validate(statusCode: 200..<600)
            .responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    
                    var AllCategoriesToday = [String]()
                    
                    for each in json["posts"].arrayValue {
                        
                        for topic in each["topics"].arrayValue {
                            let newTopic = topic["slug"].stringValue
                            AllCategoriesToday.append(newTopic)
                        }
                        
                    }
                    
                    success(Set(AllCategoriesToday))
                    
                case .failure(let error):
                    print(error)
                    
                }
        }
        
    }
}
