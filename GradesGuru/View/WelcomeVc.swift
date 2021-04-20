//
//  WelcomeVc.swift
//  GradesGuru
//
//  Created by Apple on 04/01/21.
//  Copyright © 2021 iMac superpower. All rights reserved.
//

import UIKit

class WelcomeVc: UIViewController {
    
    
    @IBOutlet weak var welcomeLbl: UILabel!
    @IBOutlet weak var contentText: UITextView!
    @IBOutlet weak var letsGoBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        letsGoBtn.layer.cornerRadius = 10.0
        letsGoBtn.layer.masksToBounds = true
        letsGoBtn.layer.borderColor = UIColor.black.cgColor
        letsGoBtn.layer.borderWidth = 1.0

    }
    

    @IBAction func letGoBtnTapped(_ sender: Any) {
        print(":::::: Move to Home Page :::::::")
        let homepageController: UIStoryboard = UIStoryboard(name: "Login", bundle: nil)
        let homePageVC = homepageController.instantiateViewController(identifier: "HomePageVC") as! HomePageVC
        self.navigationController?.pushViewController(homePageVC, animated: true)
    }
    
}
