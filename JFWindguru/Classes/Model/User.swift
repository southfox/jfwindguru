//
//  User.swift
//  Pods
//
//  Created by javierfuchs on 7/11/17.
//
//

import Foundation

/*
 *  User
 *
 *  Discussion:
 *    Represents a model information of the weather data inside the model id
 *    At this moment public models are all "3"
 *    The information contained is of type Forecast (only one object)
 *
 *  {
 *      "id_user": 0,
 *      "username": "",
 *      "id_country": 0,
 *      "wind_units": "knots",
 *      "temp_units": "c",
 *      "wave_units": "m",
 *      "pro": 0,
 *      "no_ads": 0,
 *      "view_hours_from": 3,
 *      "view_hours_to": 22,
 *      "temp_limit": 10,
 *      "wind_rating_limits": [ 10.63, 15.57, 19.41 ],
 *      "colors": {
 *          "wind": [
 *              [ 0, 255, 255, 255 ],
 *              [ 5, 255, 255, 255 ],
 *              [ 8.9, 103, 247, 241 ],
 *              [ 13.5, 0, 255, 0 ],
 *              [ 18.8, 255, 240, 0 ],
 *              [ 24.7, 255, 50, 44 ],
 *              [ 31.7, 255, 10, 200 ],
 *              [ 38, 255, 0, 255 ],
 *              [ 45, 150, 50, 255 ],
 *              [ 60, 60, 60, 255 ],
 *              [ 70, 0, 0, 255 ]
 *          ],
 *          "temp": [
 *              [-25, 80, 255, 220 ],
 *              [-15, 171, 190, 255 ],
 *              [ 0, 255, 255, 255 ],
 *              [ 10, 255, 255, 100 ],
 *              [ 20, 255, 170, 0 ],
 *              [ 30, 255, 50, 50 ],
 *              [ 35, 255, 0, 110 ],
 *              [ 40, 255, 0, 160 ],
 *              [ 50, 255, 80, 220 ]
 *          ],
 *          "cloud": [
 *              [ 0, 255, 255, 255 ],
 *              [ 100, 120, 120, 120 ]
 *          ],
 *          "precip": [
 *              [ 0, 255, 255, 255 ],
 *              [ 9, 115, 115, 255 ],
 *              [ 30, 115, 115, 255 ]
 *          ],
 *          "precip1": [
 *              [ 0, 255, 255, 255 ],
 *              [ 3, 115, 115, 255 ],
 *              [ 10, 115, 115, 255 ]
 *          ],
 *          "press": [
 *              [ 900, 80, 255, 220 ],
 *              [ 1000, 255, 255, 255 ],
 *              [ 1070, 115, 115, 255 ]
 *          ],
 *          "rh": [
 *              [ 0, 171, 190, 255 ],
 *              [ 50, 255, 255, 255 ],
 *              [ 100, 255, 255, 0 ]
 *          ],
 *          "htsgw": [
 *              [ 0, 255, 255, 255 ], 
 *              [ 0.3, 255, 255, 255 ], 
 *              [ 4, 120, 120, 255 ], 
 *              [ 10, 255, 80, 100 ], 
 *              [ 15, 255, 200, 100 ]
 *          ],
 *          "perpw": [
 *              [ 0, 255, 255, 255 ],
 *              [ 10, 255, 255, 255],
 *              [ 20, 252, 81, 81]
 *          ]
 *      }
 *  }
 *
 */


public class User: Object, Mappable {
    
    typealias ListColor   = [Color]

    var id_user : Int = 0
    var username: String?
    var id_country : Int = 0
    var wind_units: String?
    var temp_units: String?
    var wave_units: String?
    var pro : Int = 0
    var no_ads : Int = 0
    var view_hours_from : Int = 0
    var view_hours_to : Int = 0
    var temp_limit : Int = 0
    var wind_rating_limits = [Float]()
    var colors_wind = ListColor()
    var colors_temp = ListColor()
    var colors_cloud = ListColor()
    var colors_precip = ListColor()
    var colors_precip1 = ListColor()
    var colors_press = ListColor()
    var colors_rh = ListColor()
    var colors_htsgw = ListColor()
    var colors_perpw = ListColor()

