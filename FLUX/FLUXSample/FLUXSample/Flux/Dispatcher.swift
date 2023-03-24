//
//  Dispatcher.swift
//  FLUXSample
//
//  Created by mikaurakawa on 2023/03/21.
//

import Foundation

typealias DispatchToken = String

/// Viewからの入力を受け、ActionをStoreに送る
class Dispatcher {
    // 1つのコンテキストに対して1つだけ存在するものなので、シングルトンにする
    static let shared = Dispatcher()

    let lock: NSLocking  // 複数のスレッドからAction がDispatchされる可能性があるので、排他制御が必要
    private var callbacks: [DispatchToken: (Action) -> ()]

    init() {
        self.lock = NSRecursiveLock()
        self.callbacks = [:]
    }

    /// 処理をcallbacksの配列に登録する
    func register(callback: @escaping (Action) -> ()) -> DispatchToken {
        print("registerを実行する")
        lock.lock(); defer { lock.unlock() }

        let token = UUID().uuidString
        callbacks[token] = callback
        print("register終了")
        return token  // 登録を解除するためのトークン
    }

    /// 処理の登録を外す
    func unregister(_ token: DispatchToken) {
        lock.lock(); defer { lock.unlock() }

        callbacks.removeValue(forKey: token)
    }

    /// callbacksに登録されているすべてのcallbackにActionを伝える
    func dispatch(_ action: Action) {
        lock.lock(); defer { lock.unlock() }

        callbacks.forEach { _, callback in
            print("callbackにActionを伝える")
            callback(action)
        }
    }
}
