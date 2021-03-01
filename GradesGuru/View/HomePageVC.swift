//
//  HomePageVC.swift
//  GradesGuru
//
//  Created by Superpower on 16/09/20.
//  Copyright © 2020 iMac superpower. All rights reserved.
//

import UIKit

var CardNumber = 0

class HomePageVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
   
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var addImage: UIImageView!
    @IBOutlet weak var scanBtnView: UIView!
    
    //sample data array
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if CardIDs.count > 0 {
            
            addImage.isHidden = true
            scanBtnView.isHidden = false
            myTableView.isHidden = false
            searchBar.isHidden = false
            
        } else {
            
            
            let tapGR = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped))
            addImage.addGestureRecognizer(tapGR)
            addImage.isUserInteractionEnabled = true
            
            
            addImage.isHidden = false
            scanBtnView.isHidden = true
            myTableView.isHidden = true
            searchBar.isHidden = true
            
        }
         
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {

            textfield.backgroundColor = UIColor.white
            textfield.attributedPlaceholder = NSAttributedString(string: textfield.placeholder ?? "Search here", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
            
            searchBar.backgroundColor = UIColor(patternImage: UIImage(named: "Search")!)
            
            searchBar.frame = CGRect(x: 20, y: 100, width: view.frame.width - 25, height: 40)
           

            if let leftView = textfield.leftView as? UIImageView {
                
                leftView.image = UIImage(named: "noun_Search.png")
                
                leftView.tintColor = UIColor(red: 83.0/255.0, green: 117.0/225.0, blue: 252.0/255.0, alpha: 1.0)
            }

        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func scanDocument(_ sender: Any) {
        
        print(":::::Document view tapped ::::::")
        
        CardNumber += 1
        Navigateto_MainVC()
        
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        
        print(":::::Image view tapped ::::::")
        
        if tapGestureRecognizer.state == .ended {
                            
            print("UIImageView tapped")
            Navigateto_MainVC()

        }
        
    }
    
    func Navigateto_MainVC() {
        
        let homepageController: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let homePageVC = homepageController.instantiateViewController(identifier: "ViewController") as! ViewController
        self.navigationController?.pushViewController(homePageVC, animated: true)
        
    }
    
    override func viewDidLayoutSubviews() {
        
        if CardIDs.count > 0 {
            
            CardIDs = LoadCards.loadCardIDs(Device_ID: Usersdetails.device_ID)
            
        } else {
            
            print("Cards IDS Nil")
            
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return CardIDs.count
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
