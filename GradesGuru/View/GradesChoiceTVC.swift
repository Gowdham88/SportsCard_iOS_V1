//
//  GradesChoiceTVC.swift
//  GradesGuru
//
//  Created by Superpower on 24/01/21.
//  Copyright © 2021 iMac superpower. All rights reserved.
//

import UIKit
import Foundation
import CoreXLSX
import BTNavigationDropdownMenu
import Segmentio
import LoadingPlaceholderView

var purpleimage = UIImage(named: "TVC_Border_Purple.svg")
var whiteimage = UIImage(named: "TVC_Border.svg")
var selectedCells = [Int:Double]()
var selected_CardID = String()
var GlobalAverage = Double()
var GlobalPSA = Double()
var GlobalBGS = Double()
var GlobalSGC = Double()

class GradesChoiceTVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
  //  let loadingPlaceholderView = LoadingPlaceholderView()
    var GradingDownloadStatus = ["Corners":false,"Surface":false, "Edges":false]
    var didselectcell = false

    var CenteringData = [String]()
    var menuView: BTNavigationDropdownMenu!
    var segmentioStyle = SegmentioStyle.onlyLabel
    
    var PSAGrade = [String]()
    var PSADesc = [String]()
    var PSAState = [String]()
    var PSASelected = [Int:Double]()
    
    var BGSGrade = [String]()
    var BGSDesc = [String]()
    var BGSState = [String]()
    var BGSSelected = [Int:Double]()
    
    var SGCGrade = [String]()
    var SGCDesc = [String]()
    var SGCState = [String]()
    var SGCSelected = [Int:Double]()
    
    var selected_Segment = Int()
    let defaults = UserDefaults.standard

    var storedWorksheet = ["Corners": ["Corners_PSA", "Corners_BGS", "Corners_SGC"], "Surface": ["Surface_PSA", "Surface_BGS", "Surface_SGC"], "Edges": ["Edges_PSA", "Edges_BGS", "Edges_SGC"]]

    @IBOutlet var tableView: UITableView!
    @IBOutlet var segmentioView: Segmentio!
    
    @IBAction func Back_Button(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ViewdidLoad_GradeChoicesTVC")
        setupLoadingPlaceholderView()
        
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
        menuView.didSelectItemAtIndexHandler = { [self](indexPath: Int) -> Void in
            
            print("Did select item at index: \(indexPath)")
            
            ChosenGrading = GradeDetails[indexPath]
            
            didselectcell = false
            
            Load_PSA_BGS_SGC(GradingType: ChosenGrading)
            
            
        }
        
        self.navigationItem.titleView = menuView

     
        segmentioView.valueDidChange = { segmentio, segmentIndex in
            print("Selected item: ", segmentIndex)
            
            self.selected_Segment = segmentIndex
            self.tableView.reloadData()
            
        }
        

        if defaults.value(forKey: "FirstTime") != nil {
            
            
            print("Loading More than Once")
            Load_PSA_BGS_SGC(GradingType: ChosenGrading)
                
         
        } else {
            
            
            self.saveSpreadsheet()
            defaults.set(true, forKey: "FirstTime")

                
        }
        
      
    }
    
    
    func saveSpreadsheet() {
        
        let grading = ["Corners", "Surface", "Edges"]

        for grd in grading {
            
            loadspreadsheet(chosenGrading: grd)
            
        }
        loadGradingdataSheet()
    }


    func loadspreadsheet(chosenGrading: String) {
        
        let filename = chosenGrading
        let filetype = "xlsx"
        let filepath : String = Bundle.main.path(forResource: filename, ofType: filetype)!
        var sheetIndex = 0
        guard let file = XLSXFile(filepath: filepath) else {
            
          fatalError("XLSX file at \(filepath) is corrupted or does not exist")
        
        }
        
            do {
                
                var columnAStrings = [String]()
                var columnBStrings = [String]()
                var columnCStrings = [String]()
                
                
                
                for wbk in try file.parseWorkbooks() {
                            
                    let ws = try file.parseWorksheetPathsAndNames(workbook: wbk)
                    
                    print("ws.count: \(ws.count)")
                    
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
                                    
                                    print("storedWorksheet[ChosenGrading]: \(storedWorksheet[ChosenGrading])")
                                    print("worksheetName: \(worksheetName)")
                                        
                                    switch sheetIndex {
                                    
                                    case 0:
                                        
                                        print("Saving PSA from worksheet")
                                        
                                        PSAGrade = columnAStrings
                                        PSADesc = columnBStrings
                                        PSAState = columnCStrings
                                        
                                        let PSADetails1 : PSADetails = PSADetails(PSAGrade: PSAGrade, PSADesc: PSADesc, PSAState: PSAState)
                                        
//                                        print("storedWorksheet[ChosenGrading]![0]: \(storedWorksheet[ChosenGrading]![0])")

                                        SaveGrades.savePSA(PSAValue: PSADetails1, Key: worksheetName)
//                                        Load_PSA_BGS_SGC(GradingType: chosenGrading)

                                    
                                    case 1:
                                        
                                        print("Saving BGS from worksheet")
                                        
                                        BGSGrade = columnAStrings
                                        BGSDesc = columnBStrings
                                        BGSState = columnCStrings
                                        
                                        let BGSDetails1 : BGSDetails = BGSDetails(BGSGrade: BGSGrade, BGSDesc: BGSDesc, BGSState: BGSState)

                                        SaveGrades.saveBGS(BGSValue: BGSDetails1, Key: worksheetName)
//                                        Load_PSA_BGS_SGC(GradingType: chosenGrading)
                                        
                                    case 2:
                                        
                                        print("Saving SGC from worksheet")
                                        
                                        SGCGrade = columnAStrings
                                        SGCDesc = columnBStrings
                                        SGCState = columnCStrings
                                        
                                        let SGCDetails1 : SGCDetails = SGCDetails(SGCGrade: SGCGrade, SGCDesc: SGCDesc, SGCState: SGCState)
                                        GradingDownloadStatus[chosenGrading] = true
                                        
                                        print("GradingDownloadStatus: \(GradingDownloadStatus)")
                                        SaveGrades.saveSGC(SGCValue: SGCDetails1, Key: worksheetName)
                                        
//                                        Load_PSA_BGS_SGC(GradingType: chosenGrading)
                                        
                                    default:
                                        
                                        print("Default")
                                    }
                                  
                                }
                
                            }
                            
                            sheetIndex += 1
                            
                          }
                    
                    Load_PSA_BGS_SGC(GradingType: chosenGrading)
                    
                }
                
