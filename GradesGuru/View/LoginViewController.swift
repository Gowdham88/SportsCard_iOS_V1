//
//  LoginViewController.swift
//  GradesGuru
//
//  Created by Superpower on 17/08/20.
//  Copyright © 2020 iMac superpower. All rights reserved.
//

import UIKit
import WebKit

class LoginViewController: UIViewController {
    
    var showB = true

    @IBOutlet weak var viewB: UIView!
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var path: String = Bundle.main.path(forResource: "/GradeGuru/Assets/OnboardingImage.svg", ofType: "svg")!

//        var url: NSURL = url.pa
//
//        //Creating a URL which points towards our path
//
//        //Creating a page request which will load our URL (Which points to our path)
//
//        var request: NSURLRequest = NSURLRequest(url: url as URL)
//        webView.load(request as URLRequest)  //Telling our webView to load our above request
//        // Do any additional setup after loading the view.
    }

}


