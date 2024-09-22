//
//  ProfileRouter.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 10.07.2024.
//

import UIKit


protocol ProfileRouterProtocol: AnyObject {
    func navigateToLoginView(haptic: HapticFeedback)
    func navigateToRatedMoviesView(networkManager: NetworkManager, imageDownloader: ImageDownloader, sessionId: String, haptic: HapticFeedback, accountId: Int)
    func navigateToFavoriteMoviesView(networkManager: NetworkManager, imageDownloader: ImageDownloader, sessionId: String, haptic: HapticFeedback, accountId: Int)
}


class ProfileRouter {
    //MARK: - property
    weak var view: ProfileViewController?
}
//MARK: - ProfileRouterProtocol
extension ProfileRouter: ProfileRouterProtocol {
    func navigateToFavoriteMoviesView(networkManager: NetworkManager, imageDownloader: ImageDownloader, sessionId: String, haptic: HapticFeedback, accountId: Int) {
        let favMoviesVC = FavoriteMoviesModuleBuilder.build(networkManager: networkManager, imageDownloader: imageDownloader, sessionId: sessionId, haptic: haptic, accountId: accountId)
        view?.navigationController?.pushViewController(favMoviesVC, animated: true)
    }
    
    func navigateToRatedMoviesView(networkManager: NetworkManager, imageDownloader: ImageDownloader, sessionId: String, haptic: HapticFeedback, accountId: Int) {
        let ratedMoviesVC = RatedMoviesModuleBuilder.build(networkManager: networkManager, imageDownloader: imageDownloader, sessionId: sessionId, haptic: haptic, accountId: accountId)
        view?.navigationController?.pushViewController(ratedMoviesVC, animated: true)
    }
    func navigateToLoginView(haptic: HapticFeedback) {
        let loginVC = LoginModulBuilder.build(haptic: haptic)
        loginVC.hidesBottomBarWhenPushed = true
        view?.navigationController?.pushViewController(loginVC, animated: true)
    }
}
