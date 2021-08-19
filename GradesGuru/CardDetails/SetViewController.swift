//
//  SetViewController.swift
//  TabbarDesignImplementation
//
//  Created by Superpower on 17/08/20.
//  Copyright © 2020 iMac superpower. All rights reserved.
//
import UIKit
var CellTapped: String!

class SetViewController: UIViewController {

    // MARK: ***** Variables and outlets  *****
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var titleLAbel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var setTAbleView: UITableView!
    @IBOutlet weak var setSearchTabbar: UISearchBar!
    
    var TableData = [String]()

    var sportData = ["BasketBall", "Hockey", "Cricket", "ice Polo", "Swimming"]

    var yearData = ["2020", "2019", "2018", "2017", "2016", "2015", "2014", "2013", "2012", "2011", "2010", "2009", "2008", "2007", "2006", "2005", "2004", "2003", "2002","2001", "2000"]

    var setData = ["set Data 0", "set Data 1", "set Data 2", "set Data 3", "set Data 4", "set Data 5", "set Data 6", "set Data 7", "set Data 8", "set Data 9", "set Data 10", "set Data 11", "set Data 12", "set Data 13", "set Data 14"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setTAbleView.delegate = self
        self.setTAbleView.dataSource = self
        
        switch CellTapped {
        
        case "Sports":
            titleLAbel.text = "Select Sport"
            TableData = sportData

        case "Year":
            titleLAbel.text = "Select Year"
            TableData = yearData

        case "SetView":
            titleLAbel.text = "Select Set"
            TableData = setData
            
        default:
            break
        }
        
        setTAbleView.reloadData()
        // Do any additional setup after loading the view.

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    @IBAction func backAction(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
}

// MARK: ***** TableView Delegate methods  *****

extension SetViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return TableData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch CellTapped {
        
        case "Sports":
            
            CardDetails.Sport = TableData[indexPath.row]
            SaveCards.saveCardsvalue(CardsValue: CardDetails, Card_ID: selected_CardID)

        case "Year":
            
            CardDetails.Year = TableData[indexPath.row]
            SaveCards.saveCardsvalue(CardsValue: CardDetails, Card_ID: selected_CardID)

        case "SetView":
            
            CardDetails.Set = TableData[indexPath.row]
            SaveCards.saveCardsvalue(CardsValue: CardDetails, Card_ID: selected_CardID)

        default:
            break
        }
        
        self.dismiss(animated: true, completion: nil)

        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = setTAbleView.dequeueReusableCell(withIdentifier: "sportsCell") as! sportsCell
        
        cell.sportsCellTextValue.text = TableData[indexPath.row].capitalized
        
        return cell
        
    }
    
}
