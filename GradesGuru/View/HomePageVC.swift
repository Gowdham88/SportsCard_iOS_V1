//
//  HomePageVC.swift
//  GradesGuru
//
//  Created by Superpower on 16/09/20.
//  Copyright © 2020 iMac superpower. All rights reserved.
//

import UIKit

class HomePageVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       /* if let textfield = searchBar.value(forKey: "searchField") as? UITextField {

            textfield.backgroundColor = UIColor.white
            textfield.attributedPlaceholder = NSAttributedString(string: textfield.placeholder ?? "Search here", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
            
//            textfield.background = UIImage(named: "noun_Search")
            
//            searchBar.backgroundColor = UIColor(patternImage: UIImage(named: "Search")!)
            
//            searchBar.backgroundImage = UIImage(named: "Search")
//            searchBar.frame = CGRect(x: 20, y: 100, width: view.frame.width - 25, height: 40)
           

//            if let leftView = textfield.leftView as? UIImageView {
//                leftView.image = UIImage(named: "noun_Search.png")
//
////                leftView.tintColor = UIColor.black
//            }

        }*/
        
        // Do any additional setup after loading the view.
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         
      
        
        
        
               let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeTVCell
        
        
               
        
               // Configure the cell...

               return cell
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