//                loadGradingdataSheet()
                
                
            } catch let error1 as NSError {
                
                print("Error: \(error1)")
                
            } catch {
                
                print("Any other error")
                
        }
            
    }
    
    
    func loadGradingdataSheet() {
        
        print("LOADING GRADING DATA SHEET")
        
        let filename = "GradeEstimates"
        let filetype = "xlsx"
        let filepath : String = Bundle.main.path(forResource: filename, ofType: filetype)!
        
        guard let file = XLSXFile(filepath: filepath) else {
            
          fatalError("XLSX file at \(filepath) is corrupted or does not exist")
        
        }
        
            do {
                
                var columnAStrings = [String]()
                var columnBStrings = [String]()
                var columnCStrings = [String]()
                var columnDStrings = [String]()
                var columnEStrings = [String]()
                var columnFStrings = [String]()
                var columnGStrings = [String]()
                
                for wbk in try file.parseWorkbooks() {
                            
                    let ws = try file.parseWorksheetPathsAndNames(workbook: wbk)
                    
                    print("ws.count: \(ws.count)")
                    
                          for (name, path) in ws {
                            
                            if let worksheetName = name {
                                
                            print("This worksheet has a name: \(worksheetName)")
                                
                            print("Chosen Grading: \(ChosenGrading)")
                                
                                let worksheet = try file.parseWorksheet(at: path)
                                
                                if let sharedStrings = try file.parseSharedStrings() {
                                    
                                    
                                    //COLUMN A
                                  columnAStrings = worksheet.cells(atColumns: [ColumnReference("A")!])
                                    .compactMap { $0.stringValue(sharedStrings) }
                                    Save_Default_Grade_Values.saveGradesArrayStrings(ArrayStrings: columnAStrings, column: "A")
                                    
                                    //COLUMN B
                                    
                                     columnBStrings = worksheet.cells(atColumns: [ColumnReference("B")!])
                                      .compactMap { $0.stringValue(sharedStrings) }
                                    
                                    Save_Default_Grade_Values.saveGradesArrayStrings(ArrayStrings: columnBStrings, column: "B")
                                    
                                    //COLUMN C
                                    
                                     columnCStrings = worksheet.cells(atColumns: [ColumnReference("C")!])
                                      .compactMap { $0.stringValue(sharedStrings) }
                                    
                                    Save_Default_Grade_Values.saveGradesArrayStrings(ArrayStrings: columnCStrings, column: "C")
                                    
                                    //COLUMN D
                                    
                                    columnDStrings = worksheet.cells(atColumns: [ColumnReference("D")!])
                                     .compactMap { $0.stringValue(sharedStrings) }
                                    
                                    Save_Default_Grade_Values.saveGradesArrayStrings(ArrayStrings: columnDStrings, column: "D")
                                    
                                    //COLUMN E
                                    
                                    columnEStrings = worksheet.cells(atColumns: [ColumnReference("E")!])
                                     .compactMap { $0.stringValue(sharedStrings) }
                                    Save_Default_Grade_Values.saveGradesArrayStrings(ArrayStrings: columnEStrings, column: "E")
                                    
                                    //COLUMN F
                                    columnFStrings = worksheet.cells(atColumns: [ColumnReference("F")!])
                                     .compactMap { $0.stringValue(sharedStrings) }
                                    
                                    Save_Default_Grade_Values.saveGradesArrayStrings(ArrayStrings: columnFStrings, column: "F")
                                    
                                    for (index, value) in columnFStrings.enumerated() {
                                                                            
                                        print("columnFStrings[index]: \(columnFStrings[index])")
                                                                        
                                    }
                                    
                                    //COLUMN G
                                    columnGStrings = worksheet.cells(atColumns: [ColumnReference("G")!])
                                     .compactMap { $0.stringValue(sharedStrings) }
                                    
                                    Save_Default_Grade_Values.saveGradesArrayStrings(ArrayStrings: columnGStrings, column: "G")
                                    
                                    print("storedWorksheet[ChosenGrading]: \(storedWorksheet[ChosenGrading])")
                                    print("worksheetName: \(worksheetName)")
                                        
                                    print("Saving Default Grade from worksheet")
//
//                                        PSAGrade = columnAStrings
//                                        PSADesc = columnBStrings
//                                        PSAState = columnCStrings
                                    
                                    let Grade_Array = [Default_Grade_Values]()
                                    
                                    let DefaultValue : Default_Grade_Values!
                                    
                                    print("Grade_Array: \(Grade_Array)")
                                    
                                    Save_Default_Grade_Values.saveGradesvalue(Default_GradesValues: Grade_Array, PSAKey: String(GlobalPSA))
                                  
                            }
                
                        }
                            
                    }
                    
                }
                
                
            } catch let error1 as NSError {
                
                print("Error: \(error1)")
                
            } catch {
                
                print("Any other error")
                
        }
            
    }
    
    
    func calculateGrades_ValuefromPSABGSSGC(chosenGrading: String) {
        
        
        switch chosenGrading {
        
        case "Corners":
                
            GlobalPSA  = CardCornersvalue.PSA!
            GlobalBGS = CardCornersvalue.BGS!
            GlobalSGC = CardCornersvalue.SGC!
            
        case "Surface":
            
            GlobalPSA  = CardSurfacevalue.PSA!
            GlobalBGS = CardSurfacevalue.BGS!
            GlobalSGC = CardSurfacevalue.SGC!
            
        case "Edges":
            
            GlobalPSA  = CardEdgesvalue.PSA!
            GlobalBGS = CardEdgesvalue.BGS!
            GlobalSGC = CardEdgesvalue.SGC!
            
        default:
            
            break
            
        }
        
    }
    

    
    private func setupLoadingPlaceholderView() {
//        loadingPlaceholderView.gradientColor = .white
//        loadingPlaceholderView.backgroundColor = .white
    }
    
    
    func Load_PSA_BGS_SGC(GradingType: String) {

        print("Load_PSA_BGS_SGC_GradingType\(GradingType)")
        
        // LOADS DEFAULT PSA BGS AND SGC VALUES
        
        PSAGrade = LoadGrades.loadPSA(Key: storedWorksheet[GradingType]![0]).PSAGrade
        PSADesc = LoadGrades.loadPSA(Key: storedWorksheet[GradingType]![0]).PSADesc
        PSAState = LoadGrades.loadPSA(Key: storedWorksheet[GradingType]![0]).PSAState

        BGSGrade = LoadGrades.loadBGS(Key: storedWorksheet[GradingType]![1]).BGSGrade
        BGSDesc = LoadGrades.loadBGS(Key: storedWorksheet[GradingType]![1]).BGSDesc
        BGSState = LoadGrades.loadBGS(Key: storedWorksheet[GradingType]![1]).BGSState

        SGCGrade = LoadGrades.loadSGC(Key: storedWorksheet[GradingType]![2]).SGCGrade
        SGCDesc = LoadGrades.loadSGC(Key: storedWorksheet[GradingType]![2]).SGCDesc
        SGCState = LoadGrades.loadSGC(Key: storedWorksheet[GradingType]![2]).SGCState

        
        LoadSelectedCells(ChosenGrading: ChosenGrading, Card_ID: selected_CardID)
        
    }
    
    func LoadSelectedCells(ChosenGrading: String, Card_ID: String) {
        
        
        switch ChosenGrading {
        
        case "Corners":
            PSASelected = LoadGrades.loadGradesvalue(CardID: Card_ID, ChosenGrading:ChosenGrading).SelectedPSA ?? [0:0.0]
            GlobalPSA = LoadGrades.loadGradesvalue(CardID: Card_ID, ChosenGrading:ChosenGrading).PSA ?? 0.0
            
            BGSSelected = LoadGrades.loadGradesvalue(CardID: Card_ID, ChosenGrading:ChosenGrading).SelectedBGS ?? [0:0.0]
            GlobalBGS = LoadGrades.loadGradesvalue(CardID: Card_ID, ChosenGrading:ChosenGrading).BGS ?? 0.0
            
            SGCSelected = LoadGrades.loadGradesvalue(CardID: Card_ID, ChosenGrading:ChosenGrading).SelectedSGC ?? [0:0.0]
            
            print("Corners PSASelected, BGSSelected, SGCSelected: \(PSASelected), \(BGSSelected), \(SGCSelected)")
            
        case "Surface":
            PSASelected = LoadGrades.loadGradesvalue(CardID: Card_ID, ChosenGrading:ChosenGrading).SelectedPSA ?? [0:0.0]
            BGSSelected = LoadGrades.loadGradesvalue(CardID: Card_ID, ChosenGrading:ChosenGrading).SelectedBGS ?? [0:0.0]
            SGCSelected = LoadGrades.loadGradesvalue(CardID: Card_ID, ChosenGrading:ChosenGrading).SelectedSGC ?? [0:0.0]
            
            print("Surface PSASelected, BGSSelected, SGCSelected: \(PSASelected), \(BGSSelected), \(SGCSelected)")

        case "Edges":
            PSASelected = LoadGrades.loadGradesvalue(CardID: Card_ID, ChosenGrading:ChosenGrading).SelectedPSA ?? [0:0.0]
            BGSSelected = LoadGrades.loadGradesvalue(CardID: Card_ID, ChosenGrading:ChosenGrading).SelectedBGS ?? [0:0.0]
            SGCSelected = LoadGrades.loadGradesvalue(CardID: Card_ID, ChosenGrading:ChosenGrading).SelectedSGC ?? [0:0.0]
            
            print("Edges PSASelected, BGSSelected, SGCSelected: \(PSASelected), \(BGSSelected), \(SGCSelected)")

        default:
            break
        }
        
        if didselectcell == true {
            
            didselectcell = false
            
        } else {
            
            
            tableView.reloadData()
        }

        
    }
  
    override func viewDidAppear(_ animated: Bool) {
        
        if selected_CardID.isEmpty {
            
            print("Card ID Empty")
            
        } else {
            
            print("Card ID Available")
            LoadSelectedCells(ChosenGrading: ChosenGrading, Card_ID: selected_CardID)
            
        }
        
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
        
        var GradeCount = Int()
        
        switch selected_Segment {
        
        case 0:
            GradeCount = PSAGrade.count - 1
        case 1:
            GradeCount = BGSGrade.count - 1
        case 2:
            GradeCount = SGCGrade.count - 1
        default:
            break
        }
        
        return GradeCount
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
        var Grade = [String]()
        var Desc = [String]()
        var State = [String]()
        
        switch selected_Segment {
        
        case 0:
            
            Grade = PSAGrade
            Desc = PSADesc
            State = PSAState
            selectedCells = PSASelected
            
            
        case 1:

            Grade = BGSGrade
            Desc = BGSDesc
            State = BGSState
            selectedCells = BGSSelected

        case 2:

            Grade = SGCGrade
            Desc = SGCDesc
            State = SGCState
            selectedCells = SGCSelected
            
        default:
            break
        }
        
        if indexPath.row < Grade.count {
            
            cell.grading_number.text = Grade[indexPath.row + 1]
            cell.Grading_Title.text = Desc[indexPath.row + 1]
            cell.Grading_Description.text = State[indexPath.row + 1]
            
            if selectedCells[indexPath.row] != nil {
                
                cell.backgroundView = UIImageView(image: purpleimage)

            } else {
                
                cell.backgroundView = UIImageView(image: whiteimage)

            }
            
        }
        
        return cell

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        print("0.selectedCells: \(selectedCells)")
        print("selected_Segment in Cell for row at index path: \(selected_Segment)")
        
        //using this Didselectcell Bool to reload data called under LoadSelectedCells function
        
        didselectcell = true
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GradingCells
        let backgroundImage = UIImageView(frame: cell.bounds)
        backgroundImage.clipsToBounds = true
        backgroundImage.contentMode = .scaleToFill
     
        if selectedCells[indexPath.row] != nil {
            
            if selectedCells.count <= 2 {
            
                cell.backgroundView = UIImageView(image: whiteimage)
                
            }
            
            selectedCells.removeValue(forKey: indexPath.row)
            
            print("After Removal selectedCells: \(selectedCells)")
            
            let allvalues = selectedCells.map(\.value)
            let sum = allvalues.reduce(.zero, +)
            let average = Double(sum) / Double(allvalues.count)
            
            print("average: \(average)")
            print("1.selected cells: \(selectedCells)")
            GlobalAverage = average
            print("1.GlobalAverage: \(GlobalAverage)")
            selected_Grading(Grading: ChosenGrading, Segment: selected_Segment)

        } else {
            
            if selectedCells.count < 2 {
                
                print("2.Start: \(selectedCells)")
                cell.backgroundView = UIImageView(image: purpleimage)
                
                var myselectedcells = String() //Double(indexPath.row)
                
                switch selected_Segment {
                
                case 0:
                    
                     myselectedcells = PSAGrade[indexPath.row + 1]

                case 1:

                    myselectedcells = BGSGrade[indexPath.row + 1]

                case 2:

                    myselectedcells = SGCGrade[indexPath.row + 1]

                default:
                    break
                }
                
                selectedCells[indexPath.row] = Double(myselectedcells)
                
                print("2.selected cells: \(selectedCells)")
                
                let allvalues1 = selectedCells.map(\.value)
                let sum1 = allvalues1.reduce(.zero, +)
                let average1 = Double(sum1) / Double(allvalues1.count)
                
                print("average1: \(average1)")
                
                GlobalAverage = average1
                
                print("2.GlobalAverage: \(GlobalAverage)")
                
                selected_Grading(Grading: ChosenGrading, Segment: selected_Segment)
                
            } else {
                
                print("selectedCells.count is TWO --> \(selectedCells.count)")
                
            }
            
        }
      
        tableView.reloadRows(at: [indexPath], with: .automatic)

    }
    
    func selected_Grading(Grading: String, Segment: Int) {
        
            print("selected_Segment: \(selected_Segment)")
        
            switch selected_Segment {
            
            case 0:
                
                switch ChosenGrading {
                
                case "Corners":
                   
                    CardCornersvalue.SelectedPSA = selectedCells
                    CardCornersvalue.PSA = GlobalAverage
                    
                    let columnFStrings = Load_Default_Grade_Values.LoadGradesArrayStrings(column: "F") as [String]
                    
                    
                    if let index = columnFStrings.firstIndex(of: "\(GlobalAverage)") {
                        
                        print(index)
                        SaveGrades.saveGradesvalue(GradesValue: CardCornersvalue, CardID: selected_CardID, ChosenGrading: Grading)
                        
                    } else {
                        
                        let FloorPSA = round(GlobalAverage)
                        print("FloorPSA: \(FloorPSA)")
                        CardCornersvalue.PSA = FloorPSA
                        
                        if let index = columnFStrings.firstIndex(of: "\(FloorPSA)") {
                            
                            print(index)
                            SaveGrades.saveGradesvalue(GradesValue: CardCornersvalue, CardID: selected_CardID, ChosenGrading: Grading)
                            
                        } else {
                            
                            print("NOT AVAILABLE EVEN AFTER ROUND OFF")
                            
                        }
                        
                    }
                    
                    
                case "Surface":
                    var columnEStrings = Load_Default_Grade_Values.LoadGradesArrayStrings(column: "E")
                    
                    CardSurfacevalue.SelectedPSA = selectedCells
                    CardSurfacevalue.PSA = GlobalAverage
                    
                    SaveGrades.saveGradesvalue(GradesValue: CardSurfacevalue, CardID: selected_CardID, ChosenGrading: Grading)
                    
                case "Edges":
                    var columnGStrings = Load_Default_Grade_Values.LoadGradesArrayStrings(column: "G")
                    
                    CardEdgesvalue.SelectedPSA = selectedCells
                    CardEdgesvalue.PSA = GlobalAverage
                    
                    SaveGrades.saveGradesvalue(GradesValue: CardEdgesvalue, CardID: selected_CardID, ChosenGrading: Grading)
                    
                default:
                    break
                }

            case 1:
                
                switch ChosenGrading {
                
                case "Corners":
                    CardCornersvalue.SelectedBGS = selectedCells
                    CardCornersvalue.BGS = GlobalAverage
                    
                    SaveGrades.saveGradesvalue(GradesValue: CardCornersvalue, CardID: selected_CardID, ChosenGrading: Grading)
                    
                case "Surface":
                    CardSurfacevalue.SelectedBGS = selectedCells
                    CardSurfacevalue.BGS = GlobalAverage
                    
                    SaveGrades.saveGradesvalue(GradesValue: CardSurfacevalue, CardID: selected_CardID, ChosenGrading: Grading)
                    
                case "Edges":
                    CardEdgesvalue.SelectedBGS = selectedCells
                    CardEdgesvalue.BGS = GlobalAverage
                    
                    SaveGrades.saveGradesvalue(GradesValue: CardEdgesvalue, CardID: selected_CardID, ChosenGrading: Grading)
                    
                default:
                    break
                }
                
            case 2:
                
                switch ChosenGrading {
                
                case "Corners":
                    
                    CardCornersvalue.SelectedSGC = selectedCells
                    CardCornersvalue.SGC = GlobalAverage
                    
                    SaveGrades.saveGradesvalue(GradesValue: CardCornersvalue, CardID: selected_CardID, ChosenGrading: Grading)

                case "Surface":

                    CardSurfacevalue.SelectedSGC = selectedCells
                    CardSurfacevalue.SGC = GlobalAverage
                    
                    SaveGrades.saveGradesvalue(GradesValue: CardSurfacevalue, CardID: selected_CardID, ChosenGrading: Grading)
                    
                case "Edges":
                    
                    CardEdgesvalue.SelectedSGC = selectedCells
                    CardEdgesvalue.SGC = GlobalAverage
                    
                    SaveGrades.saveGradesvalue(GradesValue: CardEdgesvalue, CardID: selected_CardID, ChosenGrading: Grading)
                    
                default:
                    break
                }
                
              
            default:
                break

            }
            
        
       LoadSelectedCells(ChosenGrading: ChosenGrading, Card_ID: selected_CardID)
        
    }
    
    
    
    
  }



