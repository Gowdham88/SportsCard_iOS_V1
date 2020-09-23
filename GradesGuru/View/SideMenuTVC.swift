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

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
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

}
