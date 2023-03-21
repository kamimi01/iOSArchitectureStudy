//
//  Store.swift
//  FLUXSample
//
//  Created by mikaurakawa on 2023/03/22.
//

import Foundation

typealias Subscription = NSObjectProtocol

// 基底クラスのStore
class Store {
    private enum NotificationName {
        static let storeChanged = Notification.Name("store-changed")
    }

    /// callback を登録
    private lazy var dispatchToken: DispatchToken = {
        return dispatcher.register(callback: { [weak self] action in
            guard let self = self else { return }
            self.onDispatch(action)
        })
    }()

    private let notificationCenter: NotificationCenter
    private let dispatcher: Dispatcher

    init(dispatcher: Dispatcher) {
        self.dispatcher = dispatcher
        self.notificationCenter = NotificationCenter()
        _ = dispatchToken
    }

    deinit {
        dispatcher.unregister(dispatchToken)
    }

    /// 受け取ったAction を処理する。サブクラスでoverrideしてもらい、Actionごとの処理を行う
    func onDispatch(_ action: Action) {
        fatalError("must override")
    }

    /// Storeの変更をNotification.Name("store-changed")として送信する
    final func emitChange() {
        notificationCenter.post(name: NotificationName.storeChanged, object: nil)
    }

    /// ViewがStoreの変更を監視する
    final func addListener(callback: @escaping () -> ()) -> Subscription {

    }

    /// ViewがStoreの監視を中止する
    final func removeListener(_ subscription: Subscription) {
        
    }
}
