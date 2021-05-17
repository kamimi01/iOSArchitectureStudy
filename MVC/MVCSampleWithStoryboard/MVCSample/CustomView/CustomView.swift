//
//  CustomView.swift
//  MVCSample
//
//  Created by Mika Urakawa on 2021/05/17.
//

import Foundation
import UIKit

class CustomView: UIView {
    
    // Viewではなく、File's Ownerに対してCustomViewクラスを紐付ける
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    
    var defaultControllerClass: Controller.Type = Controller.self
    private var myController: Controller?
    
    var myModel: Model? {
        didSet {
            // ControllerとModelの監視を開始する
            registerModel()
        }
    }
    
    deinit {
        myModel?.notificationCenter.removeObserver(self)
    }
    
    // 他の場所で再利用可能にする
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
        setSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
        setSubViews()
    }
    
    private func loadNib() {
        if let view = Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self)?.first as? UIView {
            view.frame = self.bounds
            self.addSubview(view)
        }
    }
    
    private func setSubViews() {
        label.text = "0"
        plusButton.setTitle("+1", for: .normal)
        minusButton.setTitle("-1", for: .normal)
    }
    
    private func registerModel() {
        guard let model = myModel else {
            return
        }
        
        let controller = defaultControllerClass.init()
        controller.myModel = model
        myController = controller
        
        label.text = model.count.description
        
        minusButton.addTarget(controller, action: #selector(Controller.onMinusTapped), for: .touchUpInside)
        plusButton.addTarget(controller, action: #selector(Controller.onPlusTapped), for: .touchUpInside)
        
        model.notificationCenter.addObserver(forName: .init(rawValue: "count"),
                                             object: nil,
                                             queue: nil,
                                             using:
                                                {[unowned self] notification in
                                                    if let count = notification.userInfo?["count"] as? Int {
                                                        self.label.text = count.description
                                                    }
                                                })
    }
}
