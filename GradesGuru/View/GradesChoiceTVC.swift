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
import LoadingPlaceholderView

var purpleimage = UIImage(named: "TVC_Border_Purple.svg")
var whiteimage = UIImage(named: "TVC_Border.svg")
var selectedCells = [Int:Double]()
var selected_CardID = String()

class GradesChoiceTVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
  //  let loadingPlaceholderView = LoadingPlaceholderView()
    var GradingDownloadStatus = ["Corners":false,"Surface":false, "Edges":false]

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
        menuView.didSelectItemAtIndexHandler = {(indexPath: Int) -> Void in
            print("Did select item at index: \(indexPath)")
            
            ChosenGrading = GradeDetails[indexPath]
            
            self.loadspreadsheet(chosenGrading: ChosenGrading)
            
//            self.selectedCellLabel.text = GradeDetails[indexPath]
        }
        
        self.navigationItem.titleView = menuView

        loadspreadsheet(chosenGrading: ChosenGrading)
     
        segmentioView.valueDidChange = { segmentio, segmentIndex in
            print("Selected item: ", segmentIndex)
            
            self.selected_Segment = segmentIndex
            self.tableView.reloadData()
            
        }
        
      
    }
    
    func loadspreadsheet(chosenGrading: String) {
        
        let filename = chosenGrading
        let filetype = "xlsx"
        let filepath : String = Bundle.main.path(forResource: filename, ofType: filetype)!
        
        guard let file = XLSXFile(filepath: filepath) else {
            
          fatalError("XLSX file at \(filepath) is corrupted or does not exist")
        
        }
        
            do {
                
                var columnAStrings = [String]()
                var columnBStrings = [String]()
                var columnCStrings = [String]()
                
                for wbk in try file.parseWorkbooks() {
                            
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
                                        
                                        print("storedWorksheet[ChosenGrading]![0]: \(storedWorksheet[ChosenGrading]![0])")

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
                                        GradingDownloadStatus[chosenGrading] = true
                                        
                                        print("GradingDownloadStatus: \(GradingDownloadStatus)")
                                        SaveGrades.saveSGC(SGCValue: SGCDetails1, Key: worksheetName)
                                        
                                        Load_PSA_BGS_SGC(GradingType: chosenGrading)
                                        
                                    default:
                                        
                                        print("Default")
                                    }
                                  
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
    
    private func setupLoadingPlaceholderView() {
//        loadingPlaceholderView.gradientColor = .white
//        loadingPlaceholderView.backgroundColor = .white
    }
    
    
    func Load_PSA_BGS_SGC(GradingType: String) {

        print("Load_PSA_BGS_SGC_GradingType\(GradingType)")
        
//        if GradingDownloadStatus[ChosenGrading] == false {
//
//            loadingPlaceholderView.cover(view)
//
//        }
        
        PSAGrade = LoadGrades.loadPSA(Key: storedWorksheet[GradingType]![0]).PSAGrade
        PSADesc = LoadGrades.loadPSA(Key: storedWorksheet[GradingType]![0]).PSADesc
        PSAState = LoadGrades.loadPSA(Key: storedWorksheet[GradingType]![0]).PSAState

        BGSGrade = LoadGrades.loadBGS(Key: storedWorksheet[GradingType]![1]).BGSGrade
        BGSDesc = LoadGrades.loadBGS(Key: storedWorksheet[GradingType]![1]).BGSDesc
        BGSState = LoadGrades.loadBGS(Key: storedWorksheet[GradingType]![1]).BGSState

        SGCGrade = LoadGrades.loadSGC(Key: storedWorksheet[GradingType]![2]).SGCGrade
        SGCDesc = LoadGrades.loadSGC(Key: storedWorksheet[GradingType]![2]).SGCDesc
        SGCState = LoadGrades.loadSGC(Key: storedWorksheet[GradingType]![2]).SGCState

        tableView.reloadData()
        
    }
    
    func LoadSelectedCells(ChosenGrading: String, Card_ID: String) {
        
        switch ChosenGrading {
        
        case "Corners":
            PSASelected = LoadGrades.loadGradesvalue(CardID: Card_ID, ChosenGrading:ChosenGrading)[0].SelectedPSA ?? [0:0.0]
            BGSSelected = LoadGrades.loadGradesvalue(CardID: Card_ID, ChosenGrading:ChosenGrading)[0].SelectedBGS ?? [0:0.0]
            SGCSelected = LoadGrades.loadGradesvalue(CardID: Card_ID, ChosenGrading:ChosenGrading)[0].SelectedSGC ?? [0:0.0]
            
            print("Corners PSASelected, BGSSelected, SGCSelected: \(PSASelected), \(BGSSelected), \(SGCSelected)")
            
        case "Surface":
            PSASelected = LoadGrades.loadGradesvalue(CardID: Card_ID, ChosenGrading:ChosenGrading)[1].SelectedPSA ?? [0:0.0]
            BGSSelected = LoadGrades.loadGradesvalue(CardID: Card_ID, ChosenGrading:ChosenGrading)[1].SelectedBGS ?? [0:0.0]
            SGCSelected = LoadGrades.loadGradesvalue(CardID: Card_ID, ChosenGrading:ChosenGrading)[1].SelectedSGC ?? [0:0.0]
            
            print("Surface PSASelected, BGSSelected, SGCSelected: \(PSASelected), \(BGSSelected), \(SGCSelected)")

        case "Edges":
            PSASelected = LoadGrades.loadGradesvalue(CardID: Card_ID, ChosenGrading:ChosenGrading)[2].SelectedPSA ?? [0:0.0]
            BGSSelected = LoadGrades.loadGradesvalue(CardID: Card_ID, ChosenGrading:ChosenGrading)[2].SelectedBGS ?? [0:0.0]
            SGCSelected = LoadGrades.loadGradesvalue(CardID: Card_ID, ChosenGrading:ChosenGrading)[2].SelectedSGC ?? [0:0.0]
            
            print("Edges PSASelected, BGSSelected, SGCSelected: \(PSASelected), \(BGSSelected), \(SGCSelected)")

        default:
            break
        }
        
        tableView.reloadData()
        
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
        print("selected_Segment in Cell for row at index path")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GradingCells

        let backgroundImage = UIImageView(frame: cell.bounds)
        backgroundImage.clipsToBounds = true
        backgroundImage.contentMode = .scaleToFill
     
        if selectedCells[indexPath.row] != nil {
            
            if selectedCells.count <= 2 {
            
                cell.backgroundView = UIImageView(image: whiteimage)
                
            }
            
            selectedCells.removeValue(forKey: indexPath.row)
            print("1.selected cells: \(selectedCells)")

            selected_Grading(Grading: ChosenGrading, Segment: selected_Segment)
            

        } else {
            
            if selectedCells.count < 2 {
                
                print("2.Start: \(selectedCells)")
                cell.backgroundView = UIImageView(image: purpleimage)
                
                let myselectedcells = Double(indexPath.row)

                selectedCells[indexPath.row] = myselectedcells
                
                
                print("2.selected cells: \(selectedCells)")
                
                selected_Grading(Grading: ChosenGrading, Segment: selected_Segment)
                
            }
            
        }
      
        tableView.reloadRows(at: [indexPath], with: .automatic)

    }
    
    func selected_Grading(Grading: String, Segment: Int) {
        
        let GradesValue = [CardCornersvalue, CardSurfacevalue, CardEdgesvalue]


            switch selected_Segment {
            
            case 0:
                CardCornersvalue.SelectedPSA = selectedCells
                SaveGrades.saveGradesvalue(GradesValue: GradesValue, CardID: selected_CardID, ChosenGrading: Grading)
                
            case 1:
                CardCornersvalue.SelectedBGS = selectedCells
                SaveGrades.saveGradesvalue(GradesValue: GradesValue, CardID: selected_CardID, ChosenGrading: Grading)
            case 2:
                CardCornersvalue.SelectedSGC = selectedCells
                SaveGrades.saveGradesvalue(GradesValue: GradesValue, CardID: selected_CardID, ChosenGrading: Grading)

            default:
                break

            }
            
        
       LoadSelectedCells(ChosenGrading: ChosenGrading, Card_ID: selected_CardID)
        
    }

    
  }
