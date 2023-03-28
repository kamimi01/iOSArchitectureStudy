//
//  ViewController.swift
//  FLUXSample
//
//  Created by mikaurakawa on 2023/03/17.
//

import UIKit

class RepositorySearchViewController: UIViewController {
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

    // FIXME: 本当は init() メソッドの中で呼びたいが、呼べなかったのでここで代入する
    private var actionCreator: ActionCreator = .init()
    private var searchStore: SearchRepositoryStore = .shared

    private lazy var reloadSubscription: Subscription = {
        return searchStore.addListener { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }()

    private var repositories: [Repository] {
        return searchStore.repositories
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()

        _ = reloadSubscription
    }

    private func setup() {
        searchBar.delegate = self

        view.addSubview(searchBar)

        let screenWidth = self.view.frame.width

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
        guard let text = searchBar.text else { return }
        if text.isEmpty { return }

        print("1. ActionCreatorが呼ばれる")
        actionCreator.clearRepository()
        actionCreator.searchRepositories(query: text)
    }
}

extension RepositorySearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        repositories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = repositories[indexPath.row].name
        cell.contentConfiguration = content
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("押された")
        let repository = searchStore.repositories[indexPath.row]
        actionCreator.setSelectedRepository(repository)
    }
}
