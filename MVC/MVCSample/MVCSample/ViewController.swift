//
//  ViewController.swift
//  MVCSample
//
//  Created by Mika Urakawa on 2021/05/16.
//

import UIKit

class ViewController: UIViewController {

    private lazy var myView = View()
        
    override func loadView() {
        view = myView
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // ここで外部から View に Model を渡している
        myView.myModel = Model()
    }


}

