//
//  ViewControllerTableViewCell.swift
//  GradesGuru
//
//  Created by Superpower on 07/07/21.
//  Copyright © 2021 iMac superpower. All rights reserved.
//

import UIKit

class ViewControllerTableViewCell: UITableViewCell {

    @IBOutlet var GradeLabel: UILabel!
    
    @IBOutlet var Grade_Value: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
