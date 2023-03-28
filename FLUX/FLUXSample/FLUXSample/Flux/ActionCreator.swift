//
//  ActionCreator.swift
//  FLUXSample
//
//  Created by mikaurakawa on 2023/03/17.
//

import Foundation

/// なんらかの処理を行なって、Actionを生成し、Dispatcherに送信する
class ActionCreator {
    /// Dispatcher
    private let dispatcher: Dispatcher
    /// APIクライアント
    private let apiSession: GitHubApiRequestable

    init(dispatcher: Dispatcher = .shared, apiSession: GitHubApiRequestable = GitHubApiSession.shared) {
        self.dispatcher = dispatcher
        self.apiSession = apiSession
    }
}

// MARK: - 検索
extension ActionCreator {
    /// レポジトリ検索
    func searchRepositories(query: String, page: Int = 1) {
        apiSession.searchRepositories(query: query, page: page) { [dispatcher] result in
            switch result {
            case let .success((repositories, _)):
                // Dispatcherに結果を渡す（ActionCreator自身がデータを保持することはしない）
                print("2. Dispatcher でデータをStore に伝える")
                dispatcher.dispatch(.addRepositories(repositories))
            case let .failure(error):
                // ログに出すだけ
                print(error)
            }
        }
    }

    /// 検索結果をクリアする
    func clearRepository() {
        dispatcher.dispatch(.clearRepositories)
    }
}

// MARK: - その他
extension ActionCreator {
    func setSelectedRepository(_ repository: Repository?) {
        dispatcher.dispatch(.selectedRepository(repository))
    }
}
