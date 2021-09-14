//
//  HomeMaster.swift
//  GradesGuru
//
//  Created by Superpower on 22/09/20.
//  Copyright © 2020 iMac superpower. All rights reserved.
//


import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseFirestore

var Homedetails : HomeMaster = HomeMaster(device_ID: "", CardID: "", DisplayCardPicture: Date(), Name: "Enter Name", SubTitle: "Enter SubTitle", PSA: "0.0", BGS: "0.0",  SGC: "0.0", ScanTime: Date())

class HomeMaster : NSObject, NSCoding {
    
    var device_ID: String!
    var CardID: String!
    var DisplayCardPicture: Date!
    var Name: String!
    var SubTitle: String!
    var PSA: String!
    var BGS: String!
    var SGC: String!
    var ScanTime: Date!
    

    init(device_ID: String, CardID: String, DisplayCardPicture: Date, Name: String, SubTitle: String, PSA:  String, BGS:  String,  SGC:  String, ScanTime: Date) {
        
        self.device_ID = device_ID
        self.CardID = CardID
        self.DisplayCardPicture = DisplayCardPicture
        self.Name = Name
        self.SubTitle = SubTitle
        self.PSA = PSA
        self.BGS = BGS
        self.SGC = SGC
        self.ScanTime = ScanTime
        
    }
    
    required init!(coder aDecoder: NSCoder) {
        
        self.device_ID = (aDecoder.decodeObject(forKey: "device_ID") as! String)
        self.CardID = (aDecoder.decodeObject(forKey: "CardID") as! String)
        self.DisplayCardPicture = (aDecoder.decodeObject(forKey: "DisplayCardPicture") as! Date)
        self.Name = (aDecoder.decodeObject(forKey: "Name") as! String)
        self.SubTitle = (aDecoder.decodeObject(forKey: "SubTitle") as! String)
        self.PSA = (aDecoder.decodeObject(forKey: "PSA") as! String)
        self.BGS = (aDecoder.decodeObject(forKey: "BGS") as! String)
        self.SGC = (aDecoder.decodeObject(forKey: "SGC") as! String)
        self.ScanTime = (aDecoder.decodeObject(forKey: "ScanTime") as! Date)
        
        super.init()
        
       }

    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(device_ID, forKey: "device_ID")
        aCoder.encode(CardID, forKey: "CardID")
        aCoder.encode(DisplayCardPicture, forKey: "DisplayCardPicture")
        aCoder.encode(Name, forKey: "Name")
        aCoder.encode(SubTitle, forKey: "SubTitle")
        aCoder.encode(PSA, forKey: "PSA")
        aCoder.encode(BGS, forKey: "BGS")
        aCoder.encode(SGC, forKey: "SGC")
        aCoder.encode(ScanTime, forKey: "ScanTime")
    
    }

}

func SaveHome(HomeMaster: HomeMaster, cardID: String) {
    
//    let cardID = HomeMaster.CardID!
    
    let key = "Home: \(cardID)"
    
    print("SaveHome key, \(key)")

    let defaults =  UserDefaults.standard
       
    guard let encodedData = try? NSKeyedArchiver.archivedData(withRootObject: HomeMaster, requiringSecureCoding: false)
    
    //archivedData(withRootObject: category as Array, requiringSecureCoding: false) as NSData
                else {
            fatalError("Can't encode data")
        }

        defaults.set(encodedData, forKey: key)

    
}

func LoadHome(cardID: String) -> HomeMaster {
    
    let key = "Home: \(cardID)"
    let defaults =  UserDefaults.standard

    print("Load Home, Key : \(key)")

    let data = defaults.data(forKey: key)

    return try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data!) as! HomeMaster
    
}



