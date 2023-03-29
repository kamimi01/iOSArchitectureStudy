//
//  SceneDelegate.swift
//  FLUXSample
//
//  Created by mikaurakawa on 2023/03/17.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private let selectedStore = SelectedRepositoryStore.shared

    private lazy var showRepositoryDetailSubscription: Subscription = {
        // TODO: タブバーやnav barのView側の実装をする必要がある
        // Storeに保持している選択されたリポジトリのデータを監視して、変更があったら遷移する
        return selectedStore.addListener { [weak self] in
            DispatchQueue.main.async {
                guard let self = self,
                      self.selectedStore.repository != nil,
//                      let rootViewController = self.window?.rootViewController,
//                      let tabBarController = rootViewController as? UITabBarController,
//                      let selectedViewController = tabBarController.selectedViewController,
//                      let navigationController = selectedViewController as? UINavigationController,
                      let navBar = self.window?.rootViewController as? UINavigationController
                else { return }

                // Store に保持しているリポジトリを表示するので、初期化時にデータは渡さない
                let viewController = RepositoryDetailViewController()
                navBar.pushViewController(viewController, animated: true)
            }
        }
    }()

    typealias LaunchOptions = [UIApplication.LaunchOptionsKey: Any]

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        //UIwindwosのアンラップ
        guard let windowScene = (scene as? UIWindowScene) else { return }

        //アンラップしたものWindwoSceceをselfに設定
        let window = UIWindow(windowScene:  windowScene)
        self.window = window

        //ルートビューを選択
        window.rootViewController = UINavigationController(rootViewController: RepositorySearchViewController())
        //「window」を最前線に表示する
        window.makeKeyAndVisible()

        _ = showRepositoryDetailSubscription
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

