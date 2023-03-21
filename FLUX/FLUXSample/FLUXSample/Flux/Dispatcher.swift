//
//  Dispatcher.swift
//  FLUXSample
//
//  Created by mikaurakawa on 2023/03/21.
//

import Foundation

typealias DispatchToken = String

class Dispatcher {
    // 1つのコンテキストに対して1つだけ存在するものなので、シングルトンにする
    static let shared = Dispatcher()

    let lock: NSLocking  // 複数のスレッドからAction がDispatchされる可能性があるので、排他制御が必要
    private var callbacks: [DispatchToken: (Action) -> ()]

    init() {
        self.lock = NSRecursiveLock()
        self.callbacks = [:]
    }

    func register(callback: @escaping (Action) -> ()) -> DispatchToken {
        lock.lock(); defer { lock.unlock() }

        let token = UUID().uuidString
        callbacks[token] = callback
        return token  // 登録を解除するためのトークン
    }

    func unregister(_ token: DispatchToken) {
        lock.lock(); defer { lock.unlock() }

        callbacks.removeValue(forKey: token)
    }

    func dispatch(_ action: Action) {
        lock.lock(); defer { lock.unlock() }

        callbacks.forEach { _, callback in
            callback(action)
        }
    }
}
