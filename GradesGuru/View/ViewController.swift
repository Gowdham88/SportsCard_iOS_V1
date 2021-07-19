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

var CardCornersvalue = Corners(Device_ID: Usersdetails.device_ID, Card_ID: CardDetails.Card_ID, Pictures: [""], Corners_Value: 0.0, PSA: 0.0, SelectedPSA: [0:0], BGS: 0.0, SelectedBGS: [0:0], SGC: 0.0, SelectedSGC: [0:0], viewonPSA: "")
var CardSurfacevalue = Corners(Device_ID: Usersdetails.device_ID, Card_ID: CardDetails.Card_ID, Pictures: [""], Corners_Value: 0.0, PSA: 0.0, SelectedPSA: [0:0], BGS: 0.0, SelectedBGS: [0:0], SGC: 0.0, SelectedSGC: [0:0], viewonPSA: "")
var CardEdgesvalue = Corners(Device_ID: Usersdetails.device_ID, Card_ID: CardDetails.Card_ID, Pictures: [""], Corners_Value: 0.0, PSA: 0.0, SelectedPSA: [0:0], BGS: 0.0, SelectedBGS: [0:0], SGC: 0.0, SelectedSGC: [0:0], viewonPSA: "")

class ViewController: UIViewController {
   
    @IBOutlet var segmentioView: Segmentio!
    @IBOutlet var TitleView: UIView!
    @IBOutlet var myTableView: UITableView!
    

    var content = [SegmentioItem]()
    let PSAtitle = SegmentioItem(title: "PSA", image: nil)
    let BGStitle = SegmentioItem(title: "BGS", image: nil)
    let SGCtitle = SegmentioItem(title: "SGC", image: nil)

    @IBOutlet weak var scanfrontPage: UIImageView!
    @IBOutlet weak var scanBackPage: UIImageView!
    
    @IBOutlet weak var frontScanBtn: UIButton!
    @IBOutlet weak var backScanBtn: UIButton!
    
    @IBOutlet weak var gradeEstLbl: UILabel!
    @IBOutlet weak var completeLbl: UILabel!
    
    var segmentioStyle = SegmentioStyle.onlyLabel

    var selected_img = ""
    var isfrontAdded: Bool = false
    var isbackAdded: Bool = false
    var isFrontImage: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TitleView = setTitle(title: "Enter a Name", subtitle: "SubTitle")
        
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
    
    var selected_Segment = Int()
    var FinalValue = String()

    override func viewDidAppear(_ animated: Bool) {
        
        SegmentioBuilder.buildSegmentioView(
            segmentioView: segmentioView,
            segmentioStyle: segmentioStyle
        )
        
        let defaults = UserDefaults.standard
        
        if defaults.data(forKey: "\(selected_CardID),\(ChosenGrading)") != nil {
        
            print("\(selected_CardID),\(ChosenGrading)")

                         for (index,value) in GradeDetails.enumerated() {

                LoadCardGradeValues(ChosenGrading: value, Card_ID: selected_CardID)

            }
            
        } else {
            
            let key = "\(selected_CardID),\(ChosenGrading)"
            print("No data stored under \(key)")
            
        }
        
        segmentioView.valueDidChange = { segmentio, segmentIndex in
            print("Selected item: ", segmentIndex)
            
            self.selected_Segment = segmentIndex
            self.myTableView.reloadData()
            
        }
        
        
    }
    

