//
//  Corners.swift
//  GradesGuru
//
//  Created by Superpower on 16/08/20.
//  Copyright © 2020 iMac superpower. All rights reserved.
//

import Foundation

class Corners: NSObject, NSCoding {
    
    var Device_ID: String?
    var Card_ID: String?
    var Pictures: [String]?
    var Corners_Value: Double?
    var PSA: Double?
    var SelectedPSA: [Int:Int]
    var BGS: Double?
    var SelectedBGS: [Int:Int]
    var SGC: Double?
    var SelectedSGC: [Int:Int]
    var viewonPSA: String?
    
    init(Device_ID: String, Card_ID: String, Pictures: [String], Corners_Value: Double, PSA: Double, SelectedPSA: [Int:Int], BGS: Double, SelectedBGS: [Int:Int], SGC: Double, SelectedSGC: [Int:Int], viewonPSA: String) {
        
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
        self.SelectedPSA = (aDecoder.decodeObject(forKey: "SelectedPSA") as! [Int : Int])
        self.BGS = (aDecoder.decodeObject(forKey: "BGS") as! Double)
        self.SelectedBGS = (aDecoder.decodeObject(forKey: "SelectedBGS") as! [Int : Int])
        self.SGC = (aDecoder.decodeObject(forKey: "SGC") as! Double)
        self.SelectedSGC = (aDecoder.decodeObject(forKey: "SelectedSGC") as! [Int : Int])
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

class PSADetails: NSObject, NSCoding {
    
    var PSAGrade: [String]!
    var PSADesc: [String]!
    var PSAState: [String]!
//    var PSASelected: [Int:Double]!
    
    init(PSAGrade: [String], PSADesc: [String], PSAState: [String]) {
        
        self.PSAGrade = PSAGrade
        self.PSADesc = PSADesc
        self.PSAState = PSAState
//        self.PSASelected = PSASelected
        
    }
    
    required init!(coder aDecoder: NSCoder) {
        
        self.PSAGrade = (aDecoder.decodeObject(forKey: "PSAGrade") as! [String])
        self.PSADesc = (aDecoder.decodeObject(forKey: "PSADesc") as! [String])
        self.PSAState = (aDecoder.decodeObject(forKey: "PSAState") as! [String])
//        self.PSASelected = (aDecoder.decodeObject(forKey: "PSASelected") as! [Int:Double])
        
        super.init()
        
       }

    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(PSAGrade, forKey: "PSAGrade")
        aCoder.encode(PSADesc, forKey: "PSADesc")
        aCoder.encode(PSAState, forKey: "PSAState")
//        aCoder.encode(PSASelected, forKey: "PSASelected")
    }

}

class BGSDetails: NSObject, NSCoding {
    
    var BGSGrade: [String]!
    var BGSDesc: [String]!
    var BGSState: [String]!
//    var BGSSelected: [Int:Double]!

    init(BGSGrade: [String], BGSDesc: [String], BGSState: [String]) {
        
        self.BGSGrade = BGSGrade
        self.BGSDesc = BGSDesc
        self.BGSState = BGSState
//        self.BGSSelected = BGSSelected
        
    }
    
    required init!(coder aDecoder: NSCoder) {
        
        self.BGSGrade = (aDecoder.decodeObject(forKey: "BGSGrade") as! [String])
        self.BGSDesc = (aDecoder.decodeObject(forKey: "BGSDesc") as! [String])
        self.BGSState = (aDecoder.decodeObject(forKey: "BGSState") as! [String])
//        self.BGSSelected = (aDecoder.decodeObject(forKey: "BGSSelected") as! [Int:Double])

        super.init()
        
       }

    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(BGSGrade, forKey: "BGSGrade")
        aCoder.encode(BGSDesc, forKey: "BGSDesc")
        aCoder.encode(BGSState, forKey: "BGSState")
//        aCoder.encode(BGSSelected, forKey: "BGSSelected")

    }

}

class SGCDetails: NSObject, NSCoding {
    
    var SGCGrade: [String]!
    var SGCDesc: [String]!
    var SGCState: [String]!
//    var SGCSelected: [Int:Double]!

    
    init(SGCGrade: [String], SGCDesc: [String], SGCState: [String]) {
        
        self.SGCGrade = SGCGrade
        self.SGCDesc = SGCDesc
        self.SGCState = SGCState
//        self.SGCSelected = SGCSelected
        
    }
    
