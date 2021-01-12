//
//  InfoVc.swift
//  GradesGuru
//
//  Created by Apple on 11/01/21.
//  Copyright © 2021 iMac superpower. All rights reserved.
//

import UIKit

class InfoVc: UIViewController {
    
    
    @IBOutlet weak var popView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        
        popView.layer.cornerRadius = 8.0
        popView.layer.masksToBounds = true

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.dismiss(animated: true, completion: nil)
    }
    

   
    @IBAction func popClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
