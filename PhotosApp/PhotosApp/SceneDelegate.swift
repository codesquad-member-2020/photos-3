//
//  SceneDelegate.swift
//  PhotosApp
//
//  Created by 임승혁 on 2020/03/16.
//  Copyright © 2020 임승혁. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            let rootViewController = PhotoViewController()
            window.rootViewController = UINavigationController(rootViewController: rootViewController)
            self.window = window
            window.makeKeyAndVisible()
        }
        
        guard let _ = (scene as? UIWindowScene) else { return }
    }
}
