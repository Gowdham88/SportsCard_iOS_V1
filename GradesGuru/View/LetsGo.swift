//
//  LetsGo.swift
//  GradesGuru
//
//  Created by Superpower on 16/09/20.
//  Copyright © 2020 iMac superpower. All rights reserved.
//

import UIKit

class LetsGo: UIViewController {
    
    var StartDate : Date = Date()
    
    @IBAction func LetsGo(_ sender: Any) {
        
        
        let Users1 = Users(device_ID: Usersdetails.device_ID, Subscription_Status: "Tru", Subscription_Date: StartDate, Subscription_Type: "True", Cost: 12, CurrentScan_Count: 3)
        
        UpdateUsers(Users: Users1)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        let vc = storyboard.instantiateViewController(withIdentifier: "HomePage")
        
        vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        
        self.present(vc, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
