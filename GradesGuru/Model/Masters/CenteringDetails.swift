//
//  CenteringDetails.swift
//  GradesGuru
//
//  Created by Superpower on 22/09/20.
//  Copyright © 2020 iMac superpower. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseFirestore

var CenteringDetails : CenteringMaster = CenteringMaster(device_ID: "", CardID: "", FrontScan: "", BackScan: "", Right: 1, Left: 2, Top: 3, Bottom: 4, Border1X: 1.0, Border2X: 1.0, Border3X: 1.0, Border4X: 1.0, Border1Y: 1.0, Border2Y: 1.0, Border3Y: 1.0, Border4Y: 1.0)

class CenteringMaster : NSObject {
    
    var device_ID: String!
    var CardID: String!
    var FrontScan: String!
    var BackScan: String!
    var Right: Int!
    var Left: Int!
    var Top: Int!
    var Bottom: Int!
    var Border1X: Float!
    var Border2X: Float!
    var Border3X: Float!
    var Border4X: Float!
    var Border1Y: Float!
    var Border2Y: Float!
    var Border3Y: Float!
    var Border4Y: Float!
    

    init(device_ID: String, CardID: String, FrontScan: String, BackScan: String, Right: Int, Left: Int, Top: Int, Bottom: Int, Border1X: Float, Border2X: Float, Border3X: Float, Border4X: Float, Border1Y: Float, Border2Y: Float, Border3Y: Float, Border4Y: Float) {
        
        self.device_ID = device_ID
        self.CardID = CardID
        self.FrontScan = FrontScan
        self.BackScan = BackScan
        self.Right = Right
        self.Left = Left
        self.Top = Top
        self.Bottom = Bottom
        self.Border1X = Border1X
        self.Border2X = Border2X
        self.Border3X = Border3X
        self.Border4X = Border4X
        self.Border1Y = Border1Y
        self.Border2Y = Border2Y
        self.Border3Y = Border3Y
        self.Border4Y = Border4Y
        
    }
    
    func LoadCentering() {
        
        
    }
    
    
    
}

func UpdateCentering(CenteringMaster: CenteringMaster) {
    
    
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



