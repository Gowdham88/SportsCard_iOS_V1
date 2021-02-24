//
//  Corners.swift
//  GradesGuru
//
//  Created by Superpower on 16/08/20.
//  Copyright © 2020 iMac superpower. All rights reserved.
//

import Foundation

class Corners: NSObject, NSCoding {
    
    var Device_ID: String!
    var Card_ID: String!
    var Pictures: [String]!
    var Corners_Value: Double!
    var PSA: [Int: [String]]!
    var SelectedPSA: [Int:Int]!
    var BGS: [Int: [String]]!
    var SelectedBGS: [Int:Int]!
    var SGC: [Int: [String]]!
    var SelectedSGC: [Int:Int]!
    var viewonPSA: String!
    
    init(Device_ID: String, Card_ID: String, Pictures: [String]!, Corners_Value: Double!, PSA: [Int: [String]]!, SelectedPSA: [Int:Int]!, BGS: [Int: [String]]!, SelectedBGS: [Int:Int]!, SGC: [Int: [String]]!, SelectedSGC: [Int:Int]!, viewonPSA: String!) {
        
        self.Device_ID = Device_ID
        self.Card_ID = Card_ID
        self.Pictures = Pictures
        self.Corners_Value = Corners_Value
        self.PSA = PSA
        self.SelectedPSA = SelectedPSA
        self.BGS = BGS
        self.SelectedBGS = SelectedBGS
        self.SGC = SGC
        self.SelectedSGC = SelectedSGC
        self.viewonPSA = viewonPSA
        
    }
    
    required init!(coder aDecoder: NSCoder) {
        
        self.Device_ID = (aDecoder.decodeObject(forKey: "id") as! String)
        self.Card_ID = (aDecoder.decodeObject(forKey: "id") as! String)
        self.Pictures = (aDecoder.decodeObject(forKey: "id") as! [String])
        self.Corners_Value = (aDecoder.decodeObject(forKey: "id") as! Double)
        self.PSA = (aDecoder.decodeObject(forKey: "id") as! [Int: [String]])
        self.SelectedPSA = (aDecoder.decodeObject(forKey: "id") as! [Int:Int])
        self.BGS = (aDecoder.decodeObject(forKey: "id") as! [Int: [String]])
        self.SelectedBGS = (aDecoder.decodeObject(forKey: "id") as! [Int:Int])
        self.SGC = (aDecoder.decodeObject(forKey: "id") as! [Int: [String]])
        self.SelectedSGC = (aDecoder.decodeObject(forKey: "id") as! [Int:Int])
        self.viewonPSA = (aDecoder.decodeObject(forKey: "id") as! String)
        
        super.init()
        
       }

    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(Device_ID, forKey: "Device_ID")
        aCoder.encode(Card_ID, forKey: Card_ID)
        aCoder.encode(Pictures, forKey: "Pictures")
        aCoder.encode(Corners_Value, forKey: "Corners_Value")
        aCoder.encode(PSA, forKey: "PSA")
        aCoder.encode(SelectedPSA, forKey: "SelectedPSA")
        aCoder.encode(BGS, forKey: "BGS")
        aCoder.encode(SelectedBGS, forKey: "SelectedBGS")
        aCoder.encode(SGC, forKey: "SGC")
        aCoder.encode(SelectedSGC, forKey: "SelectedSGC")
        aCoder.encode(viewonPSA, forKey: "viewonPSA")
    
    }

}


//class SaveUtil {
//    
//    static func saveBorder(borderview: BorderView) {
//        
//        print("Border Saved")
//
//        let defaults =  UserDefaults.standard
//        guard let encodedData = try? NSKeyedArchiver.archivedData(withRootObject: borderview, requiringSecureCoding: false) //archivedData(withRootObject: category as Array, requiringSecureCoding: false) as NSData
//                else {
//            fatalError("Can't encode data")
//        }
//                               
//        defaults.set(encodedData, forKey: "borderview1XY")
//        
//    }
//
//    static func loadBorder() -> BorderView  {
//        
//        let defaults =  UserDefaults.standard
//        
//        let data = defaults.data(forKey: "borderview1XY")
//        
//        return try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data!) as! BorderView
//    }
//    
//    static func saveBorder2(borderview: BorderView) {
//        
//        print("Border2 Saved")
//
//        let defaults =  UserDefaults.standard
//        guard let encodedData = try? NSKeyedArchiver.archivedData(withRootObject: borderview, requiringSecureCoding: false) //archivedData(withRootObject: category as Array, requiringSecureCoding: false) as NSData
//                else {
//            fatalError("Can't encode data")
//        }
//                               
//        defaults.set(encodedData, forKey: "borderview2XY")
//        
//    }
//
//    static func loadBorder2() -> BorderView  {
//        
//        let defaults =  UserDefaults.standard
//        
//        let data = defaults.data(forKey: "borderview2XY")
//        
//        return try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data!) as! BorderView
//    }
//    
//    
//    
//    static func saveBorder3(borderview: BorderView) {
//           
//           print("Border3 Saved")
//
//           let defaults =  UserDefaults.standard
//           guard let encodedData = try? NSKeyedArchiver.archivedData(withRootObject: borderview, requiringSecureCoding: false) //archivedData(withRootObject: category as Array, requiringSecureCoding: false) as NSData
//                   else {
//               fatalError("Can't encode data")
//           }
//                                  
//           defaults.set(encodedData, forKey: "borderview3XY")
//           
//       }
//
//       static func loadBorder3() -> BorderView  {
//           
//           let defaults =  UserDefaults.standard
//           
//           let data = defaults.data(forKey: "borderview3XY")
//           
//           return try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data!) as! BorderView
//       }
//    
//    static func saveBorder4(borderview: BorderView) {
//              
//              print("Border4 Saved")
//
//              let defaults =  UserDefaults.standard
//              guard let encodedData = try? NSKeyedArchiver.archivedData(withRootObject: borderview, requiringSecureCoding: false) //archivedData(withRootObject: category as Array, requiringSecureCoding: false) as NSData
//                      else {
//                  fatalError("Can't encode data")
//              }
//                                     
//              defaults.set(encodedData, forKey: "borderview4XY")
//              
//          }
//
//          static func loadBorder4() -> BorderView  {
//              
//              let defaults =  UserDefaults.standard
//              
//              let data = defaults.data(forKey: "borderview4XY")
//              
//              return try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data!) as! BorderView
//          }
//    
//    
//}



