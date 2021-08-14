//
//  ViewController.swift
//  GradesGuru
//
//  Created by Superpower on 16/08/20.
//  Copyright © 2020 iMac superpower. All rights reserved.
//

import UIKit
import Foundation
import Segmentio

var ChosenGrading = String()
var ChosenGradingIndex = Int()
var GradeDetails = ["Centering", "Corners", "Surface", "Edges", "Overall Grade"]

var CardCentervalue = Corners(Device_ID: Usersdetails.device_ID, Card_ID: CardDetails.Card_ID, Pictures: [""], Corners_Value: 0.0, PSA: 0.0, SelectedPSA: [0:0], BGS: 0.0, SelectedBGS: [0:0], SGC: 0.0, SelectedSGC: [0:0], viewonPSA: "")
var CardCornersvalue = Corners(Device_ID: Usersdetails.device_ID, Card_ID: CardDetails.Card_ID, Pictures: [""], Corners_Value: 0.0, PSA: 0.0, SelectedPSA: [0:0], BGS: 0.0, SelectedBGS: [0:0], SGC: 0.0, SelectedSGC: [0:0], viewonPSA: "")
var CardSurfacevalue = Corners(Device_ID: Usersdetails.device_ID, Card_ID: CardDetails.Card_ID, Pictures: [""], Corners_Value: 0.0, PSA: 0.0, SelectedPSA: [0:0], BGS: 0.0, SelectedBGS: [0:0], SGC: 0.0, SelectedSGC: [0:0], viewonPSA: "")
var CardEdgesvalue = Corners(Device_ID: Usersdetails.device_ID, Card_ID: CardDetails.Card_ID, Pictures: [""], Corners_Value: 0.0, PSA: 0.0, SelectedPSA: [0:0], BGS: 0.0, SelectedBGS: [0:0], SGC: 0.0, SelectedSGC: [0:0], viewonPSA: "")

class ViewController: UIViewController {
   
    @IBOutlet var segmentioView: Segmentio!
    @IBOutlet var TitleView: UIView!
    @IBOutlet var myTableView: UITableView!
    
    var selected_Segment = Int()
    var FinalValue = String()
    
    var content = [SegmentioItem]()
    let PSAtitle = SegmentioItem(title: "PSA", image: nil)
    let BGStitle = SegmentioItem(title: "BGS", image: nil)
    let SGCtitle = SegmentioItem(title: "SGC", image: nil)

    var segmentioStyle = SegmentioStyle.onlyLabel

    var selected_img = ""
    var isfrontAdded: Bool = false
    var isbackAdded: Bool = false
    var isFrontImage: Bool = false
    
    @IBOutlet weak var scanfrontPage: UIImageView!
    @IBOutlet weak var scanBackPage: UIImageView!
    
    @IBOutlet weak var frontScanBtn: UIButton!
    @IBOutlet weak var backScanBtn: UIButton!
    
    @IBOutlet weak var gradeEstLbl: UILabel!
    @IBOutlet weak var completeLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let homekey = "Home: \(selected_CardID)"
        let defaults =  UserDefaults.standard

        print("Load Home, Key : \(homekey)")

        if defaults.data(forKey: homekey) != nil {
                
            Homedetails = LoadHome(cardID: selected_CardID)
            CardDetails = LoadCards.loadCardsDetails(Card_ID: selected_CardID)
            
            if Homedetails.Name != nil {
                
            TitleView = setTitle(title: Homedetails.Name, subtitle: Homedetails.SubTitle)          
                
            } else {

            TitleView = setTitle(title: "Enter a Name", subtitle: "SubTitle")
                
            }
                
        } else {
            
            TitleView = setTitle(title: "Enter a Name", subtitle: "SubTitle")
            
        }
        
        
        
