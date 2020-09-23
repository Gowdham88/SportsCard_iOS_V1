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

var CardDetails : CardDetailsMaster = CardDetailsMaster(device_ID: "", CardID: "", PlayerName : "", Sport : 2, Year : 1234, Set : "", VariationColour : "", CardNo : 1, Rookie : 2, Autograph: "", Patch: "", ScannedDate: Date())

class CardDetailsMaster : NSObject {
    
    var device_ID: String!
    var CardID: String!
    var PlayerName : String!
    var Sport : Int!
    var Year : Int!
    var Set : String!
    var VariationColour : String!
    var CardNo : Int!
    var Rookie : Int!
    var Autograph: String!
    var Patch: String!
    var ScannedDate: Date!
    
    init(device_ID: String, CardID: String, PlayerName : String, Sport : Int, Year : Int, Set : String, VariationColour : String, CardNo : Int, Rookie : Int, Autograph: String, Patch: String, ScannedDate: Date) {
        
        self.device_ID = device_ID
        self.CardID = CardID
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
    
    func LoadCardDetails() {
        
        
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

