//
//  SceneDelegate.swift
//  GroupedTableView
//
//  Created by Evgenii Kolgin on 19.05.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        window.makeKeyAndVisible()
        let networkManager: Networking = NetworkManager()
        let viewModel = FilmListViewModel(networkManager: networkManager)
        
        window.rootViewController = UINavigationController(rootViewController: FilmListViewController(viewModel))
        self.window = window
    }
}