    required public convenience init(map: [String:Any]) {
        self.init()
        mapping(map: map)
    }
    
    public func mapping(map: [String:Any]) {
        var colors = Dictionary<String, [[Float]]>()

        id_user = map["id_user"] as? Int ?? 0
        username = map["username"] as? String ?? nil
        id_country = map["id_country"] as? Int ?? 0
        wind_units = map["wind_units"] as? String ?? nil
        temp_units = map["temp_units"] as? String ?? nil
        wave_units = map["wave_units"] as? String ?? nil
        pro = map["pro"] as? Int ?? 0
        no_ads = map["no_ads"] as? Int ?? 0
        view_hours_from = map["view_hours_from"] as? Int ?? 0
        view_hours_to = map["view_hours_to"] as? Int ?? 0
        temp_limit = map["temp_limit"] as? Int ?? 0
        wind_rating_limits = map["wind_rating_limits"] as? [Float] ?? []
        
        if let tmpcolors = map["colors"] as? Dictionary<String, [[Float]]> {
            colors = tmpcolors
        }
        for (k,v) in colors {
            for c in v {
                if let color = Color.init(a: c[0], r: c[1], g: c[2], b: c[3]) {
                    switch k {
                    case "wind": colors_wind.append(color)
                        break
                    case "temp": colors_temp.append(color)
                        break
                    case "cloud": colors_cloud.append(color)
                        break
                    case "precip": colors_precip.append(color)
                        break
                    case "precip1": colors_precip1.append(color)
                        break
                    case "press": colors_press.append(color)
                        break
                    case "rh": colors_rh.append(color)
                        break
                    case "htsgw": colors_htsgw.append(color)
                        break
                    case "perpw": colors_perpw.append(color)
                        break
                    default:
                        break
                    }
                }
            }
        }
    }
    
    
    public var description : String {
        var aux : String = "\(type(of:self)): "
        aux += "#\(id_user), "
        
        if let username = username {
            aux += "username: \(username), "
        }
        aux += "country # \(id_country), "
        if let wind_units = wind_units {
            aux += "wind_units \(wind_units), "
        }
        if let temp_units = temp_units {
            aux += "temp_units \(temp_units), "
        }
        if let wave_units = wave_units {
            aux += "wave_units \(wave_units), "
        }
        aux += "pro \(pro), "
        aux += "no_ads \(no_ads), "
        aux += "view_hours_from \(view_hours_from), "
        aux += "view_hours_to \(view_hours_to), "
        aux += "temp_limit \(temp_limit), "
        aux += "wind_rating_limits \(wind_rating_limits.printDescription())\n"

        aux += "colors_wind: "
        for c in colors_wind { aux += c.description + "; " }
        aux += "\n"

        aux += "colors_temp: "
        for c in colors_temp { aux += c.description + "; " }
        aux += "\n"

        aux += "colors_cloud: "
        for c in colors_cloud { aux += c.description + "; " }
        aux += "\n"

        aux += "colors_precip: "
        for c in colors_precip { aux += c.description + "; " }
        aux += "\n"

        aux += "colors_precip1: "
        for c in colors_precip1 { aux += c.description + "; " }
        aux += "\n"

        aux += "colors_press: "
        for c in colors_press { aux += c.description + "; " }
        aux += "\n"

        aux += "colors_rh: "
        for c in colors_rh { aux += c.description + "; " }
        aux += "\n"

        aux += "colors_htsgw: "
        for c in colors_htsgw{ aux += c.description + "; " }
        aux += "\n"

        aux += "colors_perpw: ["
        for c in colors_perpw{ aux += c.description + "; " }
        aux += "]\n"

        return aux
    }
}

extension User {
    public func name() -> String {
        if isAnonymous() {
            return "Anonymous"
        }
        return username ?? ""
    }
    
    public func isAnonymous() -> Bool {
        if let username = username, username != "" {
            return false
        }
        return true
    }
    
    public func getUsername() -> String? {
        return username
    }
}
