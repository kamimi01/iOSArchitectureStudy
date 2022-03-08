//
//  SearchUserPresenter.swift
//  MVPSampleWithInterfaceBuilder
//
//  Created by Mika Urakawa on 2021/05/27.
//

import Foundation

// Viewの描画で使用される変数（Presenterの処理）
protocol SearchUserPresenterInput {
    // ユーザーの数
    var numberOfUsers: Int { get }
    // ユーザーの情報
    func user(forRow row: Int) -> User?
    // セルタップ時
    func didSelectRow(at indexPath: IndexPath)
    // searchbarタップ時
    func didTapSearchButton(text: String?)
}

// 画面の描画処理を行う（Viewへの指示）
protocol SearchUserPresenterOutput: AnyObject {
    // ユーザの更新
    func updateUsers(_ users: [User])
    // ユーザー詳細への遷移
    func transitionToUserDetail(userName: String)
}

final class SearchUserPresenter: SearchUserPresenterInput {
    private(set) var users: [User] = []
    
    private weak var view: SearchUserPresenterOutput!
    private var model: SearchUserModelInput
    
    // viewとモデルをDependency Injectionのコンストラクタインジェクションを行う
    init(view: SearchUserPresenterOutput, model: SearchUserModelInput) {
        self.view = view
        self.model = model
    }
    
    var numberOfUsers: Int {
        return users.count
    }
    
    func user(forRow row: Int) -> User? {
        guard row < users.count else {
            return nil
        }
        return users[row]
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        guard let user = user(forRow: indexPath.row) else {
            return
        }
        view.transitionToUserDetail(userName: user.login)
    }
    
    func didTapSearchButton(text: String?) {
        guard let query = text else {
            return
        }
        guard !query.isEmpty else {
            return
        }
        
        // モデルのインターフェースであるユーザー情報取得の関数を呼び出し
        model.fetchUser(query: query) { [weak self] result in
            switch result {
            case .success(let users):
                self?.users = users
                
                DispatchQueue.main.async {
                    self?.view.updateUsers(users)
                }
            case .failure(let error):
                // TODO: エラーハンドリング（アラート画面を表示するなど）
                print(error)
            }
        }
    }
}
