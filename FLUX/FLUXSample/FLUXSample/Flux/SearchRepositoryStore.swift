//
//  SearchRepositoryStore.swift
//  FLUXSample
//
//  Created by mikaurakawa on 2023/03/23.
//

import Foundation

class SearchRepositoryStore: Store {
    /// Store コンポーネント自体は複数存在するが、SearchRepositoryStoreはアプリ上で一つ
    static let shared = SearchRepositoryStore(dispatcher: .shared)
    /// Storeでのみ変更可能で、外部にはgetterのみ公開する
    private(set) var repositories: [Repository] = []

    override func onDispatch(_ action: Action) {
        switch action {
        case let .addRepositories(repositories):
            self.repositories = repositories
        case .clearRepositories:
            self.repositories.removeAll()
        default:
            return
        }
        // 変更を通知する
        emitChange()
    }
}
