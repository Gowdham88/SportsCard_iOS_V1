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

var Homedetails : HomeMaster = HomeMaster(device_ID: "", CardID: "", DisplayCardPicture: Date(), Name: "", PSA: 1, BGS: 2,  SGC: 3, ScanTime: Date())

class HomeMaster : NSObject {
    

    
    var device_ID: String!
    var CardID: String!
    var DisplayCardPicture: Date!
    var Name: String!
    var PSA: Int!
    var BGS: Int!
    var SGC: Int!
    var ScanTime: Date!
    

    init(device_ID: String, CardID: String, DisplayCardPicture: Date, Name: String, PSA: Int, BGS: Int,  SGC: Int, ScanTime: Date) {
        
        self.device_ID = device_ID
        self.CardID = CardID
        self.DisplayCardPicture = DisplayCardPicture
        self.Name = Name
        self.PSA = PSA
        self.BGS = BGS
        self.SGC = SGC
        self.ScanTime = ScanTime
        
    }
    
    func LoadHome() {
        
        
    }
    
    
    
}

func UpdateHome(HomeMaster: HomeMaster) {
    
    
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