        switch segmentioStyle {
        
        case .onlyLabel, .imageBeforeLabel, .imageAfterLabel:
            print("Only Label")
        case .onlyImage:
            
            print("Only Image")
        default:
            break
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(verifyFrontImageAdded(notification:)), name: Notification.Name("frontImgSelected"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(verifyBackImageAdded(notification:)), name: Notification.Name("backImgSelected"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(bothImageAdded(notification:)), name: Notification.Name("bothImageAdded"), object: nil)
      
        //Upload image action:
        
        let tapFrontImg = UITapGestureRecognizer(target: self, action: #selector(scanFrontPage(tapGestureRecognizer:)))
        scanfrontPage.isUserInteractionEnabled = true
        scanfrontPage.addGestureRecognizer(tapFrontImg)
        
        let tapBackImg = UITapGestureRecognizer(target: self, action: #selector(scanBackPage(tapGestureRecognizer:)))
        scanBackPage.isUserInteractionEnabled = true
        scanBackPage.addGestureRecognizer(tapBackImg)
        
        content.append(PSAtitle)
        content.append(BGStitle)
        content.append(SGCtitle)
        
        segmentioView.selectedSegmentioIndex = 0
        
        if CardIDs.contains(selected_CardID) {
            
            print("CardID Available ")
            
            CardDetails = LoadCards.loadCardsDetails(Card_ID: selected_CardID)
            
            print("CardDetails.Card_ID: \(CardDetails.Card_ID)")
            
            scanfrontPage.image = CardDetails.Card_frontImage
            scanBackPage.image = CardDetails.Card_BackImage
            
        } else {
            
            print("Card ID not available")
            
        }
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        SegmentioBuilder.buildSegmentioView(
            segmentioView: segmentioView,
            segmentioStyle: segmentioStyle
        )
        
        
        print("selected_CardID,ChosenGrading:\(selected_CardID),\(ChosenGrading)")
        
        segmentioView.valueDidChange = { segmentio, segmentIndex in
            
            print("Selected item: ", segmentIndex)
            
            self.SearchData()
            
            self.selected_Segment = segmentIndex
            self.myTableView.reloadData()
            
        }
        
       
        
    }
    
    
    func SearchData() {
        
        let defaults = UserDefaults.standard

        let key = "GradesArrayStringsA"
           
        if defaults.data(forKey: key) != nil {
            
            switch selected_Segment {
              
              case 0:
              
                 if CardCentervalue.PSA != 0.0 || CardCornersvalue.PSA != 0.0 || CardSurfacevalue.PSA != 0.0 || CardEdgesvalue.PSA != 0.0 {
                     
                    SearchValues(Center: CardCentervalue.PSA!, Corner: CardCornersvalue.PSA!, Surface: CardSurfacevalue.PSA!, Edge: CardEdgesvalue.PSA!)
                     
                     Homedetails.PSA = String(GlobalPSA)
                    
                     SaveHome(HomeMaster: Homedetails, cardID: selected_CardID)

                 }

              case 1:
                  
                 if CardCentervalue.BGS != 0.0 || CardCornersvalue.BGS != 0.0 || CardSurfacevalue.BGS != 0.0 || CardEdgesvalue.BGS != 0.0 {
                     
                     SearchValues(Center: CardCentervalue.BGS!, Corner: CardCornersvalue.BGS!, Surface: CardSurfacevalue.BGS!, Edge: CardEdgesvalue.BGS!)
                      
                      Homedetails.BGS = String(GlobalBGS)
                      SaveHome(HomeMaster: Homedetails, cardID: selected_CardID)

                     
                 }
                 
              case 2:
                  
                 if CardCentervalue.SGC != 0.0 || CardCornersvalue.SGC != 0.0 || CardSurfacevalue.SGC != 0.0 || CardEdgesvalue.SGC != 0.0 {
                     
                    SearchValues(Center: CardCentervalue.SGC!, Corner: CardCornersvalue.SGC!, Surface: CardSurfacevalue.SGC!, Edge: CardEdgesvalue.SGC!)
                      
                      Homedetails.SGC = String(GlobalSGC)
                      SaveHome(HomeMaster: Homedetails, cardID: selected_CardID)

                     
                 }
                 
              default:
                  break

              }
            
            if defaults.data(forKey: "\(selected_CardID),\(ChosenGrading)") != nil {
            
                print("\(selected_CardID),\(ChosenGrading)")

                for (index,value) in GradeDetails.enumerated() {

                    LoadCardGradeValues(ChosenGrading: value, Card_ID: selected_CardID)

                }
                
            } else {
                
                let key = "\(selected_CardID),\(ChosenGrading)"
                print("No data stored under \(key)")
                
            }
            
            
        } else {
            
            print("No Data Available")
            
        }
        
        
    }

    func SearchValues(Center: Double, Corner: Double, Surface: Double, Edge: Double) {
        
        print("Search Values")
        
        let CenterStarting_Numbers = ["10.0":1,"9.5":432,"9.0":1392,"8.5":2662,"8.0":3983,"7.5":5452,"7.0":6697,"6.5":8018,"6.0":8926,"5.5":9956,"5.0":10487,"4.5":11234,"4.0":11620,"3.5":12180,"3.0":12394,"2.5":12724,"2.0":12833,"1.5":12972,"1.0":13023,"0.5":13056,"0.0":13060]
        
        let CenterEnding_Numbers = ["10.0":432,"9.5":1392,"9.0":2662,"8.5":3983,"8.0":5452,"7.5":6697,"7.0":8018,"6.5":8926,"6.0":9956,"5.5":10487,"5.0":11234,"4.5":11620,"4.0":12180,"3.5":12394,"3.0":12724,"2.5":12833,"2.0":12972,"1.5":13023,"1.0":13056,"0.5":13060,"0.0":13061]
        
        let CenterValue = String(Center)
        let CornerValue = String(Corner)
        let SurfaceValue = String(Surface)
        let EdgeValue = String(Edge)
        var OverallGrading = String()
        
        print("CenterValue, CornerValue, SurfaceValue, EdgeValue: \(CenterValue), \(CornerValue), \(SurfaceValue), \(EdgeValue)")
        
        let columnA_CenterStrings = Load_Default_Grade_Values.LoadGradesArrayStrings(column: "A")
        let columnB_CornerStrings = Load_Default_Grade_Values.LoadGradesArrayStrings(column: "B")
        let columnC_SurfaceStrings = Load_Default_Grade_Values.LoadGradesArrayStrings(column: "C")
        let columnD_EdgesStrings = Load_Default_Grade_Values.LoadGradesArrayStrings(column: "D")

        for i in CenterStarting_Numbers[CenterValue]!..<CenterEnding_Numbers[CenterValue]! {
            
            let Center_Double = Double(columnA_CenterStrings[i])
            let CenterString = String(format: "%.1f", Center_Double!)
            
            print("FOR LOOP i VALUE: \(i)")
            
            if CenterString == CenterValue {
                
                print("YES CENTER EQUAL: \(CenterValue)")
                
                let Corner_Double = Double(columnB_CornerStrings[i])
                let CornerString = String(format: "%.1f", Corner_Double!)
                
                if CornerString == CornerValue {
                    
                    print("YES CORNER EQUAL: \(CornerValue)")
                    
                    let Surface_Double = Double(columnC_SurfaceStrings[i])
                    let SurfaceString = String(format: "%.1f", Surface_Double!)
                    
                    print("SurfaceString, SurfaceValue: \(SurfaceString), \(SurfaceValue)")

                    if SurfaceString == SurfaceValue {
                    
                        print("YES SURFACE EQUAL: \(SurfaceValue)")
                        
                        let Edge_Double = Double(columnD_EdgesStrings[i])
                        let EdgeString = String(format: "%.1f", Edge_Double!)
                        
                        print("EdgeString, EdgeValue: \(EdgeString), \(EdgeValue)")
                        
                        if EdgeString == EdgeValue {
                        
                            print("YES EDGE EQUAL: \(EdgeValue)")
                            
                            
                            switch selected_Segment {
                            case 0:
                                
                                let columnF_PSAStrings = Load_Default_Grade_Values.LoadGradesArrayStrings(column: "F")
                                
                                print("columnF_PSAStrings[i]: \(columnF_PSAStrings[i])")
                                
                                Homedetails.PSA = columnF_PSAStrings[i]
                                
                                GlobalPSA = Double(columnF_PSAStrings[i])!
                                
                                SaveHome(HomeMaster: Homedetails, cardID: selected_CardID)
                            case 1:
                                
                                let columnE_BGSStrings = Load_Default_Grade_Values.LoadGradesArrayStrings(column: "E")
                                
                                Homedetails.BGS = columnE_BGSStrings[i]
                                
                                GlobalBGS = Double(columnE_BGSStrings[i])!
                                
                                SaveHome(HomeMaster: Homedetails, cardID: selected_CardID)
                            case 2:
                                
                                let columnG_SGCStrings = Load_Default_Grade_Values.LoadGradesArrayStrings(column: "G")
                                
                                Homedetails.SGC = columnG_SGCStrings[i]
                                
                                GlobalSGC = Double(columnG_SGCStrings[i])!
                                
                                SaveHome(HomeMaster: Homedetails, cardID: selected_CardID)
                            default:
                                break
                            }
                            
//                            myTableView.reloadData()
                    }
                        
                }
                
                }
            }
            
        }
        
        
//        let indexvalues = columnA_CenterStrings.enumerated().filter({$0.element == CenterValue}).map({$0.offset})
//
//        //columnA_CenterStrings.indexes(of: CenterValue)
//
//        print("indexvalues: \(indexvalues)")
        
       /* for i in 0..<columnA_CenterStrings.count {
            
            if CenterValue == columnA_CenterStrings[i] {
                
                if columnB_CornerStrings[i] == CornerValue {
                    
                    if columnC_SurfaceStrings[i] == SurfaceValue {
                        
                        if columnD_EdgesStrings[i] == EdgeValue {
                            
                            print("Overall PSA: \(columnF_PSAStrings[i])")

                            //                            print("Overall BGS: \(columnE_BGSStrings[index])")
//                            print("Overall SGC: \(columnG_SGCStrings[index])")
                            
                            break
                        }
                        
                    }
                    
                }
                
            }
            
//            if CenterValue == value {
//
//                print("CENTER VALUE TRUE: \(CenterValue),\(value)")
//
//                for (index1, value1) in columnB_CornerStrings.enumerated() {
//
//                    if CornerValue == value1 {
//
//                        print("CORNER VALUE TRUE1 \(CornerValue),\(value1)")
//
//                        for (index2, value2) in columnC_SurfaceStrings.enumerated() {
//
//                            if SurfaceValue == value2 {
//
//                                print("CENTER VALUE, CORNER VALUE, SURFACE VALUE TRUE1: \(CenterValue), \(CornerValue), \(SurfaceValue),\(value2)")
//
//                                OverallGrading = "Testing"
//
//                            }
//
//                        }
//
//                    }
//
//                }
//            }
        }*/
//        return OverallGrading

    }
    
    
    func LoadCardGradeValues(ChosenGrading: String, Card_ID: String) {
        
        print("LoadCardGradeValues, Chosen Grading, Card ID: \(ChosenGrading), \(Card_ID)")
        
        CardDetails = LoadCards.loadCardsDetails(Card_ID: Card_ID)
        
        scanfrontPage.image = CardDetails.Card_frontImage
        scanBackPage.image = CardDetails.Card_BackImage
        
        switch ChosenGrading {
        
        case "Centering":
            
            CardCentervalue = LoadCenterGrades.loadCenterGradesvalue(CardID: Card_ID, ChosenGrading: ChosenGrading)
            
            
//            CardCornersvalue.Corners_Value = SearchValues(PSA: CardCornersvalue.PSA!, BGS: CardCornersvalue.BGS!, SGC: CardCornersvalue.SGC!, chosenGrading: ChosenGrading)
            
            print("CardCornersvalue.Corners_Value: \(CardCornersvalue.Corners_Value)")
            
        
        case "Corners":
            
            CardCornersvalue = LoadGrades.loadGradesvalue(CardID: Card_ID, ChosenGrading:ChosenGrading)
            
//            CardCornersvalue.Corners_Value = SearchValues(PSA: CardCornersvalue.PSA!, BGS: CardCornersvalue.BGS!, SGC: CardCornersvalue.SGC!, chosenGrading: ChosenGrading)
            
            print("CardCornersvalue.Corners_Value: \(CardCornersvalue.Corners_Value)")
            
            
        case "Surface":
            
            CardSurfacevalue = LoadGrades.loadGradesvalue(CardID: Card_ID, ChosenGrading:ChosenGrading)
            
//            CardSurfacevalue.Corners_Value = SearchValues(PSA: CardSurfacevalue.PSA!, BGS: CardSurfacevalue.BGS!, SGC: CardSurfacevalue.SGC!, chosenGrading: ChosenGrading)
           
            print("CardSurfacevalue.Corners_Value: \(CardSurfacevalue.Corners_Value)")
            
        case "Edges":
            
            CardEdgesvalue = LoadGrades.loadGradesvalue(CardID: Card_ID, ChosenGrading:ChosenGrading)
            
//            CardEdgesvalue.Corners_Value = SearchValues(PSA: CardEdgesvalue.PSA!, BGS: CardEdgesvalue.BGS!, SGC: CardEdgesvalue.SGC!, chosenGrading: ChosenGrading)
            
            print("CardEdgesvalue.Corners_Value: \(CardEdgesvalue.Corners_Value)")
            
        case "Overall Grade":
            
            Homedetails = LoadHome(cardID: selected_CardID)
            
            print("Overall Home Details Grade: \(Homedetails.PSA), \(Homedetails.BGS), \(Homedetails.SGC)")
            
            
        default:
            break
        }
        
            
            print("PSA, BGS, SGC: \(GlobalPSA), \(GlobalBGS), \(GlobalSGC)")
            
        myTableView.reloadData()
    
    }
    
    @objc func scanFrontPage(tapGestureRecognizer: UITapGestureRecognizer) {
        selected_img = "front_img"
        print(":::::FrontImage view tapped ::::::")
        scanImageOption()
        
    }
    
    @objc func scanBackPage(tapGestureRecognizer: UITapGestureRecognizer) {
        selected_img = "back_img"
        print(":::::BackImage view tapped ::::::")
        scanImageOption()
        
    }
    
    @IBAction func infoBtnAction(_ sender: Any) {
        showViewInfo()
    }
    
    @IBAction func frontReScanBtnTapped(_ sender: Any) {
        scanImageOption()
    }
    
    @IBAction func back_Pressed(_ sender: Any) {
        
        _ = navigationController?.popToRootViewController(animated: true)
        
    }
    
    @objc func verifyFrontImageAdded(notification: Notification) {
        if isFrontImage {
            
            print("£££ front Image added £££")
            self.frontScanBtn.isHidden = false
            self.isfrontAdded = true
            
        } else {
            
            print("£££ front Image empty £££")
            self.frontScanBtn.isHidden = true
            self.isfrontAdded = false
            
        }
        
    }
    
    @objc func verifyBackImageAdded(notification: Notification) {
        if isFrontImage {
            
            print("£££ back Image added £££")
            self.backScanBtn.isHidden = false
            self.isbackAdded = true
            
        } else {
            
            print("£££ back Image empty £££")
            self.backScanBtn.isHidden = true
            self.isbackAdded = false
        }
        
    }
    
    @objc func bothImageAdded(notification: Notification) {
        if isfrontAdded && isbackAdded {
            
            self.completeLbl.textColor = .systemGreen
            self.gradeEstLbl.textColor = .systemGreen
            
        } else {
            
            self.completeLbl.textColor = .systemBlue
            self.gradeEstLbl.textColor = .systemBlue

        }
        
    }
    
    @objc private func titleWasTapped() {
        NSLog("Hello, titleWasTapped!")

        var TitleTextField: UITextField?
        var subTitleTextField: UITextField?

        // 2.
        let alertController = UIAlertController(
            title: "Card Title",
            message: "Please enter your Card Details",
            preferredStyle: .alert)

        // 3.
        let Submit = UIAlertAction(
            title: "Submit", style: .default) { [self]
            (action) -> Void in
            
            if let Title = TitleTextField?.text {
                print(" Title = \(Title)")
                
                Homedetails.Name = Title
                CardDetails.PlayerName = Title
                
                if let subTitle = subTitleTextField?.text {
                    print("subTitle = \(subTitle)")
                
                    Homedetails.SubTitle = subTitle
                    
                    self.TitleView = self.setTitle(title: Title, subtitle: subTitle)
                    
                    print("CardDetails.PlayerName under SubTitle: \(CardDetails.PlayerName)")
                    
                    SaveCards.saveCardsvalue(CardsValue: CardDetails, Card_ID: selected_CardID)
                    SaveHome(HomeMaster: Homedetails, cardID: selected_CardID)
                    
                } else {
                    
                    print("No subTitle entered")
                    
                    self.TitleView = self.setTitle(title: Title, subtitle: "")
                    
                }
                
                SaveCards.saveCardsvalue(CardsValue: CardDetails, Card_ID: selected_CardID)
                SaveHome(HomeMaster: Homedetails, cardID: selected_CardID)
                
            } else {
                print("No Title entered")
            }

        }
        
        let Cancel = UIAlertAction(
        title: "Cancel", style: .default) {
            (action) -> Void in

           print("Cancelled")
        }

        // 4.
        alertController.addTextField {
            (txtTitle) -> Void in
            TitleTextField = txtTitle
            TitleTextField!.placeholder = "<Your Title here>"
        }

        alertController.addTextField {
            (txtSubTitle) -> Void in
            subTitleTextField = txtSubTitle
            subTitleTextField?.placeholder = "<Your subTitle here>"
        }

        // 5.
        alertController.addAction(Submit)
        alertController.addAction(Cancel)
        present(alertController, animated: true, completion: nil)
        
    }
    
    func setTitle(title:String, subtitle:String) -> UIView {
        
        TitleView.subviews.forEach({ $0.removeFromSuperview() })

        let width = TitleView.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)).width

        let titleLabel = UILabel(frame: CGRect(x: -20, y: 0, width: 100, height: 50))
        
        //(frame: CGRect(origin:CGPoint.zero, size:CGSize(width: width, height: 500))) // CGRect(0, -2, 0, 0))

        titleLabel.backgroundColor = .clear
        titleLabel.textColor = .black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        titleLabel.text = title
        titleLabel.sizeToFit()

        let subtitleLabel = UILabel(frame: CGRect(x: -200, y: 18, width: 100, height: 50))
        subtitleLabel.backgroundColor = .clear
        subtitleLabel.textColor = .black
        subtitleLabel.font = UIFont.systemFont(ofSize: 12)
        subtitleLabel.text = subtitle
        subtitleLabel.sizeToFit()

//        let titleView = UIView(frame: CGRect(x: 80, y: 0, width: max(titleLabel.frame.size.width, subtitleLabel.frame.size.width), height: 30))
        
        //UIView(frame: CGRectMake(0, 0, max(titleLabel.frame.size.width, subtitleLabel.frame.size.width), 30))
        TitleView.backgroundColor = .clear
        TitleView.frame = CGRect(x: 0, y: 0, width: 60, height: 40)
        
        TitleView.addSubview(titleLabel)
        TitleView.addSubview(subtitleLabel)
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(titleWasTapped))
        
        TitleView.isUserInteractionEnabled = true
        TitleView.addGestureRecognizer(recognizer)

        let widthDiff = subtitleLabel.frame.size.width - titleLabel.frame.size.width

        if widthDiff < 0 {
            let newX = widthDiff / 2
            subtitleLabel.frame.origin.x = abs(newX)
        } else {
            let newX = widthDiff / 2
            titleLabel.frame.origin.x = newX
        }
        
        return TitleView
    }
    
}


