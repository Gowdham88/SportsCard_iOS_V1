//
//  HomePageVC.swift
//  GradesGuru
//
//  Created by Superpower on 16/09/20.
//  Copyright © 2020 iMac superpower. All rights reserved.
//

import UIKit

class HomePageVC: UIViewController {
   
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var myTableView: UITableView!
    
    @IBOutlet weak var addImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {

            textfield.backgroundColor = UIColor.white
            textfield.attributedPlaceholder = NSAttributedString(string: textfield.placeholder ?? "Search here", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
            
//            textfield.background = UIImage(named: "noun_Search")
            
            searchBar.backgroundColor = UIColor(patternImage: UIImage(named: "Search")!)
            
//            searchBar.backgroundImage = UIImage(named: "Search")
            searchBar.frame = CGRect(x: 20, y: 100, width: view.frame.width - 25, height: 40)
           

            if let leftView = textfield.leftView as? UIImageView {
                leftView.image = UIImage(named: "noun_Search.png")
                
//                leftView.tintColor = UIColor.black
            }

        }
        
        
        //Upload image action:
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(uploadImage(tapGestureRecognizer:)))
        addImage.isUserInteractionEnabled = true
        addImage.addGestureRecognizer(tapGestureRecognizer)
        
        
        // Do any additional setup after loading the view.
    }
    
    @objc func uploadImage(tapGestureRecognizer: UITapGestureRecognizer) {
        //let tappedImage = tapGestureRecognizer.view as! UIImageView
        print(":::::Image view tapped ::::::")
    }
  

}

extension HomePageVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         
               let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeTVCell
               
               
               // Configure the cell...

               return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            myTableView.beginUpdates()
                //Names.removeAtIndex(indexPath!.row)
            myTableView.deleteRows(at: [indexPath], with: .none)
            myTableView.endUpdates()

            }
    }
    
}
