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
    
    @IBOutlet weak var tableViewBottomConstraints: NSLayoutConstraint!
    
    @IBOutlet weak var scanBtnView: UIView!
    
    //sample data array
    var name = ["Karthik", "Gowdhaman", "Hanifa", "Rathna"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if name.count > 0 {
            addImage.isHidden = true
            scanBtnView.isHidden = false
        } else {
            addImage.isHidden = false
            scanBtnView.isHidden = true
        }
         
        
        

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
        
        
        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func scanDocument(_ sender: Any) {
        print(":::::Document view tapped ::::::")
        let homepageController: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let homePageVC = homepageController.instantiateViewController(identifier: "ViewController") as! ViewController
        self.navigationController?.pushViewController(homePageVC, animated: true)
    }
    
    @objc func uploadImage(tapGestureRecognizer: UITapGestureRecognizer) {
        print(":::::Image view tapped ::::::")
        let homepageController: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let homePageVC = homepageController.instantiateViewController(identifier: "ViewController") as! ViewController
        self.navigationController?.pushViewController(homePageVC, animated: true)
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Card", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "newTabbarController")
        vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency

        self.present(vc, animated: true, completion: nil) //present(vc, animated: true)
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
