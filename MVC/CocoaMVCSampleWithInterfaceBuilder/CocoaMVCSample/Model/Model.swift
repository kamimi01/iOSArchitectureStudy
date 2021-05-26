//
//  Model.swift
//  CocoaMVCSample
//
//  Created by Mika Urakawa on 2021/05/25.
//  Copyright © 2021 史翔新. All rights reserved.
//

import Foundation

protocol ModelProtocol: AnyObject {
    func countDown()
    func countUp()
}

final class Model: ModelProtocol {
    
    let notificationCenter = NotificationCenter()
    
    private(set) var count = 0 {
        didSet {
            notificationCenter.post(name: .init(rawValue: "count"),
                                    object: nil,
                                    userInfo: ["count": count])
        }
    }
    
    func countDown() {
        count -= 1
    }
    
    func countUp() {
        count += 1
    }
    
}
