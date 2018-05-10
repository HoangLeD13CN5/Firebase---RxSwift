//
//  DictionaryKeyTransform.swift
//  FirebaseExample
//
//  Created by LEMINHO on 5/10/18.
//  Copyright © 2018 LEMINHO. All rights reserved.
//

import Foundation
import ObjectMapper

class DictionaryKeyTransform: TransformType {
    typealias Object = [String]
    typealias JSON = [String: Bool]
    
    func transformFromJSON(_ value: Any?) -> [String]? {
        guard let v = value as? JSON else { return [String]() }
        return Array(v.keys)
    }
    
    func transformToJSON(_ value: [String]?) -> [String : Bool]? {
        return value?.reduce([String: Bool](), { (result, string) -> [String: Bool] in
            var dict = result
            dict[string] = true
            return dict
        })
    }
}
