//
//  UserViewController.swift
//  JFWindguru
//
//  Created by javierfuchs on 7/12/17.
//  Copyright © 2017 Mobile Patagonia. All rights reserved.
//

import Foundation
import JFWindguru
import SCLAlertView

class UserViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var user: User?
    var password: String?

    let services = ["add_f_spot",
                    "c_spots",
                    "countries",
                    "f_spots",
                    "forecast",
                    "geo_regions",
                    "model_info",
                    "models_latlon",
                    "regions",
                    "search_spots",
                    "set_spots",
                    "sets",
                    "spot",
                    "spots",
                    "user",
                    "wforecast",
                    "wforecast_latlon"]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
}

extension UserViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let service = services[indexPath.item]
        
        switch service {
        case "f_spots":
            ForecastWindguruService.instance.favoriteSpots(withUsername: user?.username, password: password, failure: {
                (error) in
                let subTitle = error?.title() ?? ""
                SCLAlertView().showError("Error on \(service)", subTitle: subTitle)
            }) { (favorites) in
                guard let favorites = favorites else {
                    let subTitle = "No favorites"
                    SCLAlertView().showError("Error on \(service)", subTitle: subTitle)
                    return
                }
                SCLAlertView().showSuccess("\(service) success", subTitle: favorites.description)
            }
            break
        default:
            break
        }
    }
}

extension UserViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return services.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommonCell", for: indexPath)
        cell.textLabel?.text = services[indexPath.item]
        return cell
    }
    

}

