//
//  newTabbarController.swift
//  TabbarDesignImplementation
//
//  Created by Superpower on 17/08/20.
//  Copyright © 2020 iMac superpower. All rights reserved.
//

import Foundation
import UIKit

var StartText : String!

class newTabbarController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: ***** Variable and outlets  *****
    
    // outlets
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var headerTextLabel: UILabel!
    @IBOutlet weak var tabbarTableView: UITableView!
    
    // Variables
    
    var textboxCellPlaceHolderArray = ["Player Name", "Sport", "Year", "Set", "Variation/Color", "Card #"]
    var switchLabelPlaceHolderArray = ["Rookie", "Autograph", "Patch", "Scanned on "]
    let defaults =  UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
  
        let saveCard_key = "SaveCards_\(selected_CardID)"

        print("newTabbarController saveCard_key: \(saveCard_key)")
            
        if defaults.data(forKey: saveCard_key) != nil {
            
            CardDetails = LoadCards.loadCardsDetails(Card_ID: selected_CardID)
            
            print("CardDetails.number: \(CardDetails.Card_ID)")
            print("CardDetails.PlayerName: \(CardDetails.PlayerName)")
            
        } else {
            
            print("NO CARD DETAILS AVAILABLE")
            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabbarTableView.delegate  = self
        self.tabbarTableView.dataSource = self
        
        tabbarTableView.reloadData()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    
    @IBAction func backBtnTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.textboxCellPlaceHolderArray.count + self.switchLabelPlaceHolderArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let PlaceHolderArrayCount = textboxCellPlaceHolderArray.count - 1
        let SwitchStartingPoint =  (textboxCellPlaceHolderArray.count + switchLabelPlaceHolderArray.count) - 1
        
        switch indexPath.row {
        
        case 0...PlaceHolderArrayCount:
            
            let cell = tabbarTableView.dequeueReusableCell(withIdentifier: "cellWithTextbox") as! cellWithTextbox
            
            cell.placeHolderLabel.text = self.textboxCellPlaceHolderArray[indexPath.row]
            cell.textFieldInsideCell.placeholder = "Enter \(self.textboxCellPlaceHolderArray[indexPath.row])"
            cell.textFieldInsideCell.delegate = self
            
            print("Enter \(self.textboxCellPlaceHolderArray[indexPath.row])")
            print("\(indexPath.row)")
            
            if indexPath.row == 1 {
                
                cell.textFieldInsideCell.isEnabled = false
                cell.textFieldInsideCell.text = CardDetails.Sport
                
            } else if indexPath.row == 2 {
                
                cell.textFieldInsideCell.isEnabled = false
                cell.textFieldInsideCell.text = CardDetails.Year
                
            } else if indexPath.row == 3 {
                
                cell.textFieldInsideCell.isEnabled = false
                cell.textFieldInsideCell.text = CardDetails.Set
                
            } else if indexPath.row == 0 {
                
                CardDetails = LoadCards.loadCardsDetails(Card_ID: selected_CardID)
                
                print("CellforRow CardDetails.PlayerName: \(CardDetails.PlayerName)")
                
                cell.textFieldInsideCell.text = CardDetails.PlayerName
                cell.textFieldInsideCell.isEnabled = true
                cell.textFieldInsideCell.viewWithTag(indexPath.row)
                
            } else if indexPath.row == 4 {
                
                print("CellforRow CardDetails.VariationColour: \(CardDetails.VariationColour)")
                
                cell.textFieldInsideCell.viewWithTag(indexPath.row)
                cell.textFieldInsideCell.text = CardDetails.VariationColour
                cell.textFieldInsideCell.isEnabled = true
                
            } else if indexPath.row == 5 {
                
                print("CellforRow CardDetails.CardNo: \(CardDetails.CardNo)")
                cell.textFieldInsideCell.viewWithTag(indexPath.row)
                cell.textFieldInsideCell.text = CardDetails.CardNo
                cell.textFieldInsideCell.isEnabled = true
                
            } else {
                
                cell.textFieldInsideCell.isEnabled = true
                
            }
            
            return cell
            
        case textboxCellPlaceHolderArray.count...SwitchStartingPoint:
            
            let cell = tabbarTableView.dequeueReusableCell(withIdentifier: "cellWithSwitchButton") as! cellWithSwitchButton
            let count = indexPath.row - textboxCellPlaceHolderArray.count
            
            cell.labelSwitchCell.text = self.switchLabelPlaceHolderArray[count]
//            cell.labelSwitchCell.viewWithTag(indexPath.row)

            switch indexPath.row {
            
            case 6:
                
                cell.switchInsideCell.isHidden = false
                
                if CardDetails.Rookie == true {
                    
                    cell.switchInsideCell.isOn = true
                    
                } else {
                    cell.switchInsideCell.isOn = false
                    
                }
                
            case 7:
                
                cell.switchInsideCell.isHidden = false
                
                if CardDetails.Autograph == true {
                    
                    cell.switchInsideCell.isOn = true
                    
                } else {
                    cell.switchInsideCell.isOn = false
                    
                }
                
            case 8:
                
                cell.switchInsideCell.isHidden = false
                
                if CardDetails.Patch == true {
                    
                    cell.switchInsideCell.isOn = true
                    
                } else {
                    cell.switchInsideCell.isOn = false
                    
                }
                
            case 9:
                cell.switchInsideCell.isHidden = true

            default:
                break
            }
            
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tabbarTableView.dequeueReusableCell(withIdentifier: "cellWithTextbox") as! cellWithTextbox

        switch indexPath.row {
        
        case 0:
            
            print("Player Name Tapped")
            
        case 1:
            
            CellTapped = "Sports"
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SetViewController") as! SetViewController
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
            print("Sport tapped")
            
        case 2:
            
            CellTapped = "Year"

            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SetViewController") as! SetViewController
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
            print("year tapped")
            
        case 3:
            
            CellTapped = "SetView"

            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SetViewController") as! SetViewController
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
            print("set tapped")
            
        default:
            
            print("other Actions")
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}


// MARK: ***** Extention TableView delegate  *****


// MARK: ***** TextField Delegate Functions  *****
var playerNameString : String!
var Variation : String!
var CardNumbers: String!

extension newTabbarController: UITextFieldDelegate{
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
       
//        let cell = tabbarTableView.dequeueReusableCell(withIdentifier: "cellWithTextbox") as! cellWithTextbox
       
        let cell: UITableViewCell = textField.superview?.superview as! UITableViewCell
        var table: UITableView = cell.superview as! UITableView
        
        let textfieldIndexPath = table.indexPath(for: cell)?.row
            
        print("textfieldIndexPath -->> textFieldDidBeginEditing: \(textfieldIndexPath)")
        
        
        print(textField.text)
        
        
        switch textfieldIndexPath {
        
        case 0:
            
        print("playerNameString: \(textField.text)")
            
        playerNameString = textField.text
            
        case 4:

        print("Variation: \(textField.text)")
            
        Variation = textField.text
            
        case 5:
        print("CardNumbers: \(textField.text)")
            
        CardNumbers = textField.text
            
        default:
            break
        }
       
        print("Editing Ended")
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        print(textField.text)

        let cell: UITableViewCell = textField.superview?.superview as! UITableViewCell
        var table: UITableView = cell.superview as! UITableView
        
        let textfieldIndexPath = table.indexPath(for: cell)?.row
            
        print("textfieldIndexPath -->> textFieldDidEndEditing : \(textfieldIndexPath)")
        
     
        
        switch textfieldIndexPath {
        
        case 0:
            print(textField.text)
            print(StartText)
            
            Homedetails.Name = textField.text
            
            SaveHome(HomeMaster: Homedetails, cardID: selected_CardID)
            
            CardDetails.PlayerName = textField.text
            print("Name Saved under Home Details and CardDetails after editing")

            SaveCards.saveCardsvalue(CardsValue: CardDetails, Card_ID: selected_CardID)
            
            
        case 4:
            print(textField.text)

            
            CardDetails.VariationColour = textField.text
            print("Variation Colour Saved in Card Details after editing")
            SaveCards.saveCardsvalue(CardsValue: CardDetails, Card_ID: selected_CardID)
            
            
            
        case 5:
            print(textField.text)

            CardDetails.CardNo = (textField.text ?? "0")
            print("CardNo Saved in Card Details after editing")

            SaveCards.saveCardsvalue(CardsValue: CardDetails, Card_ID: selected_CardID)
            
        default:
            break
        }
            
       
        print("Editing Ended")
        
    }
    
}


// MARK: ***** TableViewCell Class Functions  *****

class cellWithTextbox: UITableViewCell{
    
    @IBOutlet weak var placeHolderLabel: UILabel!
    @IBOutlet weak var textFieldInsideCell: UITextField!
    
    static var identifier = "cellWithTextbox"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        
      
    }
}

