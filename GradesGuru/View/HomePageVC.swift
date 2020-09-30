//
//  HomePageVC.swift
//  GradesGuru
//
//  Created by Superpower on 16/09/20.
//  Copyright © 2020 iMac superpower. All rights reserved.
//

import UIKit

class HomePageVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UITabBarDelegate {
   
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
        
    }
    
      func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    
            let action = UIContextualAction(
                style: .normal,
                title: "",
                handler: { (action, view, completion) in
                    //do what you want here
                    completion(true)
            })
    
            action.image = UIImage(named: "Delete")
            action.backgroundColor = .red
            let configuration = UISwipeActionsConfiguration(actions: [action])
            configuration.performsFirstActionWithFullSwipe = false
            return configuration
        
        }
        
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
               let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeTVCell
        
               // Configure the cell...

               return cell
        
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        let vc = storyboard.instantiateViewController(withIdentifier: "Mainpage")
        
        vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        
        self.present(vc, animated: true, completion: nil)

        //This method will be called when user changes tab.
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
