//
//  GradeEstimate.swift
//  GradesGuru
//
//  Created by Superpower on 16/08/20.
//  Copyright © 2020 iMac superpower. All rights reserved.
//

import Foundation

class Default_Grade_Values: NSObject, NSCoding {
    
    var Center: String?
    var Corner: String?
    var Surface: String?
    var Edges: String?
    var PSA: String?
    var BGS: String?
    var SGC: String?
    
    init(Center: String, Corner: String, Surface: String, Edges: String, PSA: String, BGS: String, SGC: String) {
        
        self.Center = Center
        self.Corner = Corner
        self.Surface = Surface
        self.Edges = Edges
        self.PSA = PSA
        self.BGS = BGS
        self.SGC = SGC
        
    }
    
    
    required init!(coder aDecoder: NSCoder) {
        
        self.Center = (aDecoder.decodeObject(forKey: "Center") as! String)
        self.Corner = (aDecoder.decodeObject(forKey: "Corner") as! String)
        self.Surface = (aDecoder.decodeObject(forKey: "Surface") as! String)
        self.Edges = (aDecoder.decodeObject(forKey: "Edges") as! String)
        self.PSA = (aDecoder.decodeObject(forKey: "PSA") as! String)
        self.BGS = (aDecoder.decodeObject(forKey: "BGS") as! String)
        self.SGC = (aDecoder.decodeObject(forKey: "SGC") as! String)
        
        super.init()
        
       }

    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(Center, forKey: "Center")
        aCoder.encode(Corner, forKey: "Corner")
        aCoder.encode(Surface, forKey: "Surface")
        aCoder.encode(Edges, forKey: "Edges")
        aCoder.encode(PSA, forKey: "PSA")
        aCoder.encode(BGS, forKey: "BGS")
        aCoder.encode(SGC, forKey: "SGC")
    
    }

}


class Save_Default_Grade_Values {
    
    static func saveGradesvalue(Default_GradesValues: [Default_Grade_Values], PSAKey:String) {
        
        let key = "Default_Grade_Values\(PSAKey)"
        
        print("Grades Saved Key CardID, \(key)")

        let defaults =  UserDefaults.standard
           
        guard let encodedData = try? NSKeyedArchiver.archivedData(withRootObject: Default_GradesValues, requiringSecureCoding: false)
        
        //archivedData(withRootObject: category as Array, requiringSecureCoding: false) as NSData
                    else {
                fatalError("Can't encode data")
            }
    
            defaults.set(encodedData, forKey: key)
    
        }
    
    static func saveGradesArrayStrings(ArrayStrings: [String], column: String) {
        
        let key = "GradesArrayStrings\(column)"
        
        print("Grades Saved Key, \(key)")

        let defaults =  UserDefaults.standard
           
        guard let encodedData = try? NSKeyedArchiver.archivedData(withRootObject: ArrayStrings, requiringSecureCoding: false)
        
        //archivedData(withRootObject: category as Array, requiringSecureCoding: false) as NSData
                    else {
                fatalError("Can't encode data")
            }
    
            defaults.set(encodedData, forKey: key)
    
        }
    
}

class Load_Default_Grade_Values {
    
    static func loadGradesvalue(PSAKey: String) -> [Default_Grade_Values]  {
           
            let defaults =  UserDefaults.standard
            let key = "Default_Grade_Values\(PSAKey)"

            print("Grades Loaded, CardID -Key : \(key)")
        
            let data = defaults.data(forKey: key)
    
            return try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data!) as! [Default_Grade_Values]
        }
    
    static func LoadGradesArrayStrings(column: String) -> [String] {
        
        let key = "GradesArrayStrings\(column)"
        
        print("Load Grades Key, \(key)")

        let defaults =  UserDefaults.standard
           
        let data = defaults.data(forKey: key)

        return try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data!) as! [String]
    
    }
  
}
