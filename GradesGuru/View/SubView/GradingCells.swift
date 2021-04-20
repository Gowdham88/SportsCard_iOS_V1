//
//  GradingCells.swift
//  GradesGuru
//
//  Created by Superpower on 24/01/21.
//  Copyright © 2021 iMac superpower. All rights reserved.
//

import UIKit

public extension UITableViewCell {
    /// Generated cell identifier derived from class name
    static func cellIdentifier() -> String {
        return String(describing: self)
    }
}

class GradingCells: UITableViewCell {
    
    @IBOutlet var CellContentView: UIView!
    
    @IBOutlet var grading_number: UILabel!
    @IBOutlet var Grading_Title: UILabel!
    
    @IBOutlet var Grading_Description: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        
//        let padding = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
//        bounds = bounds.inset(by: padding)
//    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        

        
    }

   
}
