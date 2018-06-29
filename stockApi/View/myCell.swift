//
//  myCell.swift
//  stockApi
//
//  Created by Nikita Timirbulatov on 29.06.2018.
//  Copyright © 2018 Nikita Timirbulatov. All rights reserved.
//

import UIKit

class myCell: UITableViewCell {
    
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbVolume: UILabel!
    @IBOutlet weak var lbAmount: UILabel!
    
    var stock : StockInfo? {
        didSet {
            guard stock != nil else {
                return
            }
            
            lbName.text = stock?.name ?? "-"
            lbAmount.text = stock?.amount ?? "-"
            lbVolume.text = stock?.volume ?? "-"
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
