//
//  Coordinator.swift
//  RxLoginValidation
//
//  Created by taehy.k on 2021/05/07.
//

import UIKit

class Coordinator {
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        window.rootViewController = LoginViewController()
        window.makeKeyAndVisible()
    }
}
