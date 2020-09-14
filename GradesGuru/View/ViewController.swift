//
//  ViewController.swift
//  GradesGuru
//
//  Created by Superpower on 16/08/20.
//  Copyright © 2020 iMac superpower. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
   
    var GradeDetails = ["Centering", "Corners", "Surface", "Edges"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
       
        
        
    }
    
     func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }


     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
              
        var cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier")

               if cell == nil {
                   cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cellIdentifier")
               }

               cell!.textLabel?.text = GradeDetails[indexPath.row]
               cell!.detailTextLabel?.text = "Review"

               return cell!
       }
     
}

