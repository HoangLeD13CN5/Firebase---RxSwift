//
//  Post.swift
//  FirebaseExample
//
//  Created by LEMINHO on 5/10/18.
//  Copyright © 2018 LEMINHO. All rights reserved.
//

import Foundation
import ObjectMapper

class Post: Mappable {
    var postId: String?
    var content: String?
    
    func mapping(map: Map) {
        postId <- map[Post.firebaseIdKey]
        content <- map["content"]
    }
    required init?(map: Map) { }
}
