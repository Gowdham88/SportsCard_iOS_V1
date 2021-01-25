//
//  GradesChoiceTVC.swift
//  GradesGuru
//
//  Created by Superpower on 24/01/21.
//  Copyright © 2021 iMac superpower. All rights reserved.
//

import UIKit
import CoreXLSX



class GradesChoiceTVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var CenteringData = [String]()
    
    var PSAB = [String]()
    var PSAC = [String]()
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let filename = "Grade_Guru_Data_2"
        let filetype = "xlsx"
        let filepath : String = Bundle.main.path(forResource: filename, ofType: filetype)!
        
        guard let file = XLSXFile(filepath: filepath) else {
          fatalError("XLSX file at \(filepath) is corrupted or does not exist")
        }
        
        
        do {
                    for wbk in try file.parseWorkbooks() {
                        
                        let ws = try file.parseWorksheetPathsAndNames(workbook: wbk)
                        
                      for (name, path) in ws {
                        
                        if let worksheetName = name {
                          print("This worksheet has a name: \(worksheetName)")
            
                        switch worksheetName {
                        
                        case "Corners_PSA":
                            let worksheet = try file.parseWorksheet(at: path)
                            
                            if let sharedStrings = try file.parseSharedStrings() {
                                
                              let columnAStrings = worksheet.cells(atColumns: [ColumnReference("A")!])
                                .compactMap { $0.stringValue(sharedStrings) }
                                
                                let columnBStrings = worksheet.cells(atColumns: [ColumnReference("B")!])
                                  .compactMap { $0.stringValue(sharedStrings) }
                                
                                let columnCStrings = worksheet.cells(atColumns: [ColumnReference("C")!])
                                  .compactMap { $0.stringValue(sharedStrings) }
                                
                                PSAB = columnBStrings
                                PSAC = columnCStrings
                                
                                print("columnCStringsA: \(columnAStrings)")
                                print("columnCStringsB: \(columnBStrings)")
                                print("columnCStringsC: \(columnCStrings)")
                                
                            }
                            
//                            for row in worksheet.data?.rows ?? [] {
//
//                              for c in row.cells {
//
//                                print("Row c.refernce: \(c.reference.description.description)")
//
//
//
//                              }
//                            }
                            
                        default:
                            print("Default")
                        }
                      }
                        
                      }
                    }
            
            /*for path in try file.parseWorksheetPaths() {
                
                let ws = try file.parseWorksheet(at: path)
                          
                for row in ws.data!.rows {
                            
                    for Excelrowdata in row.cells {
                        
                        print("Excelrowdata: \(Excelrowdata)")
                    }
                          
                }
                
            }*/

        } catch let error1 as NSError {

            print("Error: \(error1)")
            
        } catch {
            print("Any other error")
            
        }
        
        //        do {
//               let docPath = try file.parseWorkbooks()
//               let workSheet = try file.parseWorksheet(at: docPath.first ?? "")
//               let sharedStrings = try file.parseSharedStrings()
//
//               for path in try file.parseWorksheetPaths() {
//                   let ws = try file.parseWorksheet(at: path)
//                   for alphabt in alphaArr {
//                       let cells = ws.cells(atColumns: [ColumnReference(alphabt)!])
//                       let columnCStrings = cells.compactMap{ $0.value }.compactMap { Int($0) }.compactMap {sharedStrings.items[$0].text }
//                       print(columnCStrings)
//                   }
//               }
//           } catch {
//               print(error.localizedDescription)
//           }
        
        
        
//        for wbk in try file.parseWorkbooks() {
//          for (name, path) in try file.parseWorksheetPathsAndNames(workbook: wbk) {
//            if let worksheetName = name {
//              print("This worksheet has a name: \(worksheetName)")
//            }
//
//            let worksheet = try file.parseWorksheet(at: path)
//            for row in worksheet.data?.rows ?? [] {
//              for c in row.cells {
//                print(c)
//              }
//            }
//          }
//        }
        
        
        // Do any additional setup after loading the view.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PSAB.count - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "cell")
        
        cell.textLabel?.text = PSAB[indexPath.row + 1]
        

        return cell

    }

}
