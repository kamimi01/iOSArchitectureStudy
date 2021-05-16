//
//  Model.swift
//  MVCSample
//
//  Created by Mika Urakawa on 2021/05/16.
//

import Foundation
// UIに関する処理は行わないため、UIKitはインポートしない！

final class Model {
    // Modelの状態更新を、ViewとControllerに通知する
    let notificationCenter = NotificationCenter()
    private(set) var count = 0 {
        // 変数（count）の値の変更があった場合に、変更後に呼ばれる（変更前に呼ぶ場合は、willSet）
        didSet {
            // countが更新されたら、NotificationCenterに通知を送る（postメソッドを呼ぶ）
            notificationCenter.post(name: .init(rawValue: "count"),
                                    object: nil,
                                    userInfo: ["count": count])
        }
    }
    
    // Controllerがcountを更新するためのメソッド
    func countDown() { count -= 1 }
    func countUp() { count += 1 }
}
