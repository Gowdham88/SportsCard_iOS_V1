//
//  GoProVC.swift
//  GradesGuru
//
//  Created by Superpower on 21/09/20.
//  Copyright © 2020 iMac superpower. All rights reserved.
//

import UIKit
import Foundation

class GoProVC: UIViewController {

    @IBOutlet weak var GradeText: UILabel!
    
    @IBOutlet weak var termsofUse: UIButton!
    
    @IBOutlet weak var termsText: UITextView!
    
    @IBAction func GoBack(_ sender: Any) {
        
        
//        dismissDetail()
        
        dismissVC()
    }
    
    
    
    
    
    let termsTextString = NSAttributedString(string: "This subscription automatically renews for the price \n selected above. Your subscription will auto-review unless \n cancelled more than 24 hours before the end of each \n subscription period. Payment will be charged to your iTunes \n account. You can manage your subscription and turn off \n auto-renewal in your iTunes account.")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let colour = GoProVC.hexStringToUIColor(hex: "#BEC4D1")
        
//        termsText.textColor = .blue
        
        termsText.tintColor = .blue
        
        termsText.font = UIFont(name: "Muli-Regular", size: 12)
        termsText.attributedText = termsTextString.withLineSpacing(9)
//        termsTextString.attr
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    public static func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) == 6) {

            var rgbValue:UInt32 = 0
            Scanner(string: cString).scanHexInt32(&rgbValue)

            return UIColor(
                red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                alpha: CGFloat(1.0)
            )
        }else if ((cString.count) == 8) {

            var rgbValue:UInt32 = 0
            Scanner(string: cString).scanHexInt32(&rgbValue)

            return UIColor(
                red: CGFloat((rgbValue & 0x00FF0000) >> 16) / 255.0,
                green: CGFloat((rgbValue & 0x0000FF00) >> 8) / 255.0,
                blue: CGFloat(rgbValue & 0x000000FF) / 255.0,
                alpha: CGFloat((rgbValue & 0xFF000000) >> 24) / 255.0
            )
        }else{
            return UIColor.gray
        }
    }

//    func dismissDetail() {
//
//        let transition = CATransition()
//        transition.duration = 0.25
//        transition.type = CATransitionType.push
//        transition.subtype = CATransitionSubtype.fromLeft
//        self.view.window!.layer.add(transition, forKey: kCATransition)
//        dismiss(animated: false)
//    }
    
    func dismissVC() {
        
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        self.view.window!.layer.add(transition, forKey: nil)
        self.dismiss(animated: false, completion: nil)
    }
}





extension NSAttributedString {
    func withLineSpacing(_ spacing: CGFloat) -> NSAttributedString {


        let attributedString = NSMutableAttributedString(attributedString: self)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byTruncatingTail
        paragraphStyle.lineSpacing = spacing
        attributedString.addAttribute(.paragraphStyle,
                                      value: paragraphStyle,
                                      range: NSRange(location: 0, length: string.count))
        return NSAttributedString(attributedString: attributedString)
    }
}