    func SearchValues(PSA: Double, BGS: Double, SGC: Double, chosenGrading: String) -> Double {
        
        print("Search Values")
        
      /*  var columnAStrings = Load_Default_Grade_Values.LoadGradesArrayStrings(column: "A")
        var columnBStrings = Load_Default_Grade_Values.LoadGradesArrayStrings(column: "B")
        var columnCStrings = Load_Default_Grade_Values.LoadGradesArrayStrings(column: "C")
        var columnDStrings = Load_Default_Grade_Values.LoadGradesArrayStrings(column: "D")
        var columnEStrings = Load_Default_Grade_Values.LoadGradesArrayStrings(column: "E")
        var columnFStrings = Load_Default_Grade_Values.LoadGradesArrayStrings(column: "F")
        var columnGStrings = Load_Default_Grade_Values.LoadGradesArrayStrings(column: "G")

        let stringGlobalPSA = String(GlobalPSA)
        print("stringGlobalPSA\(stringGlobalPSA)")
        
        
        let result = columnFStrings.contains(where: stringGlobalPSA.contains)
        print(result)
        
        let itemExists = columnFStrings.contains(where: {
            $0.range(of: stringGlobalPSA, options: .caseInsensitive) != nil
        })
        print(itemExists)

        let matchingTerms = columnFStrings.filter({
            $0.range(of: stringGlobalPSA, options: .caseInsensitive) != nil
        })
        print(matchingTerms)
        
        let findIndex = columnFStrings.firstIndex(of: stringGlobalPSA)
        
        print("findIndex: \(findIndex)")
        
//        let searchText = columnFStrings.filter { $0.contains(GlobalPSA) }
        
//        print("searchText\(searchText)")
        
        
//        if columnFStrings.contains("\(GlobalPSA)") {
            
            print("GlobalPSA: \(GlobalPSA)")
            
        for (index, value) in columnFStrings.enumerated() {
            
            print("Inside First For Loop Enumerated")
            
           if Double(value) == GlobalPSA {
                
                print("VALUE EQUALS GLOBAL PSA")
            /*
//            if columnEStrings.contains("\(GlobalBGS)") {
                
                print("GlobalBGS: \(GlobalBGS)")
                
               for (index1, myvalue1) in columnEStrings.dropLast(index).enumerated() {
                    
                  print("Inside SECOND FOR Loop Enumerated")
                    print("For Loop GlobalBGS: \(GlobalBGS)")
                    print("For Loop myvalue1: \(myvalue1)")
                    
                 if Double(myvalue1) == GlobalBGS {
                        
//                    if columnGStrings.contains("\(GlobalSGC)") {
                        
                        print("Inside If GlobalBGS: \(GlobalBGS)")

                         for (index2, myvalue2) in columnGStrings.dropLast(index1).enumerated() {
                             
                             print("Inside THIRD FOR Loop Enumerated")
                             print("For Loop GlobalBGS: \(GlobalSGC)")
                             print("For Loop myvalue2: \(myvalue2)")
                             
                             if Double(myvalue2) == GlobalSGC {
                                 
                                 print("GOT A HIT")
                                 
                                 print("GlobalSGC: \(GlobalSGC)")
                                 
                                 print("Center columnAStrings[index2]: \(columnAStrings[index2])")
                                 print("Corner columnBStrings[index2]:\(columnBStrings[index2])")
                                 print("Surface columnCStrings[index2]: \(columnCStrings[index2])")
                                 print("Edges columnDStrings[index2]: \(columnDStrings[index2])")
                                 
                                 switch ChosenGrading {
                                 
                                 case "Corners":
                                     FinalValue = "\(columnBStrings[index2])"
                                     
 //                                return Double(FinalValue)!
                                     
                                 case "Surface":
                                     FinalValue = "\(columnCStrings[index2])"
                                     
 //                                return Double(FinalValue)!
                                     
                                 case "Edges":
                                     FinalValue = "\(columnDStrings[index2])"
 //                                return Double(FinalValue)!
                                     
                                 default:
                                     break
                                     
                                 }
                                 
                            }
                             
                        }
//                    } else {
//
//                    print("GLOBAL SGC NOT AVAILABLE INSIDE THIS ARRAY")
//
//                        }
                        
                    }
                    
                }
                
//            } else {
//
//
//                print("columnFStrings does not have this BGS value: \(GlobalBGS)")
//
//            }*/
                
            } else {
                
                print("BGS NOT equal")
            }
            
            
            }
        
            print("FinalValue: \(FinalValue)")
            return Double(FinalValue)!
            
