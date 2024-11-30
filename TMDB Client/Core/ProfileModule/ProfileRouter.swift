//
//  ProfileRouter.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 10.07.2024.
//

import UIKit


protocol ProfileRouterProtocol: AnyObject {
    func navigateToLoginView(haptic: HapticFeedback, networkManager: NetworkManager, imageDownloader: ImageDownloader, keychain: KeyChainManager)
    func navigateToRatedMoviesView(networkManager: NetworkManager, imageDownloader: ImageDownloader, sessionId: String, haptic: HapticFeedback, accountId: Int, keychain: KeyChainManager)
    func navigateToFavoriteMoviesView(networkManager: NetworkManager, imageDownloader: ImageDownloader, sessionId: String, haptic: HapticFeedback, accountId: Int, keychain: KeyChainManager)
}


class ProfileRouter {
    //MARK: - property
    weak var view: ProfileViewController?
}
//MARK: - ProfileRouterProtocol
extension ProfileRouter: ProfileRouterProtocol {
    func navigateToFavoriteMoviesView(networkManager: NetworkManager, imageDownloader: ImageDownloader, sessionId: String, haptic: HapticFeedback, accountId: Int, keychain: KeyChainManager) {
        let favMoviesVC = FavoriteMoviesModuleBuilder.build(networkManager: networkManager, imageDownloader: imageDownloader, sessionId: sessionId, haptic: haptic, accountId: accountId, keychain: keychain)
        view?.navigationController?.pushViewController(favMoviesVC, animated: true)
    }
    
    func navigateToRatedMoviesView(networkManager: NetworkManager, imageDownloader: ImageDownloader, sessionId: String, haptic: HapticFeedback, accountId: Int, keychain: KeyChainManager) {
        let ratedMoviesVC = RatedMoviesModuleBuilder.build(networkManager: networkManager, imageDownloader: imageDownloader, sessionId: sessionId, haptic: haptic, accountId: accountId, keychain: keychain)
        view?.navigationController?.pushViewController(ratedMoviesVC, animated: true)
    }
    func navigateToLoginView(haptic: HapticFeedback, networkManager: NetworkManager, imageDownloader: ImageDownloader, keychain: KeyChainManager) {
        let loginVC = LoginModulBuilder.build(haptic: haptic, networkManager: networkManager, imageDownloader: imageDownloader, keychain: keychain)
        loginVC.hidesBottomBarWhenPushed = true
        view?.navigationController?.pushViewController(loginVC, animated: true)
    }
}
