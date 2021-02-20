//
//  YearViewController.swift
//  TabbarDesignImplementation
//
//  Created by Superpower on 17/08/20.
//  Copyright © 2020 iMac superpower. All rights reserved.
//

import UIKit

class YearViewController: UIViewController {


    // MARK: ***** Variables and outlets  *****
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var titleLAbel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var yearTAbleView: UITableView!
    
    var yearData = ["2020", "2019", "2018", "2017", "2016", "2015", "2014", "2013", "2012", "2011", "2010", "2009", "2008", "2007", "2006", "2005", "2004", "2003", "2002","2001", "2000"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.yearTAbleView.delegate = self
        self.yearTAbleView.dataSource = self
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

extension YearViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return yearData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = yearTAbleView.dequeueReusableCell(withIdentifier: "sportsCell") as! sportsCell
        cell.sportsCellTextValue.text = yearData[indexPath.row].capitalized
        return cell
        
    }
    
}
