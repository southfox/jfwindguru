//
//  Countries.swift
//  Pods
//
//  Created by javierfuchs on 7/16/17.
//
//

import Foundation
import ObjectMapper

/*
 *  Countries
 *
 *  Discussion:
 *    Model object representing the base class of Countries.
 *
 * {
 * "32": "Argentina",
 * "68": "Bolivia",
 * "76": "Brazil",
 * "152": "Chile",
 * "170": "Colombia",
 * "218": "Ecuador",
 * "254": "French Guiana",
 * "600": "Paraguay",
 * "604": "Peru",
 * "858": "Uruguay",
 * "862": "Venezuela"
 * }
 */

public class Countries: Mappable {
    
    public var countries = [Country]()
    
    required public init?(map: Map){
    }
    
    public func mapping(map: Map) {
        for json in map.JSON {
            let jsonKV = ["id": json.key, "name": json.value]
            if let country = Mapper<Country>().map(JSON: jsonKV) {
                countries.append(country)
            }
        }
    }
    public var description : String {
        var aux : String = ""
        for country in countries {
            aux += "\(country.description)\n"
        }
        aux += "\n"
        return aux
    }
    
}

