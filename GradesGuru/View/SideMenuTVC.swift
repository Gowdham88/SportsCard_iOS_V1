//
//  SideMenuTVC.swift
//  GradesGuru
//
//  Created by Superpower on 16/09/20.
//  Copyright © 2020 iMac superpower. All rights reserved.
//

import UIKit
import StoreKit
import MessageUI
import SafariServices


class SideMenuTVC: UIViewController, UITableViewDelegate, UITableViewDataSource,UINavigationControllerDelegate,MFMailComposeViewControllerDelegate {
    
    var sideMenu = ["Go Pro", "Grading Standards", "About Us", "Contact Us", "Rate Us", "Recommend To a Friend", "Terms & Privacy"]
    
    var sideMenuImages : [UIImage] = [UIImage(named: "GoPro")!, UIImage(named: "Grading_Standards")!, UIImage(named: "About_Us")!, UIImage(named: "Contact_Us")!, UIImage(named: "Rate_Us")!,  UIImage(named: "RecommendToFriend")!, UIImage(named: "TermsnPrivacy")!]
    
    @IBAction func sideMenuCancel(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
    }
    
    //Mark: Share the app link to friends
    func shareApp() {
        if let urlStr = NSURL(string: "https://itunes.apple.com/us/app/myapp/idxxxxxxxx?ls=1&mt=8") {
            let objectsToShare = [urlStr]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)

            if UIDevice.current.userInterfaceIdiom == .phone {
                if let popup = activityVC.popoverPresentationController {
                    popup.sourceView = self.view
                    popup.sourceRect = CGRect(x: self.view.frame.size.width / 2, y: self.view.frame.size.height / 4, width: 0, height: 0)
                }
            }

            self.present(activityVC, animated: true, completion: nil)
        }

    }
    
    //Mark: App store rating
    func rateApp() {
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()

        } else if let url = URL(string: "itms-apps://itunes.apple.com/app/" + "appId") {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)

            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    // MARK: - Email Delegate
    
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
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
        
        cell.sideMenuTitle.text = sideMenu[indexPath.row]
        cell.sidemenuImage.image = sideMenuImages[indexPath.row]
        
                

        // Configure the cell...

        return cell
    }
    
    func ModalRepFullScreen(Storyboard: String, Identifier: String) {
        
        let storyboard = UIStoryboard(name: Storyboard, bundle: nil)

        let vc = storyboard.instantiateViewController(withIdentifier: Identifier)
        
        vc.modalPresentationStyle = .fullScreen
        
        self.present(vc, animated: true, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! sideMenuCell
        
        switch indexPath.row {
        
        case 0:
        print("Go Pro")
        
        ModalRepFullScreen(Storyboard: "Main", Identifier: "GoPro")

        case 1:
        print("Grading Standards")
        
        case 2:
        print("About Us")
        
        ModalRepFullScreen(Storyboard: "Main", Identifier: "aboutUs")
        
        case 3:
        print("Contact Us")
            if MFMailComposeViewController.canSendMail(){
                let vc = MFMailComposeViewController()
                vc.delegate = self
                vc.setSubject("Grade Guru Support")
                vc.setToRecipients(["sportscardsscience@gmail.com"])
                vc.setMessageBody("Please let us know about any issues, feature request or anything else in your mind!", isHTML: true)
        //        vc.addAttachmentData(<#T##attachment: Data##Data#>, mimeType: "plain", fileName: v)
                present(vc, animated: true)
            }else{
                if let url = URL(string: "message://") {
                  if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url)
                  } else {
                    UIApplication.shared.openURL(url)
                  }
                }
            }
          
        
        case 4:
        print("Rate Us")
        rateApp()
         
        
        case 5:
        print("Recommend To a Friend")
        shareApp()
        
        case 6:
        print("Terms and Privacy Us")
        ModalRepFullScreen(Storyboard: "Card", Identifier: "newTabbarController")
        
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

}
