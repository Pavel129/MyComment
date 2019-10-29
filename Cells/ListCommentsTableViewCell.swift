//
//  ListCommentsTableViewCell.swift
//  MyComment
//
//  Created by Mac on 29/10/2019.
//  Copyright © 2019 Pavel CH.V. All rights reserved.
//


import UIKit

class ListCommentsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var commentTextLabel: UILabel!
    
    
    
    @IBOutlet weak var date: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
