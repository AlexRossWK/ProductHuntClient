//
//  ProductModel.swift
//  ProductHuntClient
//
//  Created by Алексей Россошанский on 27.11.17.
//  Copyright © 2017 Alexey Rossoshasky. All rights reserved.
//

import Foundation


class ProductModel {
    
    var name: String
    var description: String
    var upvotesAmount: Int
    var thumbnail: String
    var ref: String
    var screenshotUrl: String
    
    init(name: String, description: String, upvotesAmount: Int, thumbnail: String, ref: String, screenshotUrl: String) {
        self.name = name
        self.description = description
        self.upvotesAmount = upvotesAmount
        self.thumbnail = thumbnail
        self.ref = ref
        self.screenshotUrl = screenshotUrl
    }
}