    required init!(coder aDecoder: NSCoder) {
        
        self.SGCGrade = (aDecoder.decodeObject(forKey: "SGCGrade") as! [String])
        self.SGCDesc = (aDecoder.decodeObject(forKey: "SGCDesc") as! [String])
        self.SGCState = (aDecoder.decodeObject(forKey: "SGCState") as! [String])
//        self.SGCSelected = (aDecoder.decodeObject(forKey: "SGCSelected") as! [Int:Double])
        
        super.init()
        
       }

    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(SGCGrade, forKey: "SGCGrade")
        aCoder.encode(SGCDesc, forKey: "SGCDesc")
        aCoder.encode(SGCState, forKey: "SGCState")
//        aCoder.encode(SGCSelected, forKey: "SGCSelected")

    }

}


class SaveGrades {
    
    static func saveGradesvalue(GradesValue: Corners, CardID: String, ChosenGrading: String) {
        
        let key = "\(CardID),\(ChosenGrading)"
        
        print("Grades Saved Key CardID, \(key)")

        let defaults =  UserDefaults.standard
           
        guard let encodedData = try? NSKeyedArchiver.archivedData(withRootObject: GradesValue, requiringSecureCoding: false)
        
        //archivedData(withRootObject: category as Array, requiringSecureCoding: false) as NSData
                    else {
                fatalError("Can't encode data")
            }
    
            defaults.set(encodedData, forKey: key)
    
        }
    
    
    static func savePSA(PSAValue: PSADetails, Key: String) {
    
            print("PSA Grades Saved, Key: \(Key)")
    
            let defaults =  UserDefaults.standard
           
        guard let encodedData = try? NSKeyedArchiver.archivedData(withRootObject: PSAValue, requiringSecureCoding: false)
        
        //archivedData(withRootObject: category as Array, requiringSecureCoding: false) as NSData
                    else {
            
                fatalError("Can't encode data")
            }
        
            defaults.set(encodedData, forKey: Key)
    
        }
    
    static func saveBGS(BGSValue: BGSDetails, Key: String) {
    
            print("BGS Grades Saved: \(Key)")
    
            let defaults =  UserDefaults.standard
           
        guard let encodedData = try? NSKeyedArchiver.archivedData(withRootObject: BGSValue, requiringSecureCoding: false)
        
        //archivedData(withRootObject: category as Array, requiringSecureCoding: false) as NSData
                    else {
                fatalError("Can't encode data")
            }
    
            defaults.set(encodedData, forKey: Key)
    
        }
    
    static func saveSGC(SGCValue: SGCDetails, Key: String) {
    
            print("SGC Grades Saved: \(Key)")
    
            let defaults =  UserDefaults.standard
           
        guard let encodedData = try? NSKeyedArchiver.archivedData(withRootObject: SGCValue, requiringSecureCoding: false)
        
        //archivedData(withRootObject: category as Array, requiringSecureCoding: false) as NSData
                    else {
                fatalError("Can't encode data")
            }
    
            defaults.set(encodedData, forKey: Key)
    
        }

}

class LoadGrades {
    
    static func loadGradesvalue(CardID: String, ChosenGrading: String) -> Corners  {
           
            let defaults =  UserDefaults.standard
            let key = "\(CardID),\(ChosenGrading)"


            print("Grades Loaded, CardID -Key : \(key)")
        
            let data = defaults.data(forKey: key)
    
            return try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data!) as! Corners
        }
    
    
    static func loadPSA(Key: String) -> PSADetails  {
        
            print("loadPSA Key: \(Key)")
    
            let defaults =  UserDefaults.standard
    
            let data = defaults.data(forKey: Key)
    
            return try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data!) as! PSADetails
        }
    
    static func loadBGS(Key: String) -> BGSDetails  {
    
            print("loadBGS Key: \(Key)")
        
            let defaults =  UserDefaults.standard
    
            let data = defaults.data(forKey: Key)
    
            return try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data!) as! BGSDetails
        }
    
    static func loadSGC(Key: String) -> SGCDetails  {
    
            print("loadSGC Key: \(Key)")
        
            let defaults =  UserDefaults.standard
    
            let data = defaults.data(forKey: Key)
    
            return try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data!) as! SGCDetails
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



