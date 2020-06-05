//
//  WeatherTableViewCell.swift
//  WeatherApp
//
//  Created by Rekha Ranjan on 6/4/20.
//  Copyright © 2020 Rekha Ranjan. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblValue: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func customizeCellUI(_cell:UITableViewCell, indexpath:IndexPath ,model:WeatherModel){
        
        let dict:[String:Any] = (model.array?[indexpath.row])!
        print(dict)
        
        switch WeatherRows(rawValue:indexpath.row) {
        case .id:
             lblTitle.text = WeatherRows.id.title
             lblValue.text = "\(dict["id"] as! Int)"
        case .name:
             lblTitle.text = WeatherRows.name.title
             lblValue.text = "\(dict["name"] as! String)"
        case .visibility:
             lblTitle.text = WeatherRows.visibility.title
             lblValue.text = "\(dict["visibility"] as! Int)"
        default:
            break
        }

//        lblValue.text = "\(String(describing: dict["id"] as? Int))"
//        lblValue.text = "\(String(describing: dict["name"]))"
//        lblValue.text = "\(String(describing: dict["visibility"]! as? Int))"
         
        
        
    }

}
