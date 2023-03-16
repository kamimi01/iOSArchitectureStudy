//
//  ViewController.swift
//  FLUXSample
//
//  Created by mikaurakawa on 2023/03/17.
//

import UIKit

class RepositorySearchViewController: UIViewController {

    private let searchField = UISearchBar()

    override func viewDidLoad() {
        super.viewDidLoad()

        let screenWidth = self.view.frame.width
        let screenHeight = self.view.frame.height

        searchField.frame = CGRect(x: 0, y: screenHeight / 4, width: screenWidth, height: 50)
        searchField.delegate = self

        self.view.addSubview(searchField)
    }
}

extension RepositorySearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("検索ボタンが押された！")
    }

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        print("テキストフィールド入力開始")
        return true
    }
}
