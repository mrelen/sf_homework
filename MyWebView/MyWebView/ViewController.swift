//
//  ViewController.swift
//  MyWebView
//
//  Created by OneClick on 17/6/23.
//

import UIKit
import WebKit

class ViewController: UIViewController {
   
    @IBOutlet weak var webKitView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let stringUrl = "https://myru.online"
        let url = URL(string: stringUrl)!
        let request = URLRequest(url: url)
        
       
            
            webKitView.load(request)
            
    }
    

    
}
