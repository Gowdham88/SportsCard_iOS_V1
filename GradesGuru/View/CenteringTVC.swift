//
//  CenteringTVC.swift
//  GradesGuru
//
//  Created by Superpower on 26/02/21.
//  Copyright © 2021 iMac superpower. All rights reserved.
//

import UIKit
import Foundation
import Segmentio
import CoreXLSX
import BTNavigationDropdownMenu



var selected_img = ""

class CenteringTVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    
    var menuView: BTNavigationDropdownMenu!
    var segmentioStyle = SegmentioStyle.onlyLabel
    var content = [SegmentioItem]()
    let PSAtitle = SegmentioItem(title: "PSA", image: nil)
    let BGStitle = SegmentioItem(title: "BGS", image: nil)
    let SGCtitle = SegmentioItem(title: "SGC", image: nil)
    
    var isLeftimage = Bool()
    var isRightimage = Bool()
    var storedWorksheet = ["Centering": ["Centering_PSA", "Centering_BGS", "Centering_SGC"]]
    var GradingDownloadStatus = ["Centering":false]
    
    var PSACenterGrade = [String]()
    var PSACenterDesc = [String]()
    var PSACenterFront = [String]()
    var PSACenterBack = [String]()
    var PSACenterSelected = [Int:Int]()
    
    var BGSCenterGrade = [String]()
    var BGSCenterDesc = [String]()
    var BGSCenterFront = [String]()
    var BGSCenterBack = [String]()
    var BGSCenterSelected = [Int:Int]()
    
    var SGCCenterGrade = [String]()
    var SGCCenterDesc = [String]()
    var SGCCentering = [String]()
    var SGCCenterSelected = [Int:Int]()
    var selectedCenterCell = [Int:Int]()
    var didselectcell = false
    var selected_Segment = Int()
    let defaults = UserDefaults.standard


    
    @IBOutlet var segmentioView: Segmentio!

    @IBOutlet var myTableview: UITableView!
    
    @IBOutlet var leftView: UIView!
    @IBOutlet var rightView: UIView!
    
    @IBOutlet var Front_Right_Left: UILabel!
    @IBOutlet var Front_Top_Bottom: UILabel!
    @IBOutlet var Back_Right_Left: UILabel!
    @IBOutlet var Back_Top_Bottom: UILabel!
    
    @IBOutlet var leftImageView: UIImageView!
    @IBOutlet var rightImageView: UIImageView!
    @IBOutlet var centerButtonImage1: UIImageView!
    @IBOutlet var centerButtonImage2: UIImageView!
    
    @IBOutlet var centerLeft: UIButton!
    @IBOutlet var centerRight: UIButton!

    @IBAction func goBack(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        loadCenteringSpreadsheet(chosenGrading: "Centering")

        self.myTableview.allowsSelection = (1 != 0)
        segmentioView.selectedSegmentioIndex = 0

        // Do any additional setup after loading the view.

        switch segmentioStyle {
        
        case .onlyLabel, .imageBeforeLabel, .imageAfterLabel:
            print("Only Label")
        case .onlyImage:
            
            print("Only Image")
        default:
            break
        }
        
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
//            Load_Centering_PSA_BGS_SGC(GradingType: ChosenGrading)
            
        }
        
        self.navigationItem.titleView = menuView
     
        segmentioView.valueDidChange = { segmentio, segmentIndex in
            print("Selected item: ", segmentIndex)
            
            self.selected_Segment = segmentIndex
            self.myTableview.reloadData()
            
        }
        
        if defaults.value(forKey: "CenterFirstTime") != nil {
            
            print("Loading More than Once")
            Load_Centering_PSA_BGS_SGC(GradingType: ChosenGrading)
         
        } else {
            
            self.saveSpreadsheet()
            defaults.set(true, forKey: "CenterFirstTime")

        }
        
        
        content.append(PSAtitle)
        content.append(BGStitle)
        content.append(SGCtitle)
        
        segmentioView.selectedSegmentioIndex = 0
        
        segmentioView.alpha = 0
        myTableview.alpha = 0
        leftView.alpha = 0
        rightView.alpha = 0
        
        let tapLeftImg = UITapGestureRecognizer(target: self, action: #selector(leftImageFn(tapGestureRecognizer:)))
        leftImageView.isUserInteractionEnabled = true
        leftImageView.addGestureRecognizer(tapLeftImg)
        
        let tapRightImg = UITapGestureRecognizer(target: self, action: #selector(rightImageFn(tapGestureRecognizer:)))
        rightImageView.isUserInteractionEnabled = true
        rightImageView.addGestureRecognizer(tapRightImg)
        
        if CardIDs.contains(selected_CardID) {
            
            print("CardID Available ")
            
            CardDetails = LoadCards.loadCardsDetails(Card_ID: selected_CardID)
            
            print("CardDetails.Card_ID: \(CardDetails.Card_ID)")
            
            leftImageView.image = CardDetails.Card_frontImage
            rightImageView.image = CardDetails.Card_BackImage
            
            ImageResize(Image: leftImageView)
            ImageResize(Image: rightImageView)
            
        } else {
            
            print("Card ID not available")
            
        }
        
    }
    
    func saveSpreadsheet() {
        
        let grading = ["Centering"]

        for grd in grading {
            
            loadCenteringSpreadsheet(chosenGrading: grd)
            
        }
        
//        loadGradingdataSheet()
        
    }
    
  
        func loadCenteringSpreadsheet(chosenGrading: String) {
            
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
                    var columnDStrings = [String]()
                    
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
                                        
                                        columnDStrings = worksheet.cells(atColumns: [ColumnReference("D")!])
                                         .compactMap { $0.stringValue(sharedStrings) }
                                        
                                        print("storedWorksheet[ChosenGrading]: \(storedWorksheet[ChosenGrading])")
                                        print("worksheetName: \(worksheetName)")
                                            
                                        switch sheetIndex {
                                        
                                        case 0:
                                            
                                            print("Saving Centering PSA from worksheet")
                                            
                                            PSACenterGrade = columnAStrings
                                            PSACenterDesc = columnBStrings
                                            PSACenterFront = columnCStrings
                                            PSACenterBack = columnDStrings
                                            
                                            let PSADetails1 : CenterPSADetails =  CenterPSADetails(PSAGrade: PSACenterGrade, PSADesc: PSACenterDesc, PSAFront: PSACenterFront, PSABack: PSACenterBack)
                                            
    //                                        print("storedWorksheet[ChosenGrading]![0]: \(storedWorksheet[ChosenGrading]![0])")

                                            SaveCenterGrades.saveCenterPSA(CenterPSAValue: PSADetails1, Key: storedWorksheet[ChosenGrading]![0])
                                            //SaveGrades.savePSA(PSAValue: PSADetails1, Key: worksheetName)
    //                                        Load_PSA_BGS_SGC(GradingType: chosenGrading)

                                        
                                        case 1:
                                            
                                            print("Saving Centering BGS from worksheet")
                                            
                                            BGSCenterGrade = columnAStrings
                                            BGSCenterDesc = columnBStrings
                                            BGSCenterFront = columnCStrings
                                            BGSCenterBack = columnDStrings
                                            
                                            let BGSDetails1 : CenterBGSDetails = CenterBGSDetails(BGSGrade: BGSCenterGrade, BGSDesc: BGSCenterDesc, BGSFront: BGSCenterFront, BGSBack: BGSCenterBack)

                                            SaveCenterGrades.saveCenterBGS(CenterBGSValue: BGSDetails1, Key: storedWorksheet[ChosenGrading]![1])
//                                            SaveGrades.saveBGS(BGSValue: BGSDetails1, Key: worksheetName)
    //                                        Load_PSA_BGS_SGC(GradingType: chosenGrading)
                                            
                                        case 2:
                                            
                                            print("Saving SGC from worksheet")
                                            
                                            SGCCenterGrade = columnAStrings
                                            SGCCenterDesc = columnBStrings
                                            SGCCentering = columnCStrings
                                            
                                            let SGCDetails1 : CenterSGCDetails = CenterSGCDetails(SGCGrade: SGCCenterGrade, SGCDesc: SGCCenterDesc, SGCCentering: SGCCentering)

                                            GradingDownloadStatus[ChosenGrading] = true
                                            
                                            print("GradingDownloadStatus: \(GradingDownloadStatus)")
                                            
                                            SaveCenterGrades.saveCenterSGC(CenterSGCValue: SGCDetails1, Key: storedWorksheet[ChosenGrading]![2])
//                                             SaveGrades.saveSGC(SGCValue: SGCDetails1, Key: worksheetName)
                                            
                                            SaveCenterGrades.saveCenterGradesvalue(GradesValue: CardCentervalue, CardID: selected_CardID, ChosenGrading: ChosenGrading)
    //                                        Load_PSA_BGS_SGC(GradingType: chosenGrading)
                                            
                                        default:
                                            
                                            print("Default")
                                        }
                                      
                                    }
                    
                                }
                                
                                sheetIndex += 1
                                
                              }
                        
                        Load_Centering_PSA_BGS_SGC(GradingType: ChosenGrading)
                        
                    }
                    
    //                loadGradingdataSheet()
                    
                    
                } catch let error1 as NSError {
                    
                    print("Error: \(error1)")
                    
                } catch {
                    
                    print("Any other error")
                    
            }
                
    }
    
    
    func Load_Centering_PSA_BGS_SGC(GradingType: String) {

        print("Load_PSA_BGS_SGC_GradingType\(GradingType)")
        
        // LOADS DEFAULT PSA BGS AND SGC VALUES
        
        PSACenterGrade = LoadCenterGrades.loadCenterPSA(Key: storedWorksheet[GradingType]![0]).PSAGrade
        PSACenterDesc = LoadCenterGrades.loadCenterPSA(Key: storedWorksheet[GradingType]![0]).PSADesc
        PSACenterFront = LoadCenterGrades.loadCenterPSA(Key: storedWorksheet[GradingType]![0]).PSAFront
        PSACenterBack = LoadCenterGrades.loadCenterPSA(Key: storedWorksheet[GradingType]![0]).PSABack
        
        BGSCenterGrade = LoadCenterGrades.loadCenterBGS(Key: storedWorksheet[GradingType]![1]).BGSGrade
        BGSCenterDesc = LoadCenterGrades.loadCenterBGS(Key: storedWorksheet[GradingType]![1]).BGSDesc
        BGSCenterFront = LoadCenterGrades.loadCenterBGS(Key: storedWorksheet[GradingType]![1]).BGSFront
        BGSCenterBack = LoadCenterGrades.loadCenterBGS(Key: storedWorksheet[GradingType]![1]).BGSBack

        SGCCenterGrade = LoadCenterGrades.loadCenterSGC(Key: storedWorksheet[GradingType]![2]).SGCGrade
        SGCCenterDesc = LoadCenterGrades.loadCenterSGC(Key: storedWorksheet[GradingType]![2]).SGCDesc
        SGCCentering = LoadCenterGrades.loadCenterSGC(Key: storedWorksheet[GradingType]![2]).SGCCentering
        
        let key = "Center: \(selected_CardID),\(ChosenGrading)"


        print("Grades Loaded, CardID -Key : \(key)")
    
        if let data = defaults.data(forKey: key) {
            
            LoadSelectedCenteringCells(ChosenGrading: ChosenGrading, Card_ID: selected_CardID)
            
        } else {
            
            print("NO CENTERING DATA Available")
            myTableview.reloadData()
        }
        
        
    }
    
    func LoadSelectedCenteringCells(ChosenGrading: String, Card_ID: String) {
        
        print("ChosenGrading: \(ChosenGrading)")

        switch ChosenGrading {
        
        case "Centering":
            PSACenterSelected = LoadCenterGrades.loadCenterGradesvalue(CardID: Card_ID, ChosenGrading: ChosenGrading).SelectedPSA
            BGSCenterSelected = LoadCenterGrades.loadCenterGradesvalue(CardID: Card_ID, ChosenGrading: ChosenGrading).SelectedBGS
            SGCCenterSelected =  LoadCenterGrades.loadCenterGradesvalue(CardID: Card_ID, ChosenGrading: ChosenGrading).SelectedSGC
            
            print("Center PSASelected, BGSSelected, SGCSelected: \(PSACenterSelected), \(BGSCenterSelected), \(SGCCenterSelected)")
            
        default:
            break
        }
        
        if didselectcell == true {
            
            didselectcell = false
            
        } else {
            
            myTableview.reloadData()
            
        }

    }
    
    
    func ImageResize(Image: UIImageView) {
        
        Image.layer.cornerRadius = 8.0
        Image.layer.masksToBounds = true
        Image.layer.borderColor = UIColor.gray.cgColor
        Image.layer.borderWidth = 1.0
        Image.isHidden = false
        Image.contentMode = .scaleAspectFill
        
    }
    
    @objc func leftImageFn(tapGestureRecognizer: UITapGestureRecognizer) {
        
//        selected_img = "front_img"
        print(":::::LeftImage view tapped ::::::")
      
        selected_img = "left_img"
        
        scanImageOption()
        
    }
    
    @objc func rightImageFn(tapGestureRecognizer: UITapGestureRecognizer) {
        
//        selected_img = "front_img"
        
        print(":::::LeftImage view tapped ::::::")
      
        selected_img = "right_img"
        
        scanImageOption()
        
    }
    
    @IBAction func centerAction(_ sender: Any) {

        if (sender as AnyObject).tag == 0 {
            
            print("sender.tag: \(String(describing: (sender as AnyObject).tag))")
            
            selected_img = "left_img"
            centeringImage = CardDetails.Card_frontImage
            
        } else {
            
            print("sender.tag: \(String(describing: (sender as AnyObject).tag))")
            selected_img = "right_img"
            centeringImage = CardDetails.Card_BackImage

        }
        
        let popup = (self.storyboard?.instantiateViewController(withIdentifier: "GradingView"))!
        
        popup.modalPresentationStyle = .fullScreen
         
        self.present(popup, animated: true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        
        if CardIDs.contains(selected_CardID) {
            
            print("CardID Available ")
            
            CardDetails = LoadCards.loadCardsDetails(Card_ID: selected_CardID)
            
            print("CardDetails.Card_ID: \(CardDetails.Card_ID)")
            
            leftImageView.image = CardDetails.Card_frontImage
            rightImageView.image = CardDetails.Card_BackImage
            
            ImageResize(Image: leftImageView)
            ImageResize(Image: rightImageView)
            
        } else {
            
            print("Card ID not available")
            
        }
        
        if UserDefaults.standard.data(forKey: "center_cardID:\(selected_CardID)") != nil  {
            
            var FrontLeft:Int? = Int()
            var BackLeft:Int? = Int()
            
            if SaveCentering.loadCentering(cardID: selected_CardID).FrontLeft != nil {
                
                FrontLeft = SaveCentering.loadCentering(cardID: selected_CardID).FrontLeft
                leftView.alpha = 0.8
                
                leftView.layer.cornerRadius = leftView.frame.width / 32
                leftView.clipsToBounds = true
                
                centerLeft.alpha = 0
                centerButtonImage1.alpha = 0

                
                let rightvalue = SaveCentering.loadCentering(cardID: selected_CardID).FrontRight
                let leftvalue = SaveCentering.loadCentering(cardID: selected_CardID).FrontLeft
                let topvalue = SaveCentering.loadCentering(cardID: selected_CardID).FrontTop
                let bottomvalue = SaveCentering.loadCentering(cardID: selected_CardID).FrontBottom
                
                Front_Right_Left.text = "\(leftvalue!)/\(rightvalue!)"
                Front_Top_Bottom.text = "\(topvalue!)/\(bottomvalue!)"
                
            }
            
            if SaveCentering.loadCentering(cardID: selected_CardID).BackLeft != nil {
                
                BackLeft = SaveCentering.loadCentering(cardID: selected_CardID).BackLeft
                
                rightView.alpha = 0.8
                
                rightView.layer.cornerRadius = rightView.frame.width / 32
                rightView.clipsToBounds = true
                
                centerRight.alpha = 0
                centerButtonImage2.alpha = 0

                
                let rightvalue = SaveCentering.loadCentering(cardID: selected_CardID).BackRight
                let leftvalue = SaveCentering.loadCentering(cardID: selected_CardID).BackLeft
                let topvalue = SaveCentering.loadCentering(cardID: selected_CardID).BackTop
                let bottomvalue = SaveCentering.loadCentering(cardID: selected_CardID).BackBottom
                
                Back_Right_Left.text = "\(leftvalue!)/\(rightvalue!)"
                Back_Top_Bottom.text = "\(topvalue!)/\(bottomvalue!)"
                
            }
            
            if FrontLeft != nil && BackLeft != nil {
                
                segmentioView.alpha = 1
                myTableview.alpha = 1

            }
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
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
            GradeCount = PSACenterGrade.count - 1
        case 1:
            GradeCount = BGSCenterGrade.count - 1
        case 2:
            GradeCount = SGCCenterGrade.count - 1

        default:
            break
        }
        
        return GradeCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "centerCell", for: indexPath) as! CenteringCell

        var Grade = [String]()
        var Desc = [String]()
        var Front = [String]()
        var Back = [String]()
        var centering = [String]()
        
        switch selected_Segment {
        
        case 0:
            
            Grade = PSACenterGrade
            Desc = PSACenterDesc
            Front = PSACenterFront
            Back = PSACenterBack
            selectedCenterCell = PSACenterSelected
            
        case 1:

            Grade = BGSCenterGrade
            Desc = BGSCenterDesc
            Front = BGSCenterFront
            Back = BGSCenterBack
            selectedCenterCell = BGSCenterSelected

        case 2:

            Grade = SGCCenterGrade
            Desc = SGCCenterDesc
            centering = SGCCentering
            selectedCenterCell = SGCCenterSelected
            
        default:
            break
        }
       
        
        if indexPath.row < Grade.count {
            
            if selected_Segment == 2 {
                
                cell.SGC_Centering.alpha = 1
                cell.SGC_CenteringData.alpha = 1
                
                cell.Center_Front_Label.alpha = 0
                cell.Center_Back_Label.alpha = 0
                cell.center_Front.alpha = 0
                cell.center_Back.alpha = 0
                
                cell.center_Grade.text = Grade[indexPath.row + 1]
                cell.center_Desc.text = Desc[indexPath.row + 1]
                cell.SGC_CenteringData.text = centering[indexPath.row + 1]
                
                
            } else {
                
                cell.SGC_Centering.alpha = 0
                cell.SGC_CenteringData.alpha = 0
                
                cell.Center_Front_Label.alpha = 1
                cell.Center_Back_Label.alpha = 1
                cell.center_Front.alpha = 1
                cell.center_Back.alpha = 1
                
                cell.center_Grade.text = Grade[indexPath.row + 1]
                cell.center_Desc.text = Desc[indexPath.row + 1]
                cell.center_Front.text = Front[indexPath.row + 1]
                cell.center_Back.text = Back[indexPath.row + 1]
                
            }
           

            print("selectedCenterCell[indexPath.row]: \(selectedCenterCell[indexPath.row])")
            
            if (selectedCenterCell[indexPath.row] != nil) {
                
                cell.backgroundView = UIImageView(image: purpleimage)
                
            } else {
                
                cell.backgroundView = UIImageView(image: whiteimage)

            }
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        print("0.selectedCells: \(selectedCenterCell)")
        print("selected_Segment in Cell for row at index path: \(selected_Segment)")
        
        //using this Didselectcell Bool to reload data called under LoadSelectedCells function
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "centerCell", for: indexPath) as! CenteringCell
        let backgroundImage = UIImageView(frame: cell.bounds)
        backgroundImage.clipsToBounds = true
        backgroundImage.contentMode = .scaleToFill
     
        if (selectedCenterCell[indexPath.row] != nil)  {
            
            selectedCenterCell.removeAll()
            
//            didselectcell = false
            
            cell.backgroundView = UIImageView(image: whiteimage)
            
            print("selectedCells should be NIL -->: \(selectedCenterCell)")
            
            selected_Center_Grading(Grading: ChosenGrading, Segment: selected_Segment,indexPath: indexPath.row)
            
        } else {
            
            selectedCenterCell.removeAll()
            
//            didselectcell = true
            
            cell.backgroundView = UIImageView(image: purpleimage)
            
            selectedCenterCell[indexPath.row] = indexPath.row

            print("selectedCell -->: \(selectedCenterCell)")
            
            selected_Center_Grading(Grading: ChosenGrading, Segment: selected_Segment,indexPath: indexPath.row)

        }
        
        myTableview.reloadData()

    }
    
    func selected_Center_Grading(Grading: String, Segment: Int, indexPath: Int) {
        
            print("selected_Segment: \(selected_Segment)")
        
            switch selected_Segment {
            
            case 0:
                
                switch ChosenGrading {
                
                case "Centering":
                   
                    CardCentervalue.SelectedPSA = selectedCenterCell
                    CardCentervalue.PSA = Double(PSACenterGrade[indexPath + 1])

                    print("CardCentersvalue.PSA: \(CardCentervalue.PSA)")
                    
                    SaveCenterGrades.saveCenterGradesvalue(GradesValue: CardCentervalue, CardID: selected_CardID, ChosenGrading: Grading)
                    
                default:
                    break
                }

            case 1:
                
                switch ChosenGrading {
                
                case "Centering":
                    
                    CardCentervalue.SelectedBGS = selectedCenterCell
                    
                    CardCentervalue.BGS = Double(BGSCenterGrade[indexPath + 1])

                    SaveCenterGrades.saveCenterGradesvalue(GradesValue: CardCentervalue, CardID: selected_CardID, ChosenGrading: Grading)

                    print("CardCentersvalue.BGS: \(CardCentervalue.BGS)")

                default:
                    break
                }
                
            case 2:
                
                switch ChosenGrading {
                
                case "Centering":
                    
                    CardCentervalue.SelectedSGC = selectedCenterCell
//                    CardCornersvalue.SGC = GlobalAverage
                    
                    CardCentervalue.SGC = Double(SGCCenterGrade[indexPath + 1])

                    SaveCenterGrades.saveCenterGradesvalue(GradesValue: CardCentervalue, CardID: selected_CardID, ChosenGrading: Grading)
                    
                    print("CardCentersvalue.SGC: \(CardCentervalue.SGC)")
                    
                default:
                    break
                }
                
              
            default:
                break

            }
            
        
        LoadSelectedCenteringCells(ChosenGrading: ChosenGrading, Card_ID: selected_CardID)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
        func scanImageOption()
        {
            let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
                    alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
                        
                        self.openCamera()
                    }))

                    alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
                        self.openGallery()
                    }))

                    alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))

                    self.present(alert, animated: true, completion: nil)

        }
        
        func openCamera()
        {
            
    //        performSegue(withIdentifier: "centering", sender: self)
            
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerController.SourceType.camera
                imagePicker.allowsEditing = true

                self.present(imagePicker, animated: true, completion: nil)
                
            }
            
            else
            {
                let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            
        }

        func openGallery()
        {
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.allowsEditing = true
                imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
                
                        self.present(imagePicker, animated: true, completion: nil)
            }
            else
            {
                let alert  = UIAlertController(title: "Warning", message: "You don't have permission to access gallery.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
       
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var pickedImage : UIImage!

        if let img = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
                {
            pickedImage = img

                }
        else if let img = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
                {
            pickedImage = img
                }
        if selected_img == "left_img"
        {
            
        self.leftImageView.image = pickedImage
        self.isLeftimage = true
            
        NotificationCenter.default.post(name: Notification.Name("frontImgSelected"), object: nil)
        NotificationCenter.default.post(name: Notification.Name("bothImageAdded"), object: nil)

        self.leftImageView.layer.cornerRadius = 8.0
        self.leftImageView.layer.masksToBounds = true
        self.leftImageView.layer.borderColor = UIColor.gray.cgColor
        self.leftImageView.layer.borderWidth = 1.0
            
        self.leftImageView.isHidden = false
        self.leftImageView.contentMode = .scaleAspectFill
        
        }
        else{
            self.rightImageView.image = pickedImage
            
            NotificationCenter.default.post(name: Notification.Name("backImgSelected"), object: nil)
            NotificationCenter.default.post(name: Notification.Name("bothImageAdded"), object: nil)

            self.rightImageView.layer.cornerRadius = 8.0
            self.rightImageView.layer.masksToBounds = true
            self.rightImageView.layer.borderColor = UIColor.gray.cgColor
            self.rightImageView.layer.borderWidth = 1.0
            
            self.rightImageView.isHidden = false
            self.rightImageView.contentMode = .scaleAspectFill
            
        }
        
        let Device_ID = Usersdetails.device_ID!
        
        let defaults = UserDefaults.standard
        var CardNumber = 0
        
        if defaults.value(forKey: "cardNumber") != nil {
            
            CardNumber = defaults.value(forKey: "cardNumber") as! Int
            
        } else {
            
            CardNumber = 0
            
        }
        
        let Card_ID = "CZ\(CardNumber)"
        selected_CardID = Card_ID
        
        print("Device_ID: \(Device_ID)")
        print("Card_ID: \(Card_ID)")
        
//        CardDetails = CardDetailsMaster(Device_ID: Device_ID, Card_ID: Card_ID, Card_frontImage: scanfrontPage.image ?? UIImage(named: "Scan"), Card_BackImage: scanBackPage.image ?? UIImage(named: "Scan"), PlayerName: "", Sport: 0, Year: 0, Set: "123", VariationColour: "123", CardNo: 1, Rookie: 1, Autograph: "123", Patch: "123", ScannedDate: "123")
//
//        CardCornersvalue = Corners(Device_ID: Device_ID, Card_ID: Card_ID, Pictures: [""], Corners_Value: 0.0, PSA: 0.0, SelectedPSA: [:], BGS: 0.0, SelectedBGS: [:], SGC: 0.0, SelectedSGC: [:], viewonPSA: "")
        
        
//        var GradesValue = [Corners]()
//        GradesValue.append(CardCornersvalue)
//        GradesValue.append(CardSurfacevalue)
//        GradesValue.append(CardSurfacevalue)
//

        if CardIDs.contains(Card_ID) {
            
            print("Card ID present")
//            SaveCards.saveCardsvalue(CardsValue: CardDetails, Card_ID: Card_ID)
//
//            for grades in GradeDetails {
//
//                print("grades CardIDs.contains(Card_ID) : \(grades)")
//
//                SaveGrades.saveGradesvalue(GradesValue: CardCornersvalue, CardID: Card_ID, ChosenGrading: grades)
//
//            }
            
        } else {
            
            print("New Card ID")
//            CardIDs.append(Card_ID)
//            SaveCards.saveCardsvalue(CardsValue: CardDetails, Card_ID: Card_ID)
//            SaveCards.saveCardIDs(Cards: CardIDs, Device_ID: Device_ID)
//
//            for grades in GradeDetails {
//
//                print("grades New Card ID: \(grades)")
//
//                SaveGrades.saveGradesvalue(GradesValue: CardCornersvalue, CardID: Card_ID, ChosenGrading: grades)
//
//            }

        }
            
        print("CardIDs: \(CardIDs)")
       
        picker.dismiss(animated: true, completion: nil)
}
    
    

}
