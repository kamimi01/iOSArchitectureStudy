//
//  ViewController.swift
//  MVCSample
//
//  Created by Mika Urakawa on 2021/05/16.
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

    private lazy var customView = CustomView()

	override func loadView() {
		view = customView
	}
	
	deinit {
		myModel?.notificationCenter.removeObserver(self)
	}
	
	private func registerModel() {
		
        print("ここは何度呼ばれるのか")

		guard let model = myModel else { return }
		
        customView.label.text = model.count.description
		
        customView.minusButton.addTarget(self, action: #selector(onMinusTapped), for: .touchUpInside)
        customView.plusButton.addTarget(self, action: #selector(onPlusTapped), for: .touchUpInside)
		
		model.notificationCenter.addObserver(forName: .init(rawValue: "count"),
											 object: nil,
											 queue: nil,
											 using: { [unowned self] notification in
												if let count = notification.userInfo?["count"] as? Int {
													self.customView.label.text = "\(count)"
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


