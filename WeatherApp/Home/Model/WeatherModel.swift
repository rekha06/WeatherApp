//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Rekha Ranjan on 6/4/20.
//  Copyright © 2020 Rekha Ranjan. All rights reserved.
//

import Foundation

enum WeatherRows: Int,CaseIterable {
    case id = 0
    case name
    case visibility
    var title: String {
        switch self {
        case .id:
            return "Id"
        case .name:
            return "Name"
        case .visibility:
             return "Visibilty"
        }
    }
}
    
struct WeatherModel {
    
private(set) var array :[[String:Any]]?
      
      
    init?(from resultSet: [String:Any]) {
        print("resultSet",resultSet)
        var arrWeatherSet = [[String:Any]]()
        if let id = (resultSet as AnyObject)["id"]! as? Int
        {
            arrWeatherSet.append(["id":id])
        }
        if let name = (resultSet as AnyObject)["name"]! as? String
        {
            arrWeatherSet.append(["name":name])
        }
//        if let desc = (resultSet as AnyObject)["weather"]![0]["description"]! as? String
//        {
//            arrWeatherSet.append(["desc":name])
//        }
        if let visibility = (resultSet as AnyObject)["visibility"]! as? Int
        {
            arrWeatherSet.append(["visibility":visibility])
        }
        
        array = arrWeatherSet
    }
    
    }

   
