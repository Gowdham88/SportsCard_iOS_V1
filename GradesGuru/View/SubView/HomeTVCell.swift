//
//  HomeTVCell.swift
//  GradesGuru
//
//  Created by Superpower on 23/09/20.
//  Copyright © 2020 iMac superpower. All rights reserved.
//

import UIKit

class HomeTVCell: UITableViewCell {

    @IBOutlet weak var DPImage: UIImageView!
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var PSAValue: UILabel!
    @IBOutlet weak var BGSValue: UILabel!
    @IBOutlet weak var SGCValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        

        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
