//
//  GetGrading.swift
//  GradesGuru
//
//  Created by Superpower on 08/03/21.
//  Copyright © 2021 iMac superpower. All rights reserved.
//

import Foundation


class GetGradesSheet: NSObject, NSCoding {
    
    var Device_ID: String?
    var Card_ID: String?
    var Pictures: [String]?
    var Corners_Value: Double?
    var PSA: Double?
    var SelectedPSA: [Int:Double]?
    var BGS: Double?
    var SelectedBGS: [Int:Double]?
    var SGC: Double?
    var SelectedSGC: [Int:Double]?
    var viewonPSA: String?

    init(Device_ID: String, Card_ID: String, Pictures: [String], Corners_Value: Double, PSA: Double, SelectedPSA: [Int:Double], BGS: Double, SelectedBGS: [Int:Double], SGC: Double, SelectedSGC: [Int:Double], viewonPSA: String) {

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

        self.Device_ID = (aDecoder.decodeObject(forKey: "Device_ID") as! String)
        self.Card_ID = (aDecoder.decodeObject(forKey: "Card_ID") as! String)
        self.Pictures = (aDecoder.decodeObject(forKey: "Pictures") as! [String])
        self.Corners_Value = (aDecoder.decodeObject(forKey: "Corners_Value") as! Double)
        self.PSA = (aDecoder.decodeObject(forKey: "PSA") as! Double)
        self.SelectedPSA = (aDecoder.decodeObject(forKey: "SelectedPSA") as! [Int:Double])
        self.BGS = (aDecoder.decodeObject(forKey: "BGS") as! Double)
        self.SelectedBGS = (aDecoder.decodeObject(forKey: "SelectedBGS") as! [Int:Double])
        self.SGC = (aDecoder.decodeObject(forKey: "SGC") as! Double)
        self.SelectedSGC = (aDecoder.decodeObject(forKey: "SelectedSGC") as! [Int:Double])
        self.viewonPSA = (aDecoder.decodeObject(forKey: "viewonPSA") as! String)

        super.init()

       }

    func encode(with aCoder: NSCoder) {

        aCoder.encode(Device_ID, forKey: "Device_ID")
        aCoder.encode(Card_ID, forKey: "Card_ID")
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


class SaveGradesData {
    
//    static func saveGradesvalue(GradesValue: [Corners], CardID: String, ChosenGrading: String) {
//
//        print("Grades Saved Key CardID, \(CardID)")
//
//        let defaults =  UserDefaults.standard
//
//        guard let encodedData = try? NSKeyedArchiver.archivedData(withRootObject: GradesValue, requiringSecureCoding: false)
//
//        //archivedData(withRootObject: category as Array, requiringSecureCoding: false) as NSData
//                    else {
//                fatalError("Can't encode data")
//            }
//
//            defaults.set(encodedData, forKey: CardID)
//
//        }
//
}

class LoadGradesData {
    
//    static func loadGradesvalue(CardID: String, ChosenGrading: String) -> [Corners]  {
//
//            let defaults =  UserDefaults.standard
//
//            print("Grades Loaded, CardID -Key : \(CardID)")
//
//            let data = defaults.data(forKey: CardID)
//
//            return try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data!) as! [Corners]
//        }
//
    
 
}
