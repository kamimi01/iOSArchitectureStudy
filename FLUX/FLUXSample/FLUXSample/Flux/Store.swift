//
//  Store.swift
//  FLUXSample
//
//  Created by mikaurakawa on 2023/03/22.
//

import Foundation

typealias Subscription = NSObjectProtocol

// FIXME: 本当はクラスではなく、protocol にしたい
/// 基底クラスのStoreで、Disptcherから受け取ったActionに応じた処理をして、Viewに伝える
class Store {
    private enum NotificationName {
        static let storeChanged = Notification.Name("store-changed")
    }

    /// callback を登録
    private lazy var dispatchToken: DispatchToken = {
        print("dispatchTokenが生成された")
        return dispatcher.register(callback: { [weak self] action in
            // callbackがActionを受け取ると、ここの処理が始まる→これは Dispatcherクラスの dispatch メソッドで実行される
            guard let self = self else { return }
            print("受け取ったActionを処理する")
            self.onDispatch(action)
        })
    }()

    private let notificationCenter: NotificationCenter
    private let dispatcher: Dispatcher

    init(dispatcher: Dispatcher) {
        self.dispatcher = dispatcher
        self.notificationCenter = NotificationCenter()
        _ = dispatchToken // Property is accessed but result is unusedの警告を無視するために _ = を使う
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
        print("変更を通知する")
        notificationCenter.post(name: NotificationName.storeChanged, object: nil)
    }

    /// ViewがStoreの変更を監視する
    final func addListener(callback: @escaping () -> ()) -> Subscription {
        print("変更を監視中")
        let using: (Notification) -> () = { notification in
            if notification.name == NotificationName.storeChanged {
                print("callbackを呼び出す")
                callback()
            }
        }
        return notificationCenter.addObserver(
            forName: NotificationName.storeChanged,
            object: nil,
            queue: nil,
            using: using
        )
    }

    /// ViewがStoreの監視を中止する
    final func removeListener(_ subscription: Subscription) {
        notificationCenter.removeObserver(subscription)
    }
}
