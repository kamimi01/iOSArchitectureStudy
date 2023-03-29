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

    private let selectedStore: SelectedRepositoryStore = .shared

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let repository = selectedStore.repository else { return }
        webview.load(URLRequest(url: repository.htmlURL))
    }
}
