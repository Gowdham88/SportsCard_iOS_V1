//
//  ScanDetails.swift
//  GradesGuru
//
//  Created by Superpower on 22/09/20.
//  Copyright © 2020 iMac superpower. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseFirestore

var ScanDetails : ScanMaster = ScanMaster(device_ID: "", CardID: "",
PlayerName: "",Year: 2018, Team: "", FrontScan: "",BackScan: "", GradingEstimate: 1, PSACentering: 2, PSACorner: 3,PSASurface: 4, PSAEdges: 5, BGSCentering: 6, BGSCorner: 7, BGSSurface: 8, BGSEdges: 9, SGCCentering: 10, SGCCorner: 11, SGCSurface: 12, SGCEdges: 13, PopReport: "", FindonEbay: "")

class ScanMaster : NSObject {
    
    var device_ID: String!
    var CardID: String!
    var PlayerName: String!
    var Year: Int!
    var Team: String!
    var FrontScan: String!
    var BackScan: String!
    var GradingEstimate: Int!
    var PSACentering: Int!
    var PSACorner: Int!
    var PSASurface: Int!
    var PSAEdges: Int!
    var BGSCentering: Int!
    var BGSCorner: Int!
    var BGSSurface: Int!
    var BGSEdges: Int!
    var SGCCentering: Int!
    var SGCCorner: Int!
    var SGCSurface: Int!
    var SGCEdges: Int!
    var PopReport: String!
    var FindonEbay: String!
    
    

    init(device_ID: String, CardID: String,
PlayerName: String,Year: Int, Team: String, FrontScan: String,BackScan: String, GradingEstimate: Int, PSACentering: Int, PSACorner: Int,PSASurface: Int, PSAEdges: Int, BGSCentering: Int, BGSCorner: Int, BGSSurface: Int, BGSEdges: Int, SGCCentering: Int, SGCCorner: Int, SGCSurface: Int, SGCEdges: Int, PopReport: String, FindonEbay: String) {
        
        self.device_ID = device_ID
        self.CardID = CardID
        self.PlayerName = PlayerName
        self.Year = Year
        self.Team = Team
        self.FrontScan = FrontScan
        self.BackScan = BackScan
        self.GradingEstimate = GradingEstimate
        self.PSACentering = PSACentering
        self.PSACorner = PSACorner
        self.PSASurface = PSASurface
        self.PSAEdges = PSAEdges
        self.BGSCentering = BGSCentering
        self.BGSCorner = BGSCorner
        self.BGSSurface = BGSSurface
        self.BGSEdges = BGSEdges
        self.SGCCentering = SGCCentering
        self.SGCCorner = SGCCorner
        self.SGCSurface = SGCSurface
        self.SGCEdges = SGCSurface
        self.PopReport = PopReport
        self.FindonEbay = FindonEbay
        
    }
    
    func LoadScan() {
        
        
    }
    
    
    
}

func UpdateScan(ScanMaster: ScanMaster) {
    
    
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



