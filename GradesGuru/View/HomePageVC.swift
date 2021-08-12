//
//  HomePageVC.swift
//  GradesGuru
//
//  Created by Superpower on 16/09/20.
//  Copyright © 2020 iMac superpower. All rights reserved.
//

import UIKit


class HomePageVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UITabBarDelegate {
    
    var myCardImages = [UIImage]()
    var cardImages = [UIImage]()
    var HomedetailArray = [HomeMaster]()
    var CardNumber = 0
    var defaults = UserDefaults.standard
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var addImage: UIImageView!
    @IBOutlet var tabBar: UITabBar!
    //sample data array
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if defaults.value(forKey: "cardNumber") != nil {
            
            CardNumber = defaults.value(forKey: "cardNumber") as! Int
            LoadCardIDS()

        } else {
            
            CardNumber = 0
            defaults.setValue(CardNumber, forKey: "cardNumber")
            //calling if loading for the first time
            
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
    
    

    func LoadCardIDS()  {
        
        let saveCardsIDs = "SaveCardIDS_\(Usersdetails.device_ID!)"
        cardImages.removeAll()
        HomedetailArray.removeAll()
        
        print("saveCardsIDs: \(saveCardsIDs)")
        if UserDefaults.standard.object(forKey: saveCardsIDs) != nil {
            
            addImage.isHidden = true
            myTableView.isHidden = false
            searchBar.isHidden = false
            tabBar.isHidden = false
            
            CardIDs = LoadCards.loadCardIDs(Device_ID: Usersdetails.device_ID!)
            
            for cardID in CardIDs {
                
                print("For Loop cardID: \(cardID)")

                let carddetails = LoadCards.loadCardsDetails(Card_ID: cardID)
                
                Homedetails = LoadHome(cardID: cardID)
                
                HomedetailArray.append(Homedetails)
                
                let cardImage = carddetails.Card_frontImage
                
                cardImages.append(cardImage!)
                
                print("1.cardImages.count: \(cardImages.count)")
                
            }
            
            print("2.cardImages.count: \(cardImages.count)")
            print("LoadCardIDS: \(CardIDs)")
            myCardImages = cardImages
            myTableView.reloadData()

        } else {
            
            print("No Cards")
            
        }
        
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
    
    override func viewDidAppear(_ animated: Bool) {
       
        if defaults.value(forKey: "cardNumber") != nil {
            
            CardNumber = defaults.value(forKey: "cardNumber") as! Int
            
            //calling if loading for on or after second time

            LoadCardIDS()

            
        } else {
            
            CardNumber = 0

            defaults.setValue(CardNumber, forKey: "cardNumber")
            
        }
        
        
    }
   
    override func viewDidLayoutSubviews() {
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped))
        addImage.addGestureRecognizer(tapGR)
        addImage.isUserInteractionEnabled = true
        
        addImage.isHidden = false
        myTableView.isHidden = true
        searchBar.isHidden = true
        tabBar.isHidden = true
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return CardIDs.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeTVCell
        
        print("cardImages.count: \(cardImages.count)")
        print("myCardImages.count: \(myCardImages.count)")
        
        cell.DPImage.image = myCardImages[indexPath.row]
        cell.playerName.text = HomedetailArray[indexPath.row].Name
        cell.PSAValue.text = HomedetailArray[indexPath.row].PSA
        cell.BGSValue.text = HomedetailArray[indexPath.row].BGS
        cell.SGCValue.text = HomedetailArray[indexPath.row].SGC
               
        // Configure the cell...

        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Card", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "newTabbarController")
        vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        
        selected_CardID = CardIDs[indexPath.row]
        print("selected_CardID: \(selected_CardID)")

        self.present(vc, animated: true, completion: nil) //present(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
   
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//
//        if (editingStyle == UITableViewCell.EditingStyle.delete) {
//            myTableView.beginUpdates()
//                //Names.removeAtIndex(indexPath!.row)
//            myTableView.deleteRows(at: [indexPath], with: .none)
//            myTableView.endUpdates()
//
//        } else if editingStyle == UITableViewCell.EditingStyle.insert {
//
//            Navigateto_MainVC()
//        }
//    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        print(":::::Document view tapped ::::::")
        selected_CardID = ""
        CardNumber += 1
        
        defaults.setValue(CardNumber, forKey: "cardNumber")
        
        Navigateto_MainVC()
        
        }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let actionEdit = UIContextualAction(
            style: .normal,
            title: "Edit",
            handler: { [self] (action, view, completion) in
                //do what you want here
                
                selected_CardID = CardIDs[indexPath.row]
                print("selected_CardID: \(selected_CardID)")
                
                Navigateto_MainVC()

                completion(true)
        })

        let actionDelete = UIContextualAction(
            style: .destructive,
            title: "",
            handler: { [self] (action, view, completion) in
                //do what you want here
                
                selected_CardID = CardIDs[indexPath.row]
                print("selected_CardID: \(selected_CardID)")
                
               myTableView.beginUpdates()
               //Names.removeAtIndex(indexPath!.row)
               myTableView.deleteRows(at: [indexPath], with: .none)
               myTableView.endUpdates()
    
                completion(true)
        })
        
        actionDelete.image = UIImage(named: "Delete")
        actionDelete.backgroundColor = .red
        let configuration = UISwipeActionsConfiguration(actions: [actionDelete, actionEdit])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
    
}
