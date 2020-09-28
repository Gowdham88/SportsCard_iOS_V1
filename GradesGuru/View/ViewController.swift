//
//  ViewController.swift
//  GradesGuru
//
//  Created by Superpower on 16/08/20.
//  Copyright © 2020 iMac superpower. All rights reserved.
//

import UIKit
import Segmentio

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
   
    @IBOutlet weak var segmentioView: Segmentio!
    
    var content = [SegmentioItem]()
    let PSAtitle = SegmentioItem(title: "PSA", image: nil)
    let BGStitle = SegmentioItem(title: "BGS", image: nil)
    let SGCtitle = SegmentioItem(title: "SGC", image: nil)
    
    var GradeDetails = ["Centering", "Corners", "Surface", "Edges"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        content.append(PSAtitle)
        content.append(BGStitle)
        content.append(SGCtitle)
        
        segmentioView.setup(content: content, style: .onlyLabel, options: SegmentioOptions(backgroundColor: .white, segmentPosition: .dynamic, scrollEnabled: true, indicatorOptions: SegmentioIndicatorOptions(type: .bottom, ratio: 1.0, height: 5.0, color: UIColor(red: 83.0, green: 117.0, blue: 252.0, alpha: 1.0)), horizontalSeparatorOptions: SegmentioHorizontalSeparatorOptions(type: SegmentioHorizontalSeparatorType.bottom, height: 0.5, color: .lightGray), verticalSeparatorOptions: SegmentioVerticalSeparatorOptions(ratio: 0, color: .gray), imageContentMode: .center, labelTextAlignment: .center, labelTextNumberOfLines: 1, segmentStates: SegmentioStates(defaultState: SegmentioState(backgroundColor: .clear,titleFont:UIFont.systemFont(ofSize: UIFont.smallSystemFontSize),titleTextColor: .black),selectedState: SegmentioState(backgroundColor: UIColor(red: 83.0/255.0, green: 117.0/255.0, blue: 252.0/255.0, alpha: 1.0),titleFont: UIFont.systemFont(ofSize: UIFont.smallSystemFontSize),titleTextColor: .white),highlightedState: SegmentioState(backgroundColor: UIColor.lightGray.withAlphaComponent(0.6),titleFont:UIFont.boldSystemFont(ofSize: UIFont.smallSystemFontSize),titleTextColor: .black)), animationDuration: 0.1))
    
        segmentioView.selectedSegmentioIndex = 0
        
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

