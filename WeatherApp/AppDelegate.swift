//
//  AppDelegate.swift
//  BUK
//
//  Created by Rekha on 04/06/20.
//  Copyright © 2020 Rekha. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        App.instiate()
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
     
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
     
    }
    
  
     

}
