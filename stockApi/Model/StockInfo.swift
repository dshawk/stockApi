//
//  StockInfo.swift
//  stockApi
//
//  Created by Nikita Timirbulatov on 29.06.2018.
//  Copyright © 2018 Nikita Timirbulatov. All rights reserved.
//

import UIKit
import SwiftyJSON

class StockInfo: NSObject {
    
    var name : String?
    var volume : String?
    var amount : String?
    
    override init() {
        super.init()
    }
    
    convenience init(_ json : JSON) {
        self.init()
        
        name = json["name"].string
        
        var volumeElement = json["volume"].int
        volume = "\(String(describing: volumeElement ?? 0))"
        volumeElement = nil
        
        var price = json["price"].dictionary
        guard price != nil else {
            return
        }
        var amountElement = price!["amount"]?.double
        amount = String(format: "%.2f", amountElement ?? 0)
        price = nil
        amountElement = nil
        
        
    }
    
    deinit {
        name = nil
        volume = nil
        amount = nil
    }

}
