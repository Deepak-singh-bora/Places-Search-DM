//
//  TableViewCell.swift
//  Places Search DM
//
//  Created by Appinventiv on 21/03/18.
//  Copyright © 2018 Appinventiv. All rights reserved.
//

import Foundation
import UIKit

class TableViewCell: UITableViewCell{
    
    @IBOutlet weak var textView: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
