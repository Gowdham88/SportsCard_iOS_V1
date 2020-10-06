//
//  CardDetailsVC.swift
//  GradesGuru
//
//  Created by Superpower on 28/09/20.
//  Copyright © 2020 iMac superpower. All rights reserved.
//

import UIKit

class CardDetailsVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var mytableView: UITableView!
    @IBOutlet weak var pickerView: UIPickerView!
    
    var selectedRow = "Sport"
    var sports = ["Baseball","Basketball","Football","Hockey","Soccer","Boxing","Golf"]
    var sportsyear = ["2008", "2009","2010","2011","2012","2013","2014","2015","2016","2017","2018","2019","2020"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.backgroundColor = .white
        pickerView.showsSelectionIndicator = true
        pickerView.delegate = self
        pickerView.dataSource = self

        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.donePicker))

        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true

//        view.inputView = pickerView
//        view.inputAccessoryView = toolBar
//        PickerandTable(tableviewalpha: 1, pickerviewalpha: 0.5)
// Do any additional setup after loading the view.
        
    }
    
    
    @objc func donePicker () {
        
        
        
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        print("selectedRow: \(selectedRow)")
        
        switch selectedRow {
        
        case "Sport":
        print("Sport selected")
        
        
        return sports.count

        case "Year":
        print("Year selected")
        return sportsyear.count
        
        default:
        return 0
        
        }
        
    }
    
    
//    func PickerandTable(tableviewalpha: CGFloat, pickerviewalpha: CGFloat) {
//
//        mytableView.alpha = tableviewalpha
//        pickerView.alpha = pickerviewalpha
//
//    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        switch selectedRow {
        
        case "Sport":
        print("Sport selected")
        
        return sports[row]

        case "Year":
        print("Year selected")
        return sportsyear[row]
        
        default:
        return ""
        
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell\(indexPath.row)", for: indexPath)
        
        switch indexPath.row {
        
        case 0:
        print("Player Name")

        case 1:
        print("Year")
        
        case 2:
        print("Sport")
        
        case 3:
        print("Set")
        
        case 4:
        print("Variation/Color")
        
        case 5:
        print("Card#")
        
        case 6:
        print("Rookie")
            
        case 7:
        print("Autograph")
            
        case 8:
        print("Patch")
        
        case 9:
            print("Scanned")
        
        default:
            break
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.row {
        
        case 9:
        return 151.0
        
        default:
            return 51.0
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                
        switch indexPath.row {
        
        case 0:
        print("Player Name")

        case 1:
        selectedRow = "Sport"
        
//        PickerandTable(tableviewalpha: 0.5, pickerviewalpha: 1)
        print("Sport")
        
        case 2:
        selectedRow = "Year"
//        PickerandTable(tableviewalpha: 0.5, pickerviewalpha: 1)
        
        print("Year")
        
        case 3:
        print("Set")
        
        case 4:
        print("Variation/Color")
        
        case 5:
        print("Card#")
        
        case 6:
        print("Rookie")
            
        case 7:
        print("Autograph")
            
        case 8:
        print("Patch")
        
        case 9:
        print("Scanned")
        
        default:
            
        selectedRow = ""
        pickerView.reloadAllComponents()
        
        break
            
        }

        pickerView.reloadAllComponents()

        
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
