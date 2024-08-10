//
//  ProfileRouter.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 10.07.2024.
//

import UIKit


protocol ProfileRouterProtocol: AnyObject {
    func navigateToLoginView()
}


class ProfileRouter {
    //MARK: - property
    weak var view: ProfileViewController?
}
//MARK: - ProfileRouterProtocol
extension ProfileRouter: ProfileRouterProtocol {
    func navigateToLoginView() {
        let loginVC = LoginModulBuilder.build()
        loginVC.hidesBottomBarWhenPushed = true
        view?.navigationController?.pushViewController(loginVC, animated: true)
    }
}
