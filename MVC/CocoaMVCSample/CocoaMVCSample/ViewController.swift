//
//  ViewController.swift
//  CocoaMVCSample
//
//  Created by 史翔新 on 2018/11/07.
//  Copyright © 2018年 史翔新. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	var myModel: Model? {
		didSet {
            // ViewとModelとを結合し、Modelの監視を開始する
            print("呼ばれた？")
			registerModel()
		}
	}
	
	private(set) lazy var myView: View = View()
	
	override func loadView() {
		view = myView
	}
	
	deinit {
		myModel?.notificationCenter.removeObserver(self)
	}
	
	private func registerModel() {
		
        print("ここは何度呼ばれるのか")

		guard let model = myModel else { return }
		
		myView.label.text = model.count.description
		
		myView.minusButton.addTarget(self, action: #selector(onMinusTapped), for: .touchUpInside)
		myView.plusButton.addTarget(self, action: #selector(onPlusTapped), for: .touchUpInside)
		
		model.notificationCenter.addObserver(forName: .init(rawValue: "count"),
											 object: nil,
											 queue: nil,
											 using: { [unowned self] notification in
												if let count = notification.userInfo?["count"] as? Int {
													self.myView.label.text = "\(count)"
												}
		})
		
	}
	
	@objc func onMinusTapped() {
        print("マイナスされる")
		myModel?.countDown()
	}
	
	@objc func onPlusTapped() {
        print("プラスされる")
		myModel?.countUp()
	}
	
}


