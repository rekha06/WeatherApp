//
//  BaseNavigationViewController.swift
//  WeatherApp
//
//  Created by Rekha Ranjan on 6/4/20.
//  Copyright © 2020 Rekha Ranjan. All rights reserved.
//

import UIKit

class BaseNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: App.Color.primaryLabel2 ?? .black,
                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)]
               self.navigationBar.isTranslucent = false
               self.navigationBar.barTintColor = App.Color.primaryBackground

       
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
