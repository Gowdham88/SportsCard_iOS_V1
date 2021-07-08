//
//  CenteringTVC.swift
//  GradesGuru
//
//  Created by Superpower on 26/02/21.
//  Copyright © 2021 iMac superpower. All rights reserved.
//

import UIKit
import Segmentio

class CenteringTVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
  
    
    @IBOutlet var segmentioView: Segmentio!
    @IBOutlet var myTableview: UITableView!
    @IBOutlet var leftView: UIView!
    @IBOutlet var rightView: UIView!
    
    @IBOutlet var leftImageView: UIImageView!
    @IBOutlet var rightImageView: UIImageView!
    var selected_img = ""
    var isLeftimage = Bool()
    var isRightimage = Bool()

    @IBAction func goBack(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    var content = [SegmentioItem]()
    let PSAtitle = SegmentioItem(title: "PSA", image: nil)
    let BGStitle = SegmentioItem(title: "BGS", image: nil)
    let SGCtitle = SegmentioItem(title: "SGC", image: nil)
    var segmentioStyle = SegmentioStyle.onlyLabel

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.

        switch segmentioStyle {
        case .onlyLabel, .imageBeforeLabel, .imageAfterLabel:
            print("Only Label")
        case .onlyImage:
            
            print("Only Image")
        default:
            break
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
            
            centeringImage = CardDetails.Card_frontImage
            
        } else {
            
            print("sender.tag: \(String(describing: (sender as AnyObject).tag))")
            centeringImage = CardDetails.Card_BackImage

        }
        
        let popup = (self.storyboard?.instantiateViewController(withIdentifier: "GradingView"))!
        
        popup.modalPresentationStyle = .fullScreen
         
        self.present(popup, animated: true, completion: nil)
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
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "centerCell", for: indexPath) as! CenteringCell

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
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
