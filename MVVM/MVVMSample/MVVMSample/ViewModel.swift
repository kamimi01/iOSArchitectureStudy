//
//  ViewModel.swift
//  MVVMSample
//
//  Created by Mika Urakawa on 2022/03/08.
//

import Foundation
import UIKit

extension Notification.Name {
    static let changeText = Notification.Name("changeText")
    static let changeColor = Notification.Name("changeColor")
}

final class ViewModel {
    private let notificationCenter: NotificationCenter
    private let model: ModelProtocol

    init(notificationCenter: NotificationCenter, model: ModelProtocol = Model()) {
        self.notificationCenter = notificationCenter
        self.model = model
    }

    func idPasswordChanged(id: String?, password: String?) {
        // Viewからイベントを受け取り、Modelの処理を呼び出す
        let result = model.validate(idText: id, passwordText: password)

        // Viewからイベントを受け取り、加工して値を更新する
        switch result {
        case .success:
            notificationCenter.post(name: .changeText, object: "OK!!")
            notificationCenter.post(name: .changeColor, object: UIColor.green)
        case .failure(let error):
            notificationCenter.post(name: .changeText, object: error.errorText)
            notificationCenter.post(name: .changeColor, object: UIColor.red)
        }
    }
}

extension ModelError {
    fileprivate var errorText: String {
        switch self {
        case .invalidIdAndPassword:
            return "IDとPasswordが未入力です"
        case .invalidId:
            return "IDが未入力です"
        case .invalidPassword:
            return "Passwordが未入力です"
        }
    }
}
