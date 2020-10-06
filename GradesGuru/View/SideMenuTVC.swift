//
//  SideMenuTVC.swift
//  GradesGuru
//
//  Created by Superpower on 16/09/20.
//  Copyright © 2020 iMac superpower. All rights reserved.
//

import UIKit

class SideMenuTVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var sideMenu = ["Go Pro", "Grading Standards", "About Us", "Contact Us", "Rate Us", "Recommend To a Friend", "Terms & Privacy"]
    
    var sideMenuImages : [UIImage] = [UIImage(named: "GoPro")!, UIImage(named: "Grading_Standards")!, UIImage(named: "About_Us")!, UIImage(named: "Contact_Us")!, UIImage(named: "Rate_Us")!,  UIImage(named: "RecommendToFriend")!, UIImage(named: "TermsnPrivacy")!]
    
    @IBAction func sideMenuCancel(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 83.0/255.0, green: 117.0/255.0, blue: 252.0/255.0, alpha: 1.0)

        //        self.navigationController?.view.backgroundColor = .clear
        
    }

    // MARK: - Table view data source

     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sideMenu.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! sideMenuCell
        cell.backgroundColor = UIColor(red: 83.0/255.0, green: 117.0/255.0, blue: 252.0/255.0, alpha: 1.0)
        cell.sideMenuTitle.text = sideMenu[indexPath.row]
        cell.sidemenuImage.image = sideMenuImages[indexPath.row]
        
        // Configure the cell...

        return cell
    }
    
//    fileprivate func whitespaceString(font: UIFont = UIFont.systemFont(ofSize: 15), width: CGFloat) -> String {
//        let kPadding: CGFloat = 20
//        let mutable = NSMutableString(string: "")
//        let attribute = [NSAttributedString.Key.font: font]
//        while mutable.size(withAttributes: attribute).width < width - (2 * kPadding) {
//            mutable.append(" ")
//        }
//        return mutable as String
//    }
//
//   func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//        let whitespace = whitespaceString(width: kCellActionWidth)
//        let deleteAction = UITableViewRowAction(style: .`default`, title: whitespace) { (action, indexPath) in
//            // do whatever you want
//        }
//
//        // create a color from patter image and set the color as a background color of action
//        let kActionImageSize: CGFloat = 34
//        let view = UIView(frame: CGRect(x: 0, y: 0, width: kCellActionWidth, height: kCellHeight))
//        view.backgroundColor = UIColor.white
//        let imageView = UIImageView(frame: CGRect(x: (kCellActionWidth - kActionImageSize) / 2,
//                                                  y: (kCellHeight - kActionImageSize) / 2,
//                                                  width: 34,
//                                                  height: 34))
//        imageView.image = UIImage(named: "x")
//        view.addSubview(imageView)
//        let image = view.image()
//
//        deleteAction.backgroundColor = UIColor(patternImage: image)
//
//        return [deleteAction]
//    }
  
    
   
    
    

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! sideMenuCell
        
        switch indexPath.row {
        
        case 0:
        print("Go Pro")
        
        presentDetail(Storyboard: "Main", Identifier: "GoPro")
            
        case 1:
        print("Grading Standards")
        
        case 2:
        print("About Us")
        
        presentDetail(Storyboard: "Main", Identifier: "aboutUs")

        case 3:
        print("Contact Us")
        
        case 4:
        print("Rate Us")
        
        case 5:
        print("Recommend To a Friend")
        
        case 6:
        print("Terms and Privacy Us")
        
        default:
            break
        }
        
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */



    func presentDetail(Storyboard: String, Identifier: String) {
        
        let storyboard = UIStoryboard(name: Storyboard, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: Identifier)
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        self.view.window!.layer.add(transition, forKey: kCATransition)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)
        
    }

}


    /*func ModalRepFullScreen(Storyboard: String, Identifier: String) {
        
        let storyboard = UIStoryboard(name: Storyboard, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: Identifier)
//        vc.modalPresentationStyle = .fullScreen
//        let transition = CATransition()
//        transition.duration = 0.25
//        transition.type = CATransitionType.push
//        transition.subtype = CATransitionSubtype.fromRight
//        self.view.window!.layer.add(transition, forKey: kCATransition)
//
//        self.present(vc, animated: false, completion: nil)
        
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false, completion: nil)
        
    }*/
