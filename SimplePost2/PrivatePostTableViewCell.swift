//
//  PrivatePostTableViewCell.swift
//  simplePost
//
//  Created by byongguen son on 2017. 7. 26..
//  Copyright © 2017년 byongguen son. All rights reserved.
//

import UIKit

class PrivatePostTableViewCell: UITableViewCell {
    @IBOutlet weak var checkImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
