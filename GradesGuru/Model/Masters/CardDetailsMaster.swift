//
//  CardDetailsMaster.swift
//  GradesGuru
//
//  Created by Superpower on 22/09/20.
//  Copyright © 2020 iMac superpower. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseFirestore

var CardDetails : CardDetailsMaster = CardDetailsMaster(Device_ID: "", Card_ID: "", Card_frontImage : UIImage(named: "Scan")!, Card_BackImage : UIImage(named: "Scan")!, PlayerName : "", Sport : 2, Year : 1234, Set : "", VariationColour : "", CardNo : 1, Rookie : 2, Autograph: "", Patch: "", ScannedDate: "")

var CardIDs = [String]()

class CardDetailsMaster : NSObject, NSCoding {
    
    
    
    var Device_ID: String!
    var Card_ID: String!
    var Card_frontImage: UIImage!
    var Card_BackImage: UIImage!
    var PlayerName : String!
    var Sport : Int!
    var Year : Int!
    var Set : String!
    var VariationColour : String!
    var CardNo : Int!
    var Rookie : Int!
    var Autograph: String!
    var Patch: String!
    var ScannedDate: String!
    
    init(Device_ID: String, Card_ID: String, Card_frontImage : UIImage, Card_BackImage: UIImage, PlayerName : String, Sport : Int, Year : Int, Set : String, VariationColour : String, CardNo : Int, Rookie : Int, Autograph: String, Patch: String, ScannedDate: String) {
        
        self.Device_ID = Device_ID
        self.Card_ID = Card_ID
        self.Card_frontImage = Card_frontImage
        self.Card_BackImage = Card_BackImage
        self.PlayerName = PlayerName
        self.Sport = Sport
        self.Year = Year
        self.Set = Set
        self.VariationColour = VariationColour
        self.CardNo = CardNo
        self.Rookie = Rookie
        self.Autograph = Autograph
        self.Patch = Patch
        self.ScannedDate = ScannedDate
        
    }
    
    required init!(coder aDecoder: NSCoder) {
        
        self.Device_ID = (aDecoder.decodeObject(forKey: "Device_ID") as! String)
        self.Card_ID = (aDecoder.decodeObject(forKey: "Card_ID") as! String)
        self.Card_frontImage = (aDecoder.decodeObject(forKey: "Card_frontImage") as! UIImage)
        self.Card_BackImage = (aDecoder.decodeObject(forKey: "Card_BackImage") as! UIImage)
        self.Sport = (aDecoder.decodeObject(forKey: "Sport") as! Int)
        self.Year = (aDecoder.decodeObject(forKey: "Year") as! Int)
        self.Set = (aDecoder.decodeObject(forKey: "Set") as! String)
        self.VariationColour = (aDecoder.decodeObject(forKey: "VariationColour") as! String)
        self.CardNo = (aDecoder.decodeObject(forKey: "CardNo") as! Int)
        self.Rookie = (aDecoder.decodeObject(forKey: "Rookie") as! Int)
        self.Autograph = (aDecoder.decodeObject(forKey: "Autograph") as! String)
        self.Patch = (aDecoder.decodeObject(forKey: "Patch") as! String)
        self.ScannedDate = (aDecoder.decodeObject(forKey: "ScannedDate") as! String)
        
        super.init()
        
       }

    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(Device_ID, forKey: "Device_ID")
        aCoder.encode(Card_ID, forKey: "Card_ID")
        aCoder.encode(Card_frontImage, forKey: "Card_frontImage")
        aCoder.encode(Card_BackImage, forKey: "Card_BackImage")
        aCoder.encode(Sport, forKey: "Sport")
        aCoder.encode(Year, forKey: "Year")
        aCoder.encode(Set, forKey: "Set")
        aCoder.encode(VariationColour, forKey: "VariationColour")
        aCoder.encode(CardNo, forKey: "CardNo")
        aCoder.encode(Rookie, forKey: "Rookie")
        aCoder.encode(Autograph, forKey: "Autograph")
        aCoder.encode(Patch, forKey: "Patch")
        aCoder.encode(ScannedDate, forKey: "ScannedDate")
    
    }
    
}

class SaveCards {
    
    static func saveCardsvalue(CardsValue: CardDetailsMaster, Card_ID: String) {
    
            print("Cards Saved: Card_ID: \(Card_ID)")
        
    
            let defaults =  UserDefaults.standard
           
        guard let encodedData = try? NSKeyedArchiver.archivedData(withRootObject: CardsValue, requiringSecureCoding: false)
        
        //archivedData(withRootObject: category as Array, requiringSecureCoding: false) as NSData
                    else {

                fatalError("Can't encode data")
            
            }
        
            defaults.set(encodedData, forKey: Card_ID)
    
        }
    
    static func saveCardIDs(Cards: [String], Device_ID: String) {
    
            print("Card IDs Saved: Cards \(Cards) , Device_ID: \(Device_ID)")
    
            let defaults =  UserDefaults.standard
           
        guard let encodedData = try? NSKeyedArchiver.archivedData(withRootObject: Cards, requiringSecureCoding: false)
        
        //archivedData(withRootObject: category as Array, requiringSecureCoding: false) as NSData
                    else {
            

                fatalError("Can't encode data")
            }
    
            defaults.set(encodedData, forKey: Device_ID)
    
        }
    
    }

class LoadCards {
    
    static func loadCardsDetails(Card_ID: String) -> CardDetailsMaster  {
    
            let defaults =  UserDefaults.standard
    
            let data = defaults.data(forKey: Card_ID)
    
            return try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data!) as! CardDetailsMaster
        
        }
    
    static func loadCardIDs(Device_ID: String?) -> [String] {
    
            let defaults =  UserDefaults.standard
    
        let data = defaults.data(forKey: Device_ID!)
    
            return try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data!) as! [String]
        
        }

}

func UpdateCardDetails(CardDetailsMaster: CardDetailsMaster) {
    
    
//    let docData = ["device_ID": Users.device_ID!,
//        "Subscription_Status": Users.Subscription_Status!,
//        "Subscription_Date": Users.Subscription_Date!,
//        "Subscription_Type": Users.Subscription_Type!,
//        "Cost": Users.Cost!,
//        "CurrentScan_Count": Users.CurrentScan_Count! ] as [String : Any]
//
//
//    db.collection("Users").document(Users.device_ID).setData(docData) { err in
//        if let err = err {
//            print("Error writing document: \(err)")
//        } else {
//            print("Document successfully written!")
//        }
//    }
//
    
}

