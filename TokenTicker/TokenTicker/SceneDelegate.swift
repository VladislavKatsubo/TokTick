//
//  SceneDelegate.swift
//  TokenTicker
//
//  Created by Vlad Katsubo on 7.03.23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: MainCoordinator?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        let appContext = AppContext.context()
        coordinator = MainCoordinator(window: window, appContext: appContext)
        coordinator?.start()
        
        self.window = window
    }
}
