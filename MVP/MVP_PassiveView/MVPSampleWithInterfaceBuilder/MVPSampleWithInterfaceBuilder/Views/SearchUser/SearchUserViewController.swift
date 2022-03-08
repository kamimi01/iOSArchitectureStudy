//
//  SearchUserViewController.swift
//  MVPSampleWithInterfaceBuilder
//
//  Created by Mika Urakawa on 2021/05/27.
//

import Foundation
import UIKit

class SearchUserViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    private var presenter: SearchUserPresenterInput!
    
    // presenterをDependency Injectionする
    func inject(presenter: SearchUserPresenterInput) {
        self.presenter = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("初回ロード")
        setup()
        
        searchBar.delegate = self
    }
    
    private func setup() {
        tableView.estimatedRowHeight = 64
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: "UserCell", bundle: nil), forCellReuseIdentifier: "UserCell")
    }
}

// 検索バーの挙動
extension SearchUserViewController: UISearchBarDelegate {
    // キーボードのsearcchボタンクリック時の挙動
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("searchボタンのタップ")
        presenter.didTapSearchButton(text: searchBar.text)
    }
}

extension SearchUserViewController: UITableViewDelegate {
    // セル選択時の挙動
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.didSelectRow(at: indexPath)
    }
}

extension SearchUserViewController: UITableViewDataSource {
    // 1セクションあたりのセル数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfUsers
    }
    
    // セル自体
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") as! UserCell
        
        // セルの行（indexPath.row）に応じたユーザーの情報をセットする
        if let user = presenter.user(forRow: indexPath.row) {
            cell.configure(user: user)
        }
        
        return cell
    }
}

extension SearchUserViewController: SearchUserPresenterOutput {
    // ユーザー情報が更新されたのでセルを更新
    func updateUsers(_ users: [User]) {
        tableView.reloadData()
    }
    
    // ユーザー詳細画面へ遷移する
    func transitionToUserDetail(userName: String) {
        let userDetailVC = UIStoryboard(
            name: "UserDetail",
            bundle: nil)
            .instantiateInitialViewController() as! UserDetailViewController
        
        // TODO: ユーザーのリポジトリ情報に関する処理
        
        navigationController?.pushViewController(userDetailVC, animated: true)
        
    }
}
