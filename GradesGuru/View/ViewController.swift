//
//  ViewController.swift
//  GradesGuru
//
//  Created by Superpower on 16/08/20.
//  Copyright © 2020 iMac superpower. All rights reserved.
//

import UIKit
import Segmentio

var ChosenGrading = String()
var ChosenGradingIndex = Int()
var GradeDetails = ["Centering", "Corners", "Surface", "Edges"]


class ViewController: UIViewController {
   
    @IBOutlet var segmentioView: Segmentio!
    @IBOutlet var TitleView: UIView!
    
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
        
//        segmentioView.setup(content: content, style: .onlyLabel, options: SegmentioOptions(backgroundColor: .white, segmentPosition: .dynamic, scrollEnabled: true, indicatorOptions: SegmentioIndicatorOptions(type: .bottom, ratio: 1.0, height: 5.0, color: UIColor(red: 83.0, green: 117.0, blue: 252.0, alpha: 1.0)), horizontalSeparatorOptions: SegmentioHorizontalSeparatorOptions(type: SegmentioHorizontalSeparatorType.bottom, height: 0.5, color: .lightGray), verticalSeparatorOptions: SegmentioVerticalSeparatorOptions(ratio: 0, color: .gray), imageContentMode: .center, labelTextAlignment: .center, labelTextNumberOfLines: 1, segmentStates: SegmentioStates(defaultState: SegmentioState(backgroundColor: .clear,titleFont:UIFont.systemFont(ofSize: UIFont.smallSystemFontSize),titleTextColor: .black),selectedState: SegmentioState(backgroundColor: UIColor(red: 83.0/255.0, green: 117.0/255.0, blue: 252.0/255.0, alpha: 1.0),titleFont: UIFont.systemFont(ofSize: UIFont.smallSystemFontSize),titleTextColor: .white),highlightedState: SegmentioState(backgroundColor: UIColor.lightGray.withAlphaComponent(0.6),titleFont:UIFont.boldSystemFont(ofSize: UIFont.smallSystemFontSize),titleTextColor: .black)), animationDuration: 0.1))
    
        segmentioView.selectedSegmentioIndex = 0
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        SegmentioBuilder.buildSegmentioView(
            segmentioView: segmentioView,
            segmentioStyle: segmentioStyle
        )
        
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
    
//    private func initNavigationItemTitleView() {
//        let titleView = UILabel()
//        let subView = UILabel()
//
//        titleView.text = "Hello World"
//        subView.text = "Subview"
//
//        titleView.font = UIFont(name: "HelveticaNeue-Medium", size: 17)
//        subView.font = UIFont(name: "HelveticaNeue-Medium", size: 13)
//
//        let width = titleView.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)).width
//        let subwidth = subView.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)).width
//
//        titleView.frame = CGRect(origin:CGPoint.zero, size:CGSize(width: width, height: 500))
//        subView.frame = CGRect(origin:CGPoint.zero, size:CGSize(width: subwidth, height: 500))
//
//        self.navigationItem.titleView = titleView
//        self.navigationItem.titleView?.addSubview(subView)
//
////        let recognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController().titleWasTapped()))
//
//
//    }
    
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
    
    @IBAction func showAlertController(_ sender: Any) {
        // 1.
        

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
        
        performSegue(withIdentifier: "centering", sender: self)
        
//        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
//            let imagePicker = UIImagePickerController()
//            imagePicker.delegate = self
//            imagePicker.sourceType = UIImagePickerController.SourceType.camera
//            imagePicker.allowsEditing = true
//            self.present(imagePicker, animated: true, completion: nil)
//        }
//        else
//        {
//            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//            self.present(alert, animated: true, completion: nil)
//        }
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
       return 4
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
             
       var cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier")

              if cell == nil {
                  cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cellIdentifier")
              }

              cell!.textLabel?.text = GradeDetails[indexPath.row]
              cell!.detailTextLabel?.text = "Review"

              return cell!
      }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        ChosenGrading = GradeDetails[indexPath.row]
        ChosenGradingIndex = indexPath.row
        
        print("indexPath: \(indexPath.row)")
        print("ChosenGrading: \(ChosenGrading)")
        
        if ChosenGrading == "Centering" {
            
            print("Centering Chosen")
            
        } else {
            
            let popup = (self.storyboard?.instantiateViewController(withIdentifier: "GradesChoiceTVC"))!
            
            popup.modalPresentationStyle = .fullScreen
             
            self.present(popup, animated: true, completion: nil)
            
        }
        
    }
}

