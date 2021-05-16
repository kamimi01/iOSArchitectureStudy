//
//  Controller.swift
//  MVCSample
//
//  Created by Mika Urakawa on 2021/05/16.
//

import Foundation
// UIに関する処理は行わないため、UIKitはインポートしない！

class Controller {
    // Modelへ更新処理を依頼するため、Modelをプロパティとして保持する
    weak var myModel: Model?
    // 必須イニシャライザ｜Required Initializerであり、サブクラスでの実装が必須となる
    required init() {}
    
    // Viewで定義するUIButtonのタップイベントを直接受け取るために、@objc修飾子をつける
    @objc func onMinusTapped() {
        myModel?.countDown()
    }
    @objc func onPlusTapped() {
        myModel?.countUp()
    }
}
