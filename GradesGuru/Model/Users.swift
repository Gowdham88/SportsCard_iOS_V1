//
//  Users.swift
//  GradesGuru
//
//  Created by Superpower on 19/09/20.
//  Copyright © 2020 iMac superpower. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseFirestore

let db = Firestore.firestore()
var Usersdetails : Users = Users(device_ID: "", Subscription_Status: "", Subscription_Date: Date(), Subscription_Type: "", Cost: 1, CurrentScan_Count: 1)

class Users : NSObject {
    
//    let docRef : DocumentReference!
    
//    let userRef = ref.("location").child("-Khpr_PAuGSVngNspTVW")
//    userRef.updateChildValues(["lat": 11.324231])
    
    var device_ID: String!
    var Subscription_Status: String!
    var Subscription_Date: Date!
    var Subscription_Type: String!
    var Cost: Int!
    var CurrentScan_Count: Int!

    init(device_ID: String,Subscription_Status: String, Subscription_Date: Date, Subscription_Type: String, Cost: Int, CurrentScan_Count: Int) {
        
        self.device_ID = device_ID
        self.Subscription_Status = Subscription_Status
        self.Subscription_Date = Subscription_Date
        self.Subscription_Type = Subscription_Type
        self.Cost = Cost
        self.CurrentScan_Count = CurrentScan_Count
        
    }
    
    func LoadUsers() {
        
        
    }
    
    
    
}

func UpdateUsers(Users: Users) {
    
    
    let docData = ["device_ID": Users.device_ID!,
        "Subscription_Status": Users.Subscription_Status!,
        "Subscription_Date": Users.Subscription_Date!,
        "Subscription_Type": Users.Subscription_Type!,
        "Cost": Users.Cost!,
        "CurrentScan_Count": Users.CurrentScan_Count! ] as [String : Any]
    
    
    db.collection("Users").document(Users.device_ID).setData(docData) { err in
        if let err = err {
            print("Error writing document: \(err)")
        } else {
            print("Document successfully written!")
        }
    }
    
    
}



