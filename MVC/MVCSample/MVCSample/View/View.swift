//
//  View.swift
//  MVCSample
//
//  Created by Mika Urakawa on 2021/05/16.
//

import Foundation
// UIKitを継承するのは、Viewのみ！
import UIKit

final class View: UIView {
    
    let label = UILabel()
    let minusButton = UIButton()
    let plusButton = UIButton()

    // Controllerのメタタイプを代入する
    var defaultControllerClass: Controller.Type = Controller.self
    private var myController: Controller?
    
    var myModel: Model? {
        didSet {
            // Controllerの生成とModelの監視を開始する
            registerModel()
        }
    }
    
    // オブジェクトが不要となったときに即座に実行されるコードブロック
    deinit {
        // ただし、removeObserver()はiOS9.0以降は不要
        myModel?.notificationCenter.removeObserver(self)
    }
    
    override init(frame: CGRect) {
        // 画面のレイアウト処理
        super.init(frame: frame)
        setSubviews()
        setLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    private func setSubviews() {
            
        addSubview(label)
        addSubview(minusButton)
        addSubview(plusButton)
        
        label.textAlignment = .center
        
        label.backgroundColor = .blue
        minusButton.backgroundColor = .red
        plusButton.backgroundColor = .green
        
        minusButton.setTitle("-1", for: .normal)
        plusButton.setTitle("+1", for: .normal)
        
    }
    
    private func setLayout() {
            
        label.translatesAutoresizingMaskIntoConstraints = false
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        minusButton.translatesAutoresizingMaskIntoConstraints = false
        
        label.topAnchor.constraint(equalTo: topAnchor).isActive = true
        label.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        label.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: minusButton.topAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: plusButton.topAnchor).isActive = true
        label.heightAnchor.constraint(equalTo: minusButton.heightAnchor).isActive = true
        label.heightAnchor.constraint(equalTo: plusButton.heightAnchor).isActive = true
        minusButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        plusButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        minusButton.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        minusButton.rightAnchor.constraint(equalTo: plusButton.leftAnchor).isActive = true
        plusButton.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        minusButton.widthAnchor.constraint(equalTo: plusButton.widthAnchor).isActive = true
        
    }
    
    private func registerModel() {
        guard let model = myModel else {
            return
        }
        
        // Controllerを生成する
        let controller = defaultControllerClass.init()
        controller.myModel = model
        
        myController = controller
        label.text = model.count.description
        
        // Controllerに入力を伝える
        minusButton.addTarget(controller, action: #selector(Controller.onMinusTapped), for: .touchUpInside)
        plusButton.addTarget(controller, action: #selector(Controller.onPlusTapped), for: .touchUpInside)
        
        // Modelから通知を受け取る
        model.notificationCenter.addObserver(forName: .init(rawValue: "count"),
                                             object: nil,
                                             // どのオブジェクトからの通知を受け取るか指定する（nilの場合は全オブジェクトから受け取る）
                                             queue: nil,
                                             using: {
                                                [unowned self] notification in
                                                if let count = notification.userInfo?["count"] as? Int {
                                                    self.label.text = count.description
                                                }
                                             })
    }
}
