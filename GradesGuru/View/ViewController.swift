//
//  ViewController.swift
//  GradesGuru
//
//  Created by Superpower on 16/08/20.
//  Copyright © 2020 iMac superpower. All rights reserved.
//

import UIKit
import Segmentio

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIGestureRecognizerDelegate  {
    
//    var imagePicker: UIImagePickerController!
    
    var pickerController = UIImagePickerController()
    var imageView = UIImage()


    @IBOutlet weak var scan_back_button: UIButton!
    
    @IBOutlet weak var scan_back_ImageView: UIImageView!
    
    @IBOutlet weak var scan_front_ImageView: UIImageView!
    
    @IBOutlet weak var segmentioView: Segmentio!
    
    var content = [SegmentioItem]()
    let PSAtitle = SegmentioItem(title: "PSA", image: nil)
    let BGStitle = SegmentioItem(title: "BGS", image: nil)
    let SGCtitle = SegmentioItem(title: "SGC", image: nil)
    var GradeDetails = ["Centering", "Corners", "Surface", "Edges"]
    
    @IBAction func BackButton(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func scan_Back(_ sender: Any) {
        
//        openCamera()
    }
    
    @IBAction func scan_Front(_ sender: Any) {
        
//        openCamera()
    }
    
//    func openCamera() {
//
//        if UIImagePickerController.isSourceTypeAvailable(.camera) {
//            let imagePicker = UIImagePickerController()
//            imagePicker.delegate = self
//            imagePicker.sourceType = .camera;
//            imagePicker.allowsEditing = false
//            self.present(imagePicker, animated: true, completion: nil)
//        }
//
//
//    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        scan_back_button.setImage(info[.originalImage] as? UIImage, for: .normal)
        
    }
    
//    private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
//        let image = info[UIImagePickerController.InfoKey.originalImage.rawValue] as! UIImage
//        imagePicked.image = image
//        dismiss(animated:true, completion: nil)
//    }
    
    
    func dismissDetail() {
        
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: kCATransition)
        dismiss(animated: false)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        content.append(PSAtitle)
        content.append(BGStitle)
        content.append(SGCtitle)
        
        segmentioView.setup(content: content, style: .onlyLabel, options: SegmentioOptions(backgroundColor: .white, segmentPosition: .dynamic, scrollEnabled: true, indicatorOptions: SegmentioIndicatorOptions(type: .bottom, ratio: 1.0, height: 5.0, color: UIColor(red: 83.0, green: 117.0, blue: 252.0, alpha: 1.0)), horizontalSeparatorOptions: SegmentioHorizontalSeparatorOptions(type: SegmentioHorizontalSeparatorType.bottom, height: 0.5, color: .lightGray), verticalSeparatorOptions: SegmentioVerticalSeparatorOptions(ratio: 0, color: .gray), imageContentMode: .center, labelTextAlignment: .center, labelTextNumberOfLines: 1, segmentStates: SegmentioStates(defaultState: SegmentioState(backgroundColor: .clear,titleFont: UIFont.systemFont(ofSize: UIFont.smallSystemFontSize),titleTextColor: .black),selectedState: SegmentioState(backgroundColor: UIColor(red: 83.0/255.0, green: 117.0/255.0, blue: 252.0/255.0, alpha: 1.0),titleFont: UIFont.systemFont(ofSize: UIFont.smallSystemFontSize),titleTextColor: .white),highlightedState: SegmentioState(backgroundColor: UIColor.lightGray.withAlphaComponent(0.6),titleFont:UIFont.boldSystemFont(ofSize: UIFont.smallSystemFontSize),titleTextColor: .black)), animationDuration: 0.1))
    
        segmentioView.selectedSegmentioIndex = 0
        
        let imageTapGesture = UITapGestureRecognizer(target: self, action: #selector(tapUserPhoto(_:)))
        imageTapGesture.delegate = self
        scan_back_ImageView.addGestureRecognizer(imageTapGesture)
        imageTapGesture.numberOfTapsRequired = 1
        scan_back_ImageView.isUserInteractionEnabled = true
        pickerController.delegate = self
        
        
    }
        
    @objc func tapUserPhoto(_ sender: UITapGestureRecognizer){
        let alertViewController = UIAlertController(title: "", message: "Choose your option", preferredStyle: .actionSheet)
        let camera = UIAlertAction(title: "Camera", style: .default, handler: { (alert) in
            self.openCamera()
        })
        let gallery = UIAlertAction(title: "Gallery", style: .default) { (alert) in
            self.openGallary()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (alert) in

        }
        alertViewController.addAction(camera)
        alertViewController.addAction(gallery)
        alertViewController.addAction(cancel)
        self.present(alertViewController, animated: true, completion: nil)
        
    }
        
        func openCamera() {
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
                pickerController.delegate = self
                self.pickerController.sourceType = UIImagePickerController.SourceType.camera
                pickerController.allowsEditing = true
                self .present(self.pickerController, animated: true, completion: nil)
            }
            else {
                let alertWarning = UIAlertView(title:"Warning", message: "You don't have camera", delegate:nil, cancelButtonTitle:"OK", otherButtonTitles:"")
                alertWarning.show()
            }
        }
        
        func openGallary() {
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
                pickerController.delegate = self
                pickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
                pickerController.allowsEditing = true
                self.present(pickerController, animated: true, completion: nil)
            }
        }
    
        public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {

            imageView = info[[UIImagePickerController.InfoKey.editedImage.self]] as! UIImage
            scan_back_ImageView.contentMode = .scaleAspectFill
            scan_back_ImageView.image = imageView
            dismiss(animated:true, completion: nil)
        }
        public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            print("Cancel")
        }
        
    
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
     
}


