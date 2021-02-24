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

var purpleimage = UIImage(named: "TVC_Border_Purple.svg")
var whiteimage = UIImage(named: "TVC_Border.svg")
var selectedCells = [Int:Int]()
var selected_CardID = String()


class GradesChoiceTVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var CenteringData = [String]()
    var menuView: BTNavigationDropdownMenu!
    var segmentioStyle = SegmentioStyle.onlyLabel
    var CardCorners = [Corners]()
    
    var PSAGrade = [String]()
    var PSADesc = [String]()
    var PSAState = [String]()
    
    var BGSGrade = [String]()
    var BGSDesc = [String]()
    var BGSState = [String]()
    
    var SGCGrade = [String]()
    var SGCDesc = [String]()
    var SGCState = [String]()
    
    var CardCornersvalue : Corners! = nil
    var storedWorksheet = ["Corners": ["Corners_PSA", "Corners_BGS", "Corners_SGC"], "Surface": ["Surface_PSA", "Surface_BGS", "Surface_SGC"], "Edges": ["Edges_PSA", "Edges_BGS", "Edges_SGC"]]

    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var segmentioView: Segmentio!
    
    @IBAction func Back_Button(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.allowsSelection = (2 != 0)
        
//        self.tableView.allowsMultipleSelection = true
//        self.tableView.allowsMultipleSelectionDuringEditing = true
        
        tableView.setContentOffset(CGPoint(x: 0, y: CGFloat.greatestFiniteMagnitude), animated: false)

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
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 255.0/255.0, green:255.0/255.0, blue:255.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]

        // "Old" version
        // menuView = BTNavigationDropdownMenu(navigationController: self.navigationController, containerView: self.navigationController!.view, title: "Dropdown Menu", items: items)

        menuView = BTNavigationDropdownMenu(navigationController: self.navigationController, containerView: self.navigationController!.view, title: BTTitle.index(ChosenGradingIndex), items: GradeDetails)

        // Another way to initialize:
        // menuView = BTNavigationDropdownMenu(navigationController: self.navigationController, containerView: self.navigationController!.view, title: BTTitle.title("Dropdown Menu"), items: items)

        menuView.cellHeight = 50
        menuView.arrowTintColor = .black
        
        menuView.cellBackgroundColor = UIColor(red: 83.0/255.0, green:117.0/255.0, blue:252.0/255.0, alpha: 1.0)
        menuView.cellSelectionColor = UIColor(red: 81.0/255.0, green:114.0/255.0, blue:255.0/255.0, alpha: 0.38)
        
        menuView.selectedCellTextLabelColor = .white
        
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
            
            ChosenGrading = GradeDetails[indexPath]
            self.loadspreadsheet(chosenGrading: ChosenGrading)
            
