//
//  Model.swift
//  CocoaMVCSample
//
//  Created by Mika Urakawa on 2021/05/23.
//

import Foundation

final class Model {
    let notificationCenter = NotificationCenter()
    private(set) var count = 0 {
        didSet {
            notificationCenter.post(name: .init(rawValue: "count"),
                                    object: nil,
                                    userInfo: ["count": count])
        }
    }

    func countDown() { count -= 1 }
    func countUp() { count += 1 }
}
