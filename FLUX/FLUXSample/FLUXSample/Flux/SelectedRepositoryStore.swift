//
//  SelectedRepositoryStore.swift
//  FLUXSample
//
//  Created by mikaurakawa on 2023/03/29.
//

import Foundation

final class SelectedRepositoryStore: Store {
    static let shared = SelectedRepositoryStore(dispatcher: .shared)
    private(set) var repository: Repository?

    override func onDispatch(_ action: Action) {
        switch action {
        case let .selectedRepository(repository):
            self.repository = repository
        default:
            return
        }
        emitChange()
    }
}