//        } else {
//
//            print("VALUE NOT AVAILABLE")
//            return 0.0
//
//        }
        */
        
        return 0.0
    }
    
    
    func LoadCardGradeValues(ChosenGrading: String, Card_ID: String) {
        
        print("LoadCardGradeValues, Chosen Grading: \(ChosenGrading)")
        
        CardDetails = LoadCards.loadCardsDetails(Card_ID: Card_ID)
        
        scanfrontPage.image = CardDetails.Card_frontImage
        scanBackPage.image = CardDetails.Card_BackImage
        
        switch ChosenGrading {
        
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
        title: "Submit", style: .default) {
            (action) -> Void in

            if let Title = TitleTextField?.text {
                print(" Title = \(Title)")
                
                if let subTitle = subTitleTextField?.text {
                    print("subTitle = \(subTitle)")
                    
                    self.TitleView = self.setTitle(title: Title, subtitle: subTitle)
                } else {
                    print("No subTitle entered")
                }
                
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
            
            CardDetails = CardDetailsMaster(Device_ID: Device_ID, Card_ID: Card_ID, Card_frontImage: scanfrontPage.image ?? UIImage(named: "Scan"), Card_BackImage: scanBackPage.image ?? UIImage(named: "Scan"), PlayerName: "", Sport: 0, Year: 0, Set: "123", VariationColour: "123", CardNo: 1, Rookie: 1, Autograph: "123", Patch: "123", ScannedDate: "123")

            CardCornersvalue = Corners(Device_ID: Device_ID, Card_ID: Card_ID, Pictures: [""], Corners_Value: 0.0, PSA: 0.0, SelectedPSA: [0:0], BGS: 0.0, SelectedBGS: [0:0], SGC: 0.0, SelectedSGC: [0:0], viewonPSA: "")
            
//            CardSurfacevalue = Corners(Device_ID: Device_ID, Card_ID: Card_ID, Pictures: [""], Corners_Value: 0.0, PSA: 0.0, SelectedPSA: [:], BGS: 0.0, SelectedBGS: [:], SGC: 0.0, SelectedSGC: [:], viewonPSA: "")
//            CardEdgesvalue = Corners(Device_ID: Device_ID, Card_ID: Card_ID, Pictures: [""], Corners_Value: 0.0, PSA: 0.0, SelectedPSA: [:], BGS: 0.0, SelectedBGS: [:], SGC: 0.0, SelectedSGC: [:], viewonPSA: "")
            
            var GradesValue = [Corners]()
            GradesValue.append(CardCornersvalue)
            GradesValue.append(CardSurfacevalue)
            GradesValue.append(CardSurfacevalue)
            

            if CardIDs.contains(Card_ID) {
                
                print("Card ID present")
                SaveCards.saveCardsvalue(CardsValue: CardDetails, Card_ID: Card_ID)

                for grades in GradeDetails {
                    
                    print("grades CardIDs.contains(Card_ID) : \(grades)")
                    
                    SaveGrades.saveGradesvalue(GradesValue: CardCornersvalue, CardID: Card_ID, ChosenGrading: grades)
                    
                }
                
            } else {
                
                print("New Card ID")
                CardIDs.append(Card_ID)
                SaveCards.saveCardsvalue(CardsValue: CardDetails, Card_ID: Card_ID)
                SaveCards.saveCardIDs(Cards: CardIDs, Device_ID: Device_ID)
                
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
            print("Overall Grading")
        default:
            break
        }
        
        
    case 1:
        
        switch indexPath.row {
        case 0:
            print("Centering")
            
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
            print("Overall Grading")
        default:
            break
        }
        
        
        
    case 2:
        
        switch indexPath.row {
        case 0:
            print("Centering")
            
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
            print("Overall Grading")
            
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
            
        } else {
            
            let popup = (self.storyboard?.instantiateViewController(withIdentifier: "GradesChoiceTVC"))!
            
            popup.modalPresentationStyle = .fullScreen
             
            self.present(popup, animated: true, completion: nil)
            
        }
        
    }
    
}

