//
//  sideMenuCell.swift
//  GradesGuru
//
//  Created by Superpower on 17/09/20.
//  Copyright © 2020 iMac superpower. All rights reserved.
//

import UIKit

class sideMenuCell: UITableViewCell {

    @IBOutlet weak var sidemenuImage: UIImageView!
    @IBOutlet weak var sideMenuTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
