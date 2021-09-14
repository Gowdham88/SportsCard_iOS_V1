//
//  SportViewController.swift
//  TabbarDesignImplementation
//
//  Created by Superpower on 17/08/20.
//  Copyright © 2020 iMac superpower. All rights reserved.
//

import UIKit


class SportViewController: UIViewController {

    // MARK: ***** Variables and outlets  *****
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var titleLAbel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var sportsTableView: UITableView!
    
    var sportData = ["BasketBall", "Hockey", "Cricket", "ice Polo", "Swimming"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.sportsTableView.delegate = self
        self.sportsTableView.dataSource = self
        
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

// MARK: ***** TableView Delegate methods  *****

extension SportViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sportData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = sportsTableView.dequeueReusableCell(withIdentifier: "sportsCell") as! sportsCell
        cell.sportsCellTextValue.text = sportData[indexPath.row].capitalized
        return cell
        
    }
    
    
}


// MARK: ***** TableViewCell Class Functions  *****

class sportsCell: UITableViewCell{
    
    @IBOutlet weak var sportsCellTextValue: UILabel!
    static var identifier = "sportsCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
}
