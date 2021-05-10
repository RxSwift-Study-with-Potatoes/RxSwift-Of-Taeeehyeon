//
//  SceneDelegate.swift
//  RxLoginValidation
//
//  Created by taehy.k on 2021/05/07.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        let coordinator = Coordinator(window: window!)
        coordinator.start()
    }


}

