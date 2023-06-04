//
//  ViewController.swift
//  MyCustomViewProject
//
//  Created by OneClick on 24/5/23.
//

import UIKit

class ViewController: UIViewController {

    var customViewElement: MyCustomView = MyCustomView(frame: CGRect (x: 87 ,
    y: 400, width: 240, height: 180))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customViewElement.labelText = "Changed"
        view.addSubview(customViewElement)
    }


}

