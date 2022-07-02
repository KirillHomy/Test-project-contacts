//
//  TPCTableViewCell.swift
//  Test project contacts
//
//  Created by Кирилл on 23.06.2022.
//

import UIKit

class TPCTableViewCell: UITableViewCell {

    @IBOutlet var imageCell: UIImageView!
    @IBOutlet var nameLabelCell: UILabel!
    @IBOutlet var countLabelCell: UILabel!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
