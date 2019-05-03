//
//  MemeCell.swift
//  Memestry
//
//  Created by Vishnu Priya on 5/2/19.
//  Copyright © 2019 Codepath. All rights reserved.
//

import UIKit

class MemeCell: UITableViewCell {
    
    
    @IBOutlet weak var posterView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
