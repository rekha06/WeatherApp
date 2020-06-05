//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Rekha Ranjan on 6/3/20.
//  Copyright © 2020 Rekha Ranjan. All rights reserved.
//

import UIKit



class WeatherViewController: UIViewController {
    
@IBOutlet weak var tableView: UITableView!
@IBOutlet weak var btnSearch: UIButton!
@IBOutlet weak var searchTxt: UITextField!
    
var weathermodel:WeatherModel?
var cities = [String:Any]()

    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    @IBAction func SearchBtnClicked(_sender:UIButton){
    if let text = searchTxt.text {
        
        // Load the data from the server
           NetworkManager.shared.get(NetworkManagerActions.action1.rawValue,params:["City":text]) { (result) in
                print(result)
            if let result = result.result{
                self.weathermodel = WeatherModel(from: result as! [String : Any])
                self.tableView.reloadData()
                
    }
   }
 }
        
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
    
    



extension WeatherViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherTableViewCell", for: indexPath) as? WeatherTableViewCell , let model  = weathermodel else { return UITableViewCell()
        }
        cell.customizeCellUI(_cell: cell, indexpath: indexPath, model: model)
        
        return cell
      
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let model = weathermodel{
            return model.array?.count ?? 0
        }
        
        return 0
    }
 
}

extension WeatherViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //textField.text = ""
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        return true
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
}