//            self.selectedCellLabel.text = GradeDetails[indexPath]
        }
        
        self.navigationItem.titleView = menuView
        

        loadspreadsheet(chosenGrading: ChosenGrading)
        
    }
    
    func loadspreadsheet(chosenGrading: String) {
        
        let filename = chosenGrading
        let filetype = "xlsx"
        let filepath : String = Bundle.main.path(forResource: filename, ofType: filetype)!
        
        guard let file = XLSXFile(filepath: filepath) else {
          fatalError("XLSX file at \(filepath) is corrupted or does not exist")
        }
        
        if LoadGrades.loadPSA(Key: storedWorksheet[ChosenGrading]![0]).PSAGrade != nil {
            
            switch ChosenGrading {
            
            case "Corners":
                
                Load_PSA_BGS_SGC(GradingType: ChosenGrading)
                
            case "Surface":
                
                Load_PSA_BGS_SGC(GradingType: ChosenGrading)

            case "Edges":
                
                Load_PSA_BGS_SGC(GradingType: ChosenGrading)
                
            default:
                return
            }
            
            print("CardCornersvalue: \(CardCornersvalue)")
            print("PSAGrade\(PSAGrade)")
            print("PSADesc\(PSADesc)")
            print("PSAState\(PSAState)")
            
        } else {
            
            do {
                var columnAStrings = [String]()
                var columnBStrings = [String]()
                var columnCStrings = [String]()
                
                for wbk in try file.parseWorkbooks() {
                            
                    var i = 0
                    let ws = try file.parseWorksheetPathsAndNames(workbook: wbk)
                            
                          for (name, path) in ws {
                            
                            if let worksheetName = name {
                              print("This worksheet has a name: \(worksheetName)")
                            print("Chosen Grading: \(ChosenGrading)")
                                
                                let worksheet = try file.parseWorksheet(at: path)
                                
                                if let sharedStrings = try file.parseSharedStrings() {
                                    
                                  columnAStrings = worksheet.cells(atColumns: [ColumnReference("A")!])
                                    .compactMap { $0.stringValue(sharedStrings) }
                                    
                                     columnBStrings = worksheet.cells(atColumns: [ColumnReference("B")!])
                                      .compactMap { $0.stringValue(sharedStrings) }
                                    
                                     columnCStrings = worksheet.cells(atColumns: [ColumnReference("C")!])
                                      .compactMap { $0.stringValue(sharedStrings) }
                                    
                                    switch worksheetName {
                                    
                                    case storedWorksheet[ChosenGrading]![0]:
                                        
                                        PSAGrade = columnAStrings
                                        PSADesc = columnBStrings
                                        PSAState = columnCStrings
                                        
                                        let PSADetails1 : PSADetails = PSADetails(PSAGrade: PSAGrade, PSADesc: PSADesc, PSAState: PSAState)

                                        SaveGrades.savePSA(PSAValue: PSADetails1, Key: worksheetName)
                                    
                                    case storedWorksheet[ChosenGrading]![1]:
                                        
                                        BGSGrade = columnAStrings
                                        BGSDesc = columnBStrings
                                        BGSState = columnCStrings
                                        
                                        let BGSDetails1 : BGSDetails = BGSDetails(BGSGrade: BGSGrade, BGSDesc: BGSDesc, BGSState: BGSState)

                                        SaveGrades.saveBGS(BGSValue: BGSDetails1, Key: worksheetName)
                                        
                                    case storedWorksheet[ChosenGrading]![2]:
                                        
                                        SGCGrade = columnAStrings
                                        SGCDesc = columnBStrings
                                        SGCState = columnCStrings
                                        
                                        let SGCDetails1 : SGCDetails = SGCDetails(SGCGrade: SGCGrade, SGCDesc: SGCDesc, SGCState: SGCState)

                                        
                                        SaveGrades.saveSGC(SGCValue: SGCDetails1, Key: worksheetName)
                                      
                                    
                                    default:
                                        print("Default")
                                    }
                                    
                                  
                                }
                                
                

                          }
                            
                           i += 1
                        
                          }
                    }

            } catch let error1 as NSError {

                print("Error: \(error1)")
                
            } catch {
                print("Any other error")
                
            }
            
        }
        
    }
    func Load_PSA_BGS_SGC(GradingType: String) {
        
        PSAGrade = LoadGrades.loadPSA(Key: storedWorksheet[GradingType]![0]).PSAGrade
        PSADesc = LoadGrades.loadPSA(Key: storedWorksheet[GradingType]![0]).PSADesc
        PSAState = LoadGrades.loadPSA(Key: storedWorksheet[GradingType]![0]).PSAState
        
        BGSGrade = LoadGrades.loadBGS(Key: storedWorksheet[GradingType]![1]).BGSGrade
        BGSDesc = LoadGrades.loadBGS(Key: storedWorksheet[GradingType]![1]).BGSDesc
        BGSState = LoadGrades.loadBGS(Key: storedWorksheet[GradingType]![1]).BGSState
        
        SGCGrade = LoadGrades.loadSGC(Key: storedWorksheet[GradingType]![2]).SGCGrade
        SGCDesc = LoadGrades.loadSGC(Key: storedWorksheet[GradingType]![2]).SGCGrade
        SGCState = LoadGrades.loadSGC(Key: storedWorksheet[GradingType]![2]).SGCGrade
        
        tableView.reloadData()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        
    }
    
    override func viewDidLayoutSubviews() {
        
        SegmentioBuilder.buildSegmentioView(
            segmentioView: segmentioView,
            segmentioStyle: segmentioStyle
        )
    }
   
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PSAGrade.count - 1
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 20
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
            let headerView = UIView()
            headerView.backgroundColor = view.backgroundColor
        
            return headerView
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GradingCells
        
        if indexPath.row < PSAGrade.count {
            
            cell.grading_number.text = PSAGrade[indexPath.row + 1]
            cell.Grading_Title.text = PSADesc[indexPath.row + 1]
            cell.Grading_Description.text = PSAState[indexPath.row + 1]
            
            if selectedCells[indexPath.row] != nil {
                
                cell.backgroundView = UIImageView(image: purpleimage)

            } else {
                
                cell.backgroundView = UIImageView(image: whiteimage)

            }
            
        }
       
        return cell

    }
   
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        print("selectedCells: \(selectedCells)")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GradingCells

        let backgroundImage = UIImageView(frame: cell.bounds)
        backgroundImage.clipsToBounds = true
        backgroundImage.contentMode = .scaleToFill
        
        if selectedCells[indexPath.row] != nil {
            
            if selectedCells.count <= 2 {
            
                cell.backgroundView = UIImageView(image: whiteimage)
                
//                cell.backgroundView = UIImageView(image: whiteimage)

    //            cell.imageView?.insertSubview(backgroundImage, at: 0)
    //
    //            cell.bringSubviewToFront(cell.grading_number)
    //            cell.bringSubviewToFront(cell.Grading_Title)
    //            cell.bringSubviewToFront(cell.Grading_Description)
                
        }
            
            selectedCells.removeValue(forKey: indexPath.row)

            
        } else {
            
            if selectedCells.count < 2 {
                
                cell.backgroundView = UIImageView(image: purpleimage)

                selectedCells.updateValue(indexPath.row, forKey: indexPath.row)
                
            }
            

            
//            cell.imageView?.removeFromSuperview()
//            cell.imageView?.isHidden = false
//            backgroundImage.image = purpleimage
//            cell.addSubview(backgroundImage)
            
//            cell.bringSubviewToFront(cell.grading_number)
//            cell.bringSubviewToFront(cell.Grading_Title)
//            cell.bringSubviewToFront(cell.Grading_Description)
            
            
        }
 
        tableView.reloadRows(at: [indexPath], with: .automatic)

    }
    
  }
