//
//  CenteringDetails.swift
//  GradesGuru
//
//  Created by Superpower on 22/09/20.
//  Copyright © 2020 iMac superpower. All rights reserved.
//

import Foundation
import UIKit
import CoreXLSX
import Firebase
import FirebaseFirestoreSwift
import FirebaseFirestore

var CenteringDetails : CenteringMaster = CenteringMaster(device_ID: "", CardID: "", FrontScan: "", BackScan: "", FrontRight: 0, FrontLeft: 0, FrontTop: 0, FrontBottom: 0, BackRight: 0, BackLeft: 0, BackTop: 0, BackBottom: 0, SelectedPSA: 0, SelectedBGS: 0, SelectedSGC: 0)

class CenteringMaster : NSObject, NSCoding {
    
    var device_ID: String!
    var CardID: String!
    var FrontScan: String!
    var BackScan: String!
    var FrontRight: Int!
    var FrontLeft: Int!
    var FrontTop: Int!
    var FrontBottom: Int!
    var BackRight: Int!
    var BackLeft: Int!
    var BackTop: Int!
    var BackBottom: Int!
    var SelectedPSA: Int!
    var SelectedBGS: Int!
    var SelectedSGC: Int!
    

    init(device_ID: String, CardID: String, FrontScan: String, BackScan: String, FrontRight: Int, FrontLeft: Int, FrontTop: Int, FrontBottom: Int, BackRight: Int, BackLeft: Int, BackTop: Int, BackBottom: Int, SelectedPSA: Int, SelectedBGS: Int, SelectedSGC: Int) {
        
        self.device_ID = device_ID
        self.CardID = CardID
        self.FrontScan = FrontScan
        self.BackScan = BackScan
        self.FrontRight = FrontRight
        self.FrontLeft = FrontLeft
        self.FrontTop = FrontTop
        self.FrontBottom = FrontBottom
        self.BackRight = BackRight
        self.BackLeft = BackLeft
        self.BackTop = BackTop
        self.BackBottom = BackBottom
        self.SelectedPSA = SelectedPSA
        self.SelectedBGS = SelectedBGS
        self.SelectedSGC = SelectedSGC
        
    }
    
    required init!(coder aDecoder: NSCoder) {
        
        self.device_ID = (aDecoder.decodeObject(forKey: "device_ID") as! String)
        self.CardID = (aDecoder.decodeObject(forKey: "CardID") as! String)
        self.FrontScan = (aDecoder.decodeObject(forKey: "FrontScan") as! String)
        self.BackScan = (aDecoder.decodeObject(forKey: "BackScan") as! String)
        self.FrontRight = (aDecoder.decodeObject(forKey: "FrontRight") as! Int)
        self.FrontLeft = (aDecoder.decodeObject(forKey: "FrontLeft") as! Int)
        self.FrontTop = (aDecoder.decodeObject(forKey: "FrontTop") as! Int)
        self.FrontBottom = (aDecoder.decodeObject(forKey: "FrontBottom") as! Int)
        self.BackRight = (aDecoder.decodeObject(forKey: "BackRight") as! Int)
        self.BackLeft = (aDecoder.decodeObject(forKey: "BackLeft") as! Int)
        self.BackTop = (aDecoder.decodeObject(forKey: "BackTop") as! Int)
        self.BackBottom = (aDecoder.decodeObject(forKey: "BackBottom") as! Int)
        self.SelectedPSA = (aDecoder.decodeObject(forKey: "SelectedPSA") as! Int)
        self.SelectedBGS = (aDecoder.decodeObject(forKey: "SelectedBGS") as! Int)
        self.SelectedSGC = (aDecoder.decodeObject(forKey: "SelectedSGC") as! Int)
        
     
        super.init()
        
       }

    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(device_ID, forKey: "device_ID")
        aCoder.encode(CardID, forKey: "CardID")
        aCoder.encode(FrontScan, forKey: "FrontScan")
        aCoder.encode(BackScan, forKey: "BackScan")
        
        aCoder.encode(FrontRight, forKey: "FrontRight")
        aCoder.encode(FrontLeft, forKey: "FrontLeft")
        aCoder.encode(FrontTop, forKey: "FrontTop")
        aCoder.encode(FrontBottom, forKey: "FrontBottom")
        
        aCoder.encode(BackRight, forKey: "BackRight")
        aCoder.encode(BackLeft, forKey: "BackLeft")
        aCoder.encode(BackTop, forKey: "BackTop")
        aCoder.encode(BackBottom, forKey: "BackBottom")
        
        aCoder.encode(SelectedPSA, forKey: "SelectedPSA")
        aCoder.encode(SelectedBGS, forKey: "SelectedBGS")
        aCoder.encode(SelectedSGC, forKey: "SelectedSGC")
        
    }
    
}

class SaveCentering {
    
    static func updateCentering(CenteringMaster: CenteringMaster, cardID: String) {
        
        print("Border Saved")

        let defaults =  UserDefaults.standard
        guard let encodedData = try? NSKeyedArchiver.archivedData(withRootObject: CenteringMaster, requiringSecureCoding: false)
        
        //archivedData(withRootObject: category as Array, requiringSecureCoding: false) as NSData
                else {
            fatalError("Can't encode data")
        }
                               
        defaults.set(encodedData, forKey: "center_cardID:\(cardID)")
        
    }

    static func loadCentering(cardID: String) -> CenteringMaster  {
        
        let defaults =  UserDefaults.standard
        
        let data = defaults.data(forKey: "center_cardID:\(cardID)")
        
        return try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data!) as! CenteringMaster
    }
    
}



