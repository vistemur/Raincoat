//
//  SceneDelegate.swift
//  Raincoat
//
//  Created by Roman Pozdnyakov on 04.06.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        let viewController = InitialScreenViewController.assemble(window: window)
        window.rootViewController = viewController
        self.window = window
        window.makeKeyAndVisible()
    }
}