class cellWithSwitchButton: UITableViewCell {
    
    @IBOutlet weak var labelSwitchCell: UILabel!
    @IBOutlet weak var switchInsideCell: UISwitch!
    
    static var identifier = "cellWithSwitchButton"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
        
        switchInsideCell.addTarget(self, action: #selector(SwitchChanged), for: .valueChanged)
        
    }
    
    @objc func SwitchChanged(mySwitch: UISwitch) {
        
        let value = mySwitch.isOn
        
        print("Switch value: \(value)")
        
        let cell: UITableViewCell = mySwitch.superview?.superview as! UITableViewCell
        let table: UITableView = cell.superview as! UITableView
        
        let switchIndexPath = table.indexPath(for: cell)?.row
            
        print("switchIndexPath -->> switchDidBeginEditing: \(switchIndexPath)")
        
        switch switchIndexPath {
        
        case 6:
            
            CardDetails.Rookie = value
            SaveCards.saveCardsvalue(CardsValue: CardDetails, Card_ID: selected_CardID)
            
        case 7:
            
            CardDetails.Autograph = value
            SaveCards.saveCardsvalue(CardsValue: CardDetails, Card_ID: selected_CardID)

        case 8:
            
            CardDetails.Patch = value
            SaveCards.saveCardsvalue(CardsValue: CardDetails, Card_ID: selected_CardID)
            
        default:
            break
        }

    }
    
}


// MARK: ***** extention UIView Top and Bottom border  *****


