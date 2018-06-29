//
//  ViewController.swift
//  stockApi
//
//  Created by Nikita Timirbulatov on 29.06.2018.
//  Copyright © 2018 Nikita Timirbulatov. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var isLoadingData : Bool = false
    
    @IBOutlet weak var tableView: UITableView!
    var listStock : Array<StockInfo>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadingData()
        _ = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.loadingData), userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = self.listStock?.count else {
            return 0
        }
        
        return count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : myCell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! myCell
        
        guard self.listStock != nil, indexPath.row < (self.listStock?.count)! else {
            cell.stock = nil
            return cell
        }
        cell.stock = self.listStock![indexPath.row]
        return cell
    }
    
    
    @IBAction func updateData(_ sender: Any) {
        self.loadingData()
    }
    
    @objc private func loadingData() {
        
        print("loadingData - \(self.isLoadingData)")
        
        guard !isLoadingData else {
            return
        }
        //info.dshawk.stockApi
        self.isLoadingData = true
        
        var config : URLSessionConfiguration? = URLSessionConfiguration.default
        config?.requestCachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData
        config?.urlCache = nil
        let requestList = URLRequest(url: URL(string: "http://phisix-api3.appspot.com/stocks.json")!)
        let sessionList = URLSession(configuration: config!)
        config = nil
        
        sessionList.dataTask(with: requestList, completionHandler: {
            (data, response, error) -> Void in
            
            guard error == nil, data != nil else {
                return
            }
            
            let jsonMain = JSON(data as Any)
            let jsonStock = jsonMain["stock"].array
            
            guard jsonStock != nil else {
                return
            }
            
            var list : Array<StockInfo>? = []
            for element in jsonStock! {
                var stockInfo : StockInfo? = StockInfo(element)
                list?.append(stockInfo!)
                stockInfo = nil
            }
            
            if self.listStock != nil {
                self.listStock?.removeAll()
                self.listStock = nil
            }
            
            DispatchQueue.main.async(execute: {
                
                self.listStock = list
                list = nil
                
                self.isLoadingData = false
                self.tableView.reloadData()
            })
            
            
        }).resume()
    }


}

