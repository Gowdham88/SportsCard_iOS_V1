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
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path: String = Bundle.main.path(forResource: "OnboardingImage", ofType: "svg")!

        let url: NSURL = NSURL.fileURL(withPath: path) as NSURL

        //Creating a URL which points towards our path

        //Creating a page request which will load our URL (Which points to our path)

        let request: NSURLRequest = NSURLRequest(url: url as URL)
        
//        webView. =
        webView.frame = CGRect(x: view.frame.width / 4, y: 50, width: view.frame.width, height: view.frame.height/4 + 50)
        webView.load(request as URLRequest)
        
        //Telling our webView to load our above request
        // Do any additional setup after loading the view.
    }

}


