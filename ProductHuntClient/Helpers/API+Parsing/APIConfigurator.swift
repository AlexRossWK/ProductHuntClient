//
//  APIConfigurator.swift
//  ProductHuntClient
//
//  Created by Алексей Россошанский on 27.11.17.
//  Copyright © 2017 Alexey Rossoshasky. All rights reserved.
//

import Foundation

//Configure Url
class APIConfigurator {
    
    static func createRequest(withURL url_ : String, andParams params : [String: Any]) -> URLRequest {
        
        var url = url_ + "?"
        for (key, value) in params {
            url += key + "=" + "\(value)" + "&"
        }
        url = String(url.characters.dropLast())
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        return request
    }
    
//Completion Handler
    static func generalCompletionHandler (withData data : Data?, withError requestError : Error?, success : (_ json : Any) -> Void, failure : (_ errorDescription : String) -> Void) {
        
        if let error = requestError {
            switch error._code {
            case NSURLErrorTimedOut: failure("timeout")
            case NSURLErrorBadURL: failure("bad URL")
            //...
            default: failure("anotherError")
            }
            return
        }
        
        guard let data = data else { failure("data is nil"); return }
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            success(json)
        } catch {
            failure("serialisation error")
            return
        }
    }
}

