//
//  SetViewController.swift
//  TabbarDesignImplementation
//
//  Created by Superpower on 17/08/20.
//  Copyright © 2020 iMac superpower. All rights reserved.
//
import UIKit

class SetViewController: UIViewController {

    // MARK: ***** Variables and outlets  *****
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var titleLAbel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var setTAbleView: UITableView!
    @IBOutlet weak var setSearchTabbar: UISearchBar!
    
    var setData = ["set Data 0", "set Data 1", "set Data 2", "set Data 3", "set Data 4", "set Data 5", "set Data 6", "set Data 7", "set Data 8", "set Data 9", "set Data 10", "set Data 11", "set Data 12", "set Data 13", "set Data 14"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setTAbleView.delegate = self
        self.setTAbleView.dataSource = self
        
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
        return setData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = setTAbleView.dequeueReusableCell(withIdentifier: "sportsCell") as! sportsCell
        cell.sportsCellTextValue.text = setData[indexPath.row].capitalized
        return cell
        
    }
    
}
