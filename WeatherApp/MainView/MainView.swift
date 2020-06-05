//
//  MainView.swift
//  WeatherApp
//
//  Created by Rekha Ranjan on 6/4/20.
//  Copyright © 2020 Rekha Ranjan. All rights reserved.
//

import Foundation
import UIKit


struct MainView {
    
    static private var storyBoard = UIStoryboard(name: "Main", bundle: nil)

    
    public var home : WeatherViewController {
        MainView.storyBoard.instantiateViewController(withIdentifier: "WeatherViewController") as! WeatherViewController
    }
    
}
