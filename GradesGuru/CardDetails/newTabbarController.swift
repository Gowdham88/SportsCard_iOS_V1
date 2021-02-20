//
//  newTabbarController.swift
//  TabbarDesignImplementation
//
//  Created by Superpower on 17/08/20.
//  Copyright © 2020 iMac superpower. All rights reserved.
//

import Foundation
import UIKit
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
      
        self.tabbarTableView.delegate  = self
        self.tabbarTableView.dataSource = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    
    @IBAction func backBtnTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.textboxCellPlaceHolderArray.count + self.switchLabelPlaceHolderArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let PlaceHolderArrayCount = textboxCellPlaceHolderArray.count - 1
        let SwitchStartingPoint =  (textboxCellPlaceHolderArray.count + switchLabelPlaceHolderArray.count) - 1
        switch indexPath.row{
        case 0...PlaceHolderArrayCount:
            let cell = tabbarTableView.dequeueReusableCell(withIdentifier: "cellWithTextbox") as! cellWithTextbox
            cell.placeHolderLabel.text = self.textboxCellPlaceHolderArray[indexPath.row]
            cell.textFieldInsideCell.placeholder = "Enter \(self.textboxCellPlaceHolderArray[indexPath.row])"
            cell.textFieldInsideCell.delegate = self
            if indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3 {
                cell.textFieldInsideCell.isEnabled = false
            }else{
                cell.textFieldInsideCell.isEnabled = true
            }
            
            return cell
        case textboxCellPlaceHolderArray.count...SwitchStartingPoint:
            let cell = tabbarTableView.dequeueReusableCell(withIdentifier: "cellWithSwitchButton") as! cellWithSwitchButton
            let count = indexPath.row - textboxCellPlaceHolderArray.count
            cell.labelSwitchCell.text = self.switchLabelPlaceHolderArray[count]
            if indexPath.row == 9{
                cell.switchInsideCell.isHidden = true
            }else{
                cell.switchInsideCell.isHidden = false
                
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row{
        case 1:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SportViewController") as! SportViewController
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
            print("Sport tapped")
        case 2:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "YearViewController") as! YearViewController
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
            print("year tapped")
        case 3:
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

extension newTabbarController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
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

class cellWithSwitchButton: UITableViewCell{
    
    
    @IBOutlet weak var labelSwitchCell: UILabel!
    @IBOutlet weak var switchInsideCell: UISwitch!
    
    static var identifier = "cellWithSwitchButton"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        
    }
}


// MARK: ***** extention UIView Top and Bottom border  *****


