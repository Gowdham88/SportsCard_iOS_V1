//
//  LetsGo.swift
//  GradesGuru
//
//  Created by Superpower on 16/09/20.
//  Copyright © 2020 iMac superpower. All rights reserved.
//

import UIKit
import Foundation

class LetsGo: UIViewController {
    
    var StartDate : Date = Date()
    
    @IBOutlet weak var firstText: UITextView!
    
    let termsTextString = NSAttributedString(string: "While Grade Guru helps guide you through this \n process, YOU are the one actually evaluating your \n cards. Therefore, Grade Guru does not make any \n guarantee about the actual grade your cards may \n receive.")
    
    @IBAction func LetsGo(_ sender: Any) {
        
        let Users1 = Users(device_ID: Usersdetails.device_ID, Subscription_Status: "Tru", Subscription_Date: StartDate, Subscription_Type: "True", Cost: 12, CurrentScan_Count: 3)
        
        UpdateUsers(Users: Users1)
        
        ModalRepFullScreen(Storyboard: "Main", Identifier: "HomePage")
        
    }
    
    func ModalRepFullScreen(Storyboard: String, Identifier: String) {
        
        let storyboard = UIStoryboard(name: Storyboard, bundle: nil)

        let vc = storyboard.instantiateViewController(withIdentifier: Identifier)
        
        vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        
        self.present(vc, animated: true, completion: nil)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        firstText.font = UIFont(name: "Muli-Regular", size: 18)

//        firstText.attributedText = termsTextString.withLineSpacing(15)
        
        
        
        
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


//    func addTextSpacing(_ spacing: CGFloat, Text: String){
//
//        let attributedString = NSMutableAttributedString(string: Text)
//        attributedString.addAttribute(NSAttributedString.Key.kern, value: spacing, range: NSRange(location: 0, length: Text.count))
//        attributedString.addAttribute(NSAttributedString.Key(rawValue: "\(self.font?.lineHeight)"), value: 50, range: NSRange(location: 0, length: Text.count))
//
//        Text = attributedString
//    }



