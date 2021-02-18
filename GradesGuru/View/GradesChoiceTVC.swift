//
//  GradesChoiceTVC.swift
//  GradesGuru
//
//  Created by Superpower on 24/01/21.
//  Copyright © 2021 iMac superpower. All rights reserved.
//

import UIKit
import CoreXLSX
import BTNavigationDropdownMenu
import Segmentio




class GradesChoiceTVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var CenteringData = [String]()
    
    @IBOutlet var segmentioView: Segmentio!
    var segmentioStyle = SegmentioStyle.onlyLabel

    
    var PSAB = [String]()
    var PSAC = [String]()
    
    @IBAction func Back_Button(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    var menuView: BTNavigationDropdownMenu!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentioView.selectedSegmentioIndex = 0
        
        switch segmentioStyle {
        case .onlyLabel, .imageBeforeLabel, .imageAfterLabel:
            print("Only Label")
        case .onlyImage:
            
            print("Only Image")
        default:
            break
        }
        

//        self.selectedCellLabel.text = GradeDetails.first
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.0/255.0, green:180/255.0, blue:220/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

        // "Old" version
        // menuView = BTNavigationDropdownMenu(navigationController: self.navigationController, containerView: self.navigationController!.view, title: "Dropdown Menu", items: items)

        menuView = BTNavigationDropdownMenu(navigationController: self.navigationController, containerView: self.navigationController!.view, title: BTTitle.index(2), items: GradeDetails)

        // Another way to initialize:
        // menuView = BTNavigationDropdownMenu(navigationController: self.navigationController, containerView: self.navigationController!.view, title: BTTitle.title("Dropdown Menu"), items: items)

        menuView.cellHeight = 50
        
        menuView.cellBackgroundColor = self.navigationController?.navigationBar.barTintColor
        menuView.cellSelectionColor = UIColor(red: 255.0/255.0, green:255.0/255.0, blue:255.0/255.0, alpha: 1.0)
        menuView.shouldKeepSelectedCellColor = true
        menuView.cellTextLabelColor = UIColor.white
        menuView.cellTextLabelFont = UIFont(name: "Muli-Regular", size: 17)
        menuView.cellTextLabelAlignment = .left // .Center // .Right // .Left
        menuView.arrowPadding = 15
        menuView.animationDuration = 0.5
        menuView.maskBackgroundColor = UIColor.black
        menuView.maskBackgroundOpacity = 0.3
        menuView.didSelectItemAtIndexHandler = {(indexPath: Int) -> Void in
            print("Did select item at index: \(indexPath)")
//            self.selectedCellLabel.text = GradeDetails[indexPath]
        }
        
        self.navigationItem.titleView = menuView


        
        let filename = ChosenGrading
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
            
                        switch ChosenGrading {
                        
                        case "Corners":
                            
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
                        
                            
                        case "Surface": 
                            
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
                            
                        case "Edges":
                            
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
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        SegmentioBuilder.buildSegmentioView(
            segmentioView: segmentioView,
            segmentioStyle: segmentioStyle
        )
        
    }
    
    func fetchColumn(Path: String) {
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PSAB.count - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GradingCells
        
        cell.backgroundView = UIImageView(image: UIImage(named: "TVC_Border.svg")!)

        
//        cell.textLabel?.text = PSAB[indexPath.row + 1]
        
        cell.Grading_Title.text = PSAB[indexPath.row + 1]
        cell.Grading_Description.text = PSAC[indexPath.row + 1]
        
        return cell

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 80
        
    }

}
