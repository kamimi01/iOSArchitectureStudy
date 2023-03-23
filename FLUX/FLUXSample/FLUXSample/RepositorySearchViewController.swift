//
//  ViewController.swift
//  FLUXSample
//
//  Created by mikaurakawa on 2023/03/17.
//

import UIKit

class RepositorySearchViewController: UIViewController {
    let avengers: [String] = ["ソー", "ドクター・ストレンジ", "アイアンマン", "キャプテン・マーベル", "スパイダーマン", "ハルク", "キャプテン・アメリカ"]

    private let searchBar: UISearchBar = {
        let view = UISearchBar(frame: .zero)
        return view
    }()

    private let tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    private func setup() {
        searchBar.delegate = self

        view.addSubview(searchBar)

        let screenWidth = self.view.frame.width
        let screenHeight = self.view.frame.height

        searchBar.frame = CGRect(x: 0, y: 100, width: screenWidth, height: 50)

        searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true

        tableView.delegate = self
        tableView.dataSource = self

        view.addSubview(tableView)

        tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
    }
}

extension RepositorySearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("サーチバーがタップされた")
    }
}

extension RepositorySearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        avengers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = avengers[indexPath.row]
        cell.contentConfiguration = content
        return cell
    }
}
