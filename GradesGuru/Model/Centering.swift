//
//  Centering.swift
//  GradesGuru
//
//  Created by Superpower on 16/08/20.
//  Copyright © 2020 iMac superpower. All rights reserved.
//

import Foundation

class CenterPSADetails: NSObject, NSCoding {
    
    var PSAGrade: [String]!
    var PSADesc: [String]!
    var PSAFront: [String]!
    var PSABack: [String]!
    
    init(PSAGrade: [String], PSADesc: [String], PSAFront: [String], PSABack: [String]) {
        
        self.PSAGrade = PSAGrade
        self.PSADesc = PSADesc
        self.PSAFront = PSAFront
        self.PSABack = PSABack
        
    }
    
    required init!(coder aDecoder: NSCoder) {
        
        self.PSAGrade = (aDecoder.decodeObject(forKey: "CenterPSAGrade") as! [String])
        self.PSADesc = (aDecoder.decodeObject(forKey: "CenterPSADesc") as! [String])
        self.PSAFront = (aDecoder.decodeObject(forKey: "CenterPSAFront") as! [String])
        self.PSABack = (aDecoder.decodeObject(forKey: "CenterPSABack") as! [String])

        super.init()
        
       }

    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(PSAGrade, forKey: "CenterPSAGrade")
        aCoder.encode(PSADesc, forKey: "CenterPSADesc")
        aCoder.encode(PSAFront, forKey: "CenterPSAFront")
        aCoder.encode(PSABack, forKey: "CenterPSABack")

    }

}

class CenterBGSDetails: NSObject, NSCoding {
    
    var BGSGrade: [String]!
    var BGSDesc: [String]!
    var BGSFront: [String]!
    var BGSBack: [String]!

    init(BGSGrade: [String], BGSDesc: [String], BGSFront: [String], BGSBack: [String]) {
        
        self.BGSGrade = BGSGrade
        self.BGSDesc = BGSDesc
        self.BGSFront = BGSFront
        self.BGSBack = BGSBack

    }
    
    required init!(coder aDecoder: NSCoder) {
        
        self.BGSGrade = (aDecoder.decodeObject(forKey: "CenterBGSGrade") as! [String])
        self.BGSDesc = (aDecoder.decodeObject(forKey: "CenterBGSDesc") as! [String])
        self.BGSFront = (aDecoder.decodeObject(forKey: "CenterBGSFront") as! [String])
        self.BGSBack = (aDecoder.decodeObject(forKey: "CenterBGSBack") as! [String])

        super.init()
        
       }

    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(BGSGrade, forKey: "CenterBGSGrade")
        aCoder.encode(BGSDesc, forKey: "CenterBGSDesc")
        aCoder.encode(BGSFront, forKey: "CenterBGSFront")
        aCoder.encode(BGSBack, forKey: "CenterBGSBack")

    }

}

class CenterSGCDetails: NSObject, NSCoding {
    
    var SGCGrade: [String]!
    var SGCDesc: [String]!
    var SGCCentering: [String]!
//    var SGCSelected: [Int:Double]!

    
    init(SGCGrade: [String], SGCDesc: [String], SGCCentering: [String]) {
        
        self.SGCGrade = SGCGrade
        self.SGCDesc = SGCDesc
        self.SGCCentering = SGCCentering
        
    }
    
    required init!(coder aDecoder: NSCoder) {
        
        self.SGCGrade = (aDecoder.decodeObject(forKey: "CenterSGCGrade") as! [String])
        self.SGCDesc = (aDecoder.decodeObject(forKey: "CenterSGCDesc") as! [String])
        self.SGCCentering = (aDecoder.decodeObject(forKey: "CenterSGCCentering") as! [String])
        
        super.init()
        
       }

    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(SGCGrade, forKey: "CenterSGCGrade")
        aCoder.encode(SGCDesc, forKey: "CenterSGCDesc")
        aCoder.encode(SGCCentering, forKey: "CenterSGCCentering")

    }

}


class SaveCenterGrades {
    
    static func saveCenterGradesvalue(GradesValue: Corners, CardID: String, ChosenGrading: String) {
        
        let key = "Center: \(CardID),\(ChosenGrading)"
        
        print("Center Grades Saved Key CardID, \(key)")

        let defaults =  UserDefaults.standard
           
        guard let encodedData = try? NSKeyedArchiver.archivedData(withRootObject: GradesValue, requiringSecureCoding: false)
        
        //archivedData(withRootObject: category as Array, requiringSecureCoding: false) as NSData
                    else {
                fatalError("Can't encode data")
            }
    
            defaults.set(encodedData, forKey: key)
    
        }
    
    static func saveCenterPSA(CenterPSAValue: CenterPSADetails, Key: String) {
    
            print("Center: PSA Grades Saved, Key: \(Key)")
        
    
            let defaults =  UserDefaults.standard
           
        guard let encodedData = try? NSKeyedArchiver.archivedData(withRootObject: CenterPSAValue, requiringSecureCoding: false)
        
        //archivedData(withRootObject: category as Array, requiringSecureCoding: false) as NSData
                    else {
            
                fatalError("Can't encode data")
            }
        
            defaults.set(encodedData, forKey: Key)
    
        }
    
    static func saveCenterBGS(CenterBGSValue: CenterBGSDetails, Key: String) {
    
        print("Center: BGS Grades Saved: \(Key)")
        
    
        let defaults =  UserDefaults.standard
           
        guard let encodedData = try? NSKeyedArchiver.archivedData(withRootObject: CenterBGSValue, requiringSecureCoding: false)
        
        //archivedData(withRootObject: category as Array, requiringSecureCoding: false) as NSData
                    else {
                fatalError("Can't encode data")
            }
    
            defaults.set(encodedData, forKey: Key)
    
        }
    
    static func saveCenterSGC(CenterSGCValue: CenterSGCDetails, Key: String) {
    
            print("Center: SGC Grades Saved: \(Key)")
        
    
            let defaults =  UserDefaults.standard
           
        guard let encodedData = try? NSKeyedArchiver.archivedData(withRootObject: CenterSGCValue, requiringSecureCoding: false)
        
        //archivedData(withRootObject: category as Array, requiringSecureCoding: false) as NSData
                    else {
                fatalError("Can't encode data")
            }
    
            defaults.set(encodedData, forKey: Key)
    
        }

}

class LoadCenterGrades {
    
    static func loadCenterGradesvalue(CardID: String, ChosenGrading: String) -> Corners  {
           
            let defaults =  UserDefaults.standard
            let key = "Center: \(CardID),\(ChosenGrading)"


            print("Grades Loaded, CardID -Key : \(key)")
        
            let data = defaults.data(forKey: key)
    
            return try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data!) as! Corners
        }
    
    
    static func loadCenterPSA(Key: String) -> CenterPSADetails  {
        
            print("loadPSA Key: \(Key)")

            let defaults =  UserDefaults.standard
    
            let data = defaults.data(forKey: Key)
    
            return try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data!) as! CenterPSADetails
        }
    
    static func loadCenterBGS(Key: String) -> CenterBGSDetails  {
    
            print("loadBGS Key: \(Key)")

            let defaults =  UserDefaults.standard
    
            let data = defaults.data(forKey: Key)
    
            return try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data!) as! CenterBGSDetails
        }
    
    static func loadCenterSGC(Key: String) -> CenterSGCDetails  {
    
            print("loadSGC Key: \(Key)")

            let defaults =  UserDefaults.standard
    
            let data = defaults.data(forKey: Key)
    
            return try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data!) as! CenterSGCDetails
        }
    
}
