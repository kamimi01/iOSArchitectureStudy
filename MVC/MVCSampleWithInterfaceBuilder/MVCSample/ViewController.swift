//
//  ViewController.swift
//  MVCSample
//
//  Created by Mika Urakawa on 2021/05/16.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var customView = CustomView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // このViewControllerのviewをcustomViewに置き換え
        view = customView
        // ここで外部からViewにModelを渡す
        customView.myModel = Model()
    }
}

