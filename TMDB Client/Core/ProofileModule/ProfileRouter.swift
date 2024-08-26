//
//  ProfileRouter.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 10.07.2024.
//

import UIKit


protocol ProfileRouterProtocol: AnyObject {
    func navigateToLoginView(haptic: HapticFeedback)
}


class ProfileRouter {
    //MARK: - property
    weak var view: ProfileViewController?
}
//MARK: - ProfileRouterProtocol
extension ProfileRouter: ProfileRouterProtocol {
    func navigateToLoginView(haptic: HapticFeedback) {
        let loginVC = LoginModulBuilder.build(haptic: haptic)
        loginVC.hidesBottomBarWhenPushed = true
        view?.navigationController?.pushViewController(loginVC, animated: true)
    }
}
