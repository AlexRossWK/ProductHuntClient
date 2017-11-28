//
//  APIWrapper.swift
//  ProductHuntClient
//
//  Created by Алексей Россошанский on 27.11.17.
//  Copyright © 2017 Alexey Rossoshasky. All rights reserved.
//

import Foundation

class APIWrapper {
    
    static func getProductsList(success1 : @escaping (_ json : Any) -> Void, failure : @escaping (_ errorDescription : String) -> Void) -> URLSessionDataTask {
        
        //Params of URL
        let url = "https://api.producthunt.com/v1/categories/topic-4/posts"
        let params : [String: Any] = ["days_ago" : "1",
                                      "day" : "2017-07-04"]
        
        
        let request = APIConfigurator.createRequest(withURL: url, andParams: params)
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            APIConfigurator.generalCompletionHandler(withData: data, withError: error, success: success1, failure: failure)
        }
        dataTask.resume()
        return dataTask
    }
    
    

    
}
