//
//  AppDelegate.swift
//  BUK
//
//  Created by Rekha on 04/06/20.
//  Copyright © 2020 Rekha. All rights reserved.
//
import UIKit
import Security
import LocalAuthentication


class App {
   static public let ApiKey = "fa3d40d43488aee57d9dbc7b59e891e0"
   static public let baseUrl = "https://api.openweathermap.org/data/2.5/weather?"
   static public let methodName = "q=London&appid=\(App.ApiKey)"
    
   public struct Color {
       static let primaryBackground         = UIColor(named: "primaryBackground")
       static let primaryBackground2        = UIColor(named: "primaryBackground2")
       static let primaryLabel              = UIColor(named: "primaryLabel")
       static let primaryLabel2             = UIColor(named: "primaryLabel2")
    }

   
    static public let delegate = (UIApplication.shared.delegate as? AppDelegate)
    
    class func device() -> UIUserInterfaceIdiom {
         return UIDevice.current.userInterfaceIdiom
    }
    
    
    class public func instiate() {
        delegate?.window = UIWindow(frame: UIScreen.main.bounds)
        if #available(iOS 13.0, *) {
            delegate?.window?.backgroundColor = .systemBackground
        } else {
            delegate?.window?.backgroundColor = .white
        }
        setMainRoot()
        delegate?.window?.makeKeyAndVisible()
        
    }
    
    
    class public func setMainRoot() {
        delegate?.window?.rootViewController = BaseNavigationViewController(rootViewController: MainView().home)
    }
}
