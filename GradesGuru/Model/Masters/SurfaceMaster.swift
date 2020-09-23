//
//  SurfaceMaster.swift
//  GradesGuru
//
//  Created by Superpower on 22/09/20.
//  Copyright © 2020 iMac superpower. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseFirestore

var SurfaceDetails : SurfaceMaster = SurfaceMaster(device_ID: "", CardID: "", Pictures : ["1","2","3"], SurfaceValue : "", PSA : 1, BGS : 2, SGC: 1, ViewonPSA: "")

class SurfaceMaster : NSObject {
    
    var device_ID: String!
    var CardID: String!
    var Pictures : [String]!
    var SurfaceValue : String!
    var PSA : Int!
    var BGS : Int!
    var SGC : Int!
    var ViewonPSA: String!
    
    init(device_ID: String, CardID: String, Pictures : [String], SurfaceValue : String, PSA : Int, BGS : Int, SGC : Int, ViewonPSA: String) {
        
        self.device_ID = device_ID
        self.CardID = CardID
        self.Pictures = Pictures
        self.SurfaceValue = SurfaceValue
        self.PSA = PSA
        self.BGS = BGS
        self.SGC = SGC
        self.ViewonPSA = ViewonPSA
        
    }
    
    func LoadSurface() {
        
        
    }
    
}

func UpdateSurface(ScanMaster: ScanMaster) {
    
    
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

