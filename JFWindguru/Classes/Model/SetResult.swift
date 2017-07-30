//
//  SetResult.swift
//  Xoshem-watch
//
//  Created by Javier Fuchs on 10/7/15.
//  Copyright © 2015 Fuchs. All rights reserved.
//

import Foundation
#if USE_EXT_FWK
    import ObjectMapper
    import RealmSwift
#endif

/*
 *  SetResult
 *
 *  Discussion:
 *    Model object representing the result of c_sets
 *
 * {
 *   "count": 1,
 *   "sets": {
 *      "229823": "My forecast"
 *    }
 *  }
 */


public class SetResult: Object, Mappable {

    // count: number of results obtained
    dynamic var count: Int = 0
    // spots: is a dictionary forecast id/ forecast name

#if USE_EXT_FWK
    typealias ListSetInfo    = List<SetInfo>
#else
    typealias ListSetInfo    = [SetInfo]
#endif

    var sets = ListSetInfo()
    

#if USE_EXT_FWK
    required convenience public init?(map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        count <- map["count"]
        var dict = [String: String]()
        dict <- map["sets"]
        for (k,v) in dict {
            let tmpDictionary = ["id": k, "name": v]
            if let setInfo = Mapper<SetInfo>().map(JSON: tmpDictionary) {
                sets.append(setInfo)
            }
        }            
    }

#else

    public required init(dictionary: [String: Any?]) {
        count = dictionary["count"] as? Int ?? 0
        if let dict = dictionary["sets"] as? [String: Any?] {
            for (k,v) in dict {
                let tmpDictionary = ["id": k, "name": v]
                let object = SetInfo.init(dictionary: tmpDictionary)
                sets.append(object)
            }
        }
    }

#endif


    override public var description : String {
        var aux : String = "\(type(of:self)): "
        aux += "\(count) sets, "
        for setInfo in sets {
            aux += "\(setInfo.description)\n"
        }
        return aux
    }

}
