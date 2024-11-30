//
//  SceneDelegate.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 07.07.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    private let keychain = KeyChainManager()
    private let haptic = HapticFeedback()
    private var networkManager = NetworkManager()
    private var imageDownloader = ImageDownloader()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
      
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        
        if let session = keychain.get(for: Constants.sessionKey) {
            window?.rootViewController = TabBarController(sessionId: session, haptic: haptic, networkManager: networkManager, imageDownloader: imageDownloader, keychain: keychain)
        } else {
            window?.rootViewController = UINavigationController(rootViewController: LoginModulBuilder.build(haptic: haptic, networkManager: networkManager, imageDownloader: imageDownloader, keychain: keychain))
        }
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
     
    }

    func sceneWillResignActive(_ scene: UIScene) {
      
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    
    }

    func sceneDidEnterBackground(_ scene: UIScene) {

    }
}

