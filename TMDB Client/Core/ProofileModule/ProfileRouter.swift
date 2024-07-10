//
//  ProfileRouter.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 10.07.2024.
//

import UIKit


protocol ProfileRouterProtocol: AnyObject {
    
}


class ProfileRouter {
    weak var view: ProfileViewController?
}
//MARK: - ProfileRouterProtocol
extension ProfileRouter: ProfileRouterProtocol {
    
}