extension ViewController {
    
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
            
//            let Device_ID = Usersdetails.device_ID
//            let Card_ID = "CZ\(CardNumber)"
//
//
//            CardDetails = CardDetailsMaster(Device_ID: Device_ID!, Card_ID: Card_ID, PlayerName: "", Sport: 0, Year: 0, Set: "", VariationColour: "", CardNo: 1, Rookie: 1, Autograph: "", Patch: "", ScannedDate: Date())
//
//            CardCornersvalue = Corners(Device_ID: Device_ID!, Card_ID: Card_ID, Pictures: [""], Corners_Value: 0.0, PSA: 0.0, SelectedPSA: [0:0.0], BGS: 0.0, SelectedBGS: [0:0.0], SGC: 0.0, SelectedSGC: [0:0.0], viewonPSA: "")
//
//            CardIDs.append(Card_ID)
//
//            SaveCards.saveCardsvalue(CardsValue: CardDetails, Card_ID: Card_ID)
//            SaveCards.saveCardIDs(Cards: CardIDs, Device_ID: Device_ID!)

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
    
    func showViewInfo() {
        //self.navigationController?.navigationBar.isHidden = true
        let infoPage = self.storyboard?.instantiateViewController(withIdentifier: "InfoVc") as! InfoVc
        infoPage.modalPresentationStyle = .overCurrentContext
        self.present(infoPage, animated: true, completion: nil)
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK:-- ImagePicker delegate
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
            if selected_img == "front_img"
            {
                
            self.scanfrontPage.image = pickedImage
            self.isFrontImage = true
                
            NotificationCenter.default.post(name: Notification.Name("frontImgSelected"), object: nil)
            NotificationCenter.default.post(name: Notification.Name("bothImageAdded"), object: nil)

            self.scanfrontPage.layer.cornerRadius = 8.0
            self.scanfrontPage.layer.masksToBounds = true
            self.scanfrontPage.layer.borderColor = UIColor.gray.cgColor
            self.scanfrontPage.layer.borderWidth = 1.0
                
            self.scanfrontPage.isHidden = false
            self.scanfrontPage.contentMode = .scaleAspectFill
                
            
            }
            else{
                
                self.scanBackPage.image = pickedImage
                
                NotificationCenter.default.post(name: Notification.Name("backImgSelected"), object: nil)
                NotificationCenter.default.post(name: Notification.Name("bothImageAdded"), object: nil)

                self.scanBackPage.layer.cornerRadius = 8.0
                self.scanBackPage.layer.masksToBounds = true
                self.scanBackPage.layer.borderColor = UIColor.gray.cgColor
                self.scanBackPage.layer.borderWidth = 1.0
                
                self.scanBackPage.isHidden = false
                self.scanBackPage.contentMode = .scaleAspectFill
                
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
            
            CardDetails = CardDetailsMaster(Device_ID: Device_ID, Card_ID: Card_ID, Card_frontImage: scanfrontPage.image ?? UIImage(named: "Scan"), Card_BackImage: scanBackPage.image ?? UIImage(named: "Scan"), PlayerName: "Enter Player Name", Sport: 0, Year: 0, Set: "123", VariationColour: "123", CardNo: "Enter Card #", Rookie: 1, Autograph: "123", Patch: "123", ScannedDate: "123")
            
            Homedetails = HomeMaster(device_ID: Device_ID, CardID: Card_ID, DisplayCardPicture: Date(), Name: "Enter Name", SubTitle: " Enter SubTitle", PSA: "", BGS: "", SGC: "", ScanTime: Date())

//            CardCornersvalue = Corners(Device_ID: Device_ID, Card_ID: Card_ID, Pictures: [""], Corners_Value: 0.0, PSA: 0.0, SelectedPSA: [0:0], BGS: 0.0, SelectedBGS: [0:0], SGC: 0.0, SelectedSGC: [0:0], viewonPSA: "")
            
//            CardSurfacevalue = Corners(Device_ID: Device_ID, Card_ID: Card_ID, Pictures: [""], Corners_Value: 0.0, PSA: 0.0, SelectedPSA: [:], BGS: 0.0, SelectedBGS: [:], SGC: 0.0, SelectedSGC: [:], viewonPSA: "")
            
//            CardEdgesvalue = Corners(Device_ID: Device_ID, Card_ID: Card_ID, Pictures: [""], Corners_Value: 0.0, PSA: 0.0, SelectedPSA: [:], BGS: 0.0, SelectedBGS: [:], SGC: 0.0, SelectedSGC: [:], viewonPSA: "")
            
            var GradesValue = [Corners]()
            GradesValue.append(CardCornersvalue)
            GradesValue.append(CardSurfacevalue)
            GradesValue.append(CardSurfacevalue)

            if CardIDs.contains(Card_ID) {
                
                print("Card ID present")
                SaveCards.saveCardsvalue(CardsValue: CardDetails, Card_ID: Card_ID)
                
               // Homedetails.CardID = Card_ID
                
                SaveHome(HomeMaster: Homedetails, cardID: selected_CardID)

                for grades in GradeDetails {
                    
                    print("grades CardIDs.contains(Card_ID) : \(grades)")
                    
                    SaveGrades.saveGradesvalue(GradesValue: CardCornersvalue, CardID: Card_ID, ChosenGrading: grades)
                    
                }
                
            } else {
                
                print("New Card ID")
                CardIDs.append(Card_ID)
                SaveCards.saveCardsvalue(CardsValue: CardDetails, Card_ID: Card_ID)
                SaveCards.saveCardIDs(Cards: CardIDs, Device_ID: Device_ID)
                
              //  Homedetails.CardID = Card_ID

                SaveHome(HomeMaster: Homedetails, cardID: Card_ID)

                for grades in GradeDetails {
                    
                    print("grades New Card ID: \(grades)")
                    
                    SaveGrades.saveGradesvalue(GradesValue: CardCornersvalue, CardID: Card_ID, ChosenGrading: grades)
                    
                }

            }
                
            print("CardIDs: \(CardIDs)")
           
            picker.dismiss(animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource  {
    
    func numberOfSections(in tableView: UITableView) -> Int
   {
       return 1
   }


  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
   {
    return GradeDetails.count
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
             
    let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier") as! ViewControllerTableViewCell

//              if cell == nil {
//                cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cellIdentifier") as! ViewControllerTableViewCell
//              }

    cell.textLabel?.text = GradeDetails[indexPath.row]
//            cell!.detailTextLabel?.text = "Review"
    
    switch selected_Segment {
    case 0:
        
        switch indexPath.row {
        case 0:
            print("Centering")
            cell.Grade_Value.text = String(CardCentervalue.PSA!)
            
        case 1:
            print("Corners")
            cell.Grade_Value.text = String(CardCornersvalue.PSA!)

        case 2:
            print("Surface")
            
            cell.Grade_Value.text = String(CardSurfacevalue.PSA!)

        case 3:
            print("Edges")
            cell.Grade_Value.text = String(CardEdgesvalue.PSA!)
            
        case 4:
            print("PSA Overall Grading: \(Homedetails.PSA)")
            cell.Grade_Value.text = String(Homedetails.PSA!)
            
        default:
            break
        }
        
        
    case 1:
        
        switch indexPath.row {
        case 0:
            print("Centering")
            cell.Grade_Value.text = String(CardCentervalue.BGS!)
            
        case 1:
            print("Corners")
            cell.Grade_Value.text = String(CardCornersvalue.BGS!)

        case 2:
            print("Surface")
            
            cell.Grade_Value.text = String(CardSurfacevalue.BGS!)

        case 3:
            print("Edges")
            cell.Grade_Value.text = String(CardEdgesvalue.BGS!)
            
        case 4:
            print("BGS Overall Grading; \(Homedetails.BGS)")
            cell.Grade_Value.text = String(Homedetails.BGS!)
        default:
            break
        }
        
        
    case 2:
        
        switch indexPath.row {
        case 0:
            print("Centering")
            cell.Grade_Value.text = String(CardCentervalue.SGC!)
            
        case 1:
            print("Corners")
            cell.Grade_Value.text = String(CardCornersvalue.SGC!)

        case 2:
            print("Surface")
            
            cell.Grade_Value.text = String(CardSurfacevalue.SGC!)

        case 3:
            print("Edges")
            cell.Grade_Value.text = String(CardEdgesvalue.SGC!)
            
        case 4:
            print("SGC Overall Grading: \(Homedetails.SGC)")
            
            cell.Grade_Value.text = String(Homedetails.SGC!)
            
        default:
            break
        }
        
    default:
        break
    }
//    switch indexPath.row {
//
//    case 0:
//
//        cell?.detailTextLabel?.text = "Centering Data"
//
//    case 1:
//
//        cell?.detailTextLabel?.text = "\(CardCornersvalue.Corners_Value)"
//
//    case 2:
//
//        cell?.detailTextLabel?.text = "\(CardSurfacevalue.Corners_Value)"
//
//    case 3:
//
//        cell?.detailTextLabel?.text = "\(CardEdgesvalue.Corners_Value)"
//
//    default:
//        cell?.detailTextLabel?.text = "Review"
//
//    }

            return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        ChosenGrading = GradeDetails[indexPath.row]
        ChosenGradingIndex = indexPath.row
        
        print("indexPath: \(indexPath.row)")
        print("ChosenGrading: \(ChosenGrading)")
        
        if ChosenGrading == "Centering" {
            
            print("Centering Chosen")
            
            let popup = (self.storyboard?.instantiateViewController(withIdentifier: "CenteringView"))!
            
            popup.modalPresentationStyle = .fullScreen
             
            self.present(popup, animated: true, completion: nil)
            
        } else if ChosenGrading == "Overall Grade" {
          
            print("Do Nothing - Overall Grade")
            
        } else {
            
            let popup = (self.storyboard?.instantiateViewController(withIdentifier: "GradesChoiceTVC"))!
            
            popup.modalPresentationStyle = .fullScreen
             
            self.present(popup, animated: true, completion: nil)
            
        }
        
    }
    
}

extension Array where Element: Equatable {
    
    func indexes(of element: Element) -> [Int] {
        
        return self.enumerated().filter({element == $0.element}).map({$0.offset})
        
    }
    
}

