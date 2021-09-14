//
//  CenteringCell.swift
//  GradesGuru
//
//  Created by Superpower on 14/05/21.
//  Copyright © 2021 iMac superpower. All rights reserved.
//

import UIKit

class CenteringCell: UITableViewCell {

    
    @IBOutlet var center_Grade: UILabel!
    @IBOutlet var center_Desc: UILabel!
    
    @IBOutlet var center_Front: UILabel!
    @IBOutlet var center_Back: UILabel!
    @IBOutlet var SGC_CenteringData: UILabel!

    @IBOutlet var Center_Front_Label: UILabel!
    @IBOutlet var Center_Back_Label: UILabel!
    @IBOutlet var SGC_Centering: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
