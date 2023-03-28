//
//  RepositoryDetailViewController.swift
//  FLUXSample
//
//  Created by mikaurakawa on 2023/03/29.
//

import Foundation
import UIKit
import WebKit

final class RepositoryDetailViewController: UIViewController {
    private let configuration = WKWebViewConfiguration()
    private lazy var webview = WKWebView(frame: .zero, configuration: configuration)

    private let selectedStore: SelectedRepositoryStore

    init(selectedStore: SelectedRepositoryStore = .shared) {
        self.selectedStore = selectedStore
        super.init(nibName: "RepositoryDetailViewController", bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let repository = selectedStore.repository else { return }
        webview.load(URLRequest(url: repository.htmlURL))
    }
}
