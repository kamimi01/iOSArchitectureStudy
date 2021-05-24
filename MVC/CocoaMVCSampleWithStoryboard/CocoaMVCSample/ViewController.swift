//
//  ViewController.swift
//  CocoaMVCSample
//
//  Created by Mika Urakawa on 2021/05/23.
//

import UIKit

class ViewController: UIViewController {

    // xibのFile's Ownerにクラスを指定したViewをコードで生成
    private lazy var customView = CustomView()

    var myModel: Model? {
        didSet {
            // ViewとModelとを結合し、Modelの監視を開始する
            print("何か変わった")
            registerModel()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = customView
        print("何も呼ばれてない？")
    }
    
    deinit {
        myModel?.notificationCenter.removeObserver(self)
    }
    
    private func registerModel() {
        guard let model = myModel else { return }
        print("テストよ")
        
        customView.label.text = model.count.description
        
        customView.minusButton.addTarget(self, action: #selector(onMinusTapped), for: .touchUpInside)
        
        customView.plusButton.addTarget(self, action: #selector(onPlusTapped), for: .touchUpInside)
        
        model.notificationCenter.addObserver(forName: .init(rawValue: "count"),
                                             object: nil,
                                             queue: nil,
                                             using: {
                                                [unowned self] notification in
                                                if let count = notification.userInfo?["count"] as? Int {
                                                    self.customView.label.text = count.description
                                                }
                                             })

    }
    
    @objc func onMinusTapped() {
        print("マイナス")
        myModel?.countDown()
    }
    
    @objc func onPlusTapped() {
        print("プラス")
        myModel?.countUp()
    }
    
}
